#!/run/current-system/sw/bin/python3
import math, os, subprocess, sys, time
os.environ["GI_TYPELIB_PATH"] = ":".join(filter(None, [
    "/run/current-system/sw/lib/girepository-1.0", os.environ.get("GI_TYPELIB_PATH")]))
os.environ["GST_PLUGIN_SYSTEM_PATH_1_0"] = ":".join(filter(None, [
    "/run/current-system/sw/lib/gstreamer-1.0", os.environ.get("GST_PLUGIN_SYSTEM_PATH_1_0")]))
import gi
gi.require_version("Gst", "1.0")
gi.require_version("GstApp", "1.0")
gi.require_version("GdkPixbuf", "2.0")
from gi.repository import Gio, GLib, Gst, GstApp, GdkPixbuf

CX, CY = 1280, 935     # hook icon centre
R_MIN, R_MAX = 65, 135 # ring band radii (px)
TRIGGER = -13          # mean (R-G) above this = bite (idle ~ -21, bite ~ -6)
MIN_PIXELS = 100       # bluish ring pixels needed for a valid reading
CONFIRM = 2            # consecutive frames above TRIGGER before clicking
COOLDOWN = 4.0         # seconds after reel-in
RECAST = False         # click again after cooldown to recast
HERE = os.path.dirname(os.path.abspath(__file__))

bus = Gio.bus_get_sync(Gio.BusType.SESSION)
sender = bus.get_unique_name()[1:].replace(".", "_")
DEST = ("org.freedesktop.portal.Desktop", "/org/freedesktop/portal/desktop",
        "org.freedesktop.portal.ScreenCast")
n = 0

def request(method, args, fmt, opts):
    global n
    n += 1
    opts["handle_token"] = GLib.Variant("s", f"t{n}")
    path = f"/org/freedesktop/portal/desktop/request/{sender}/t{n}"
    out, loop = {}, GLib.MainLoop()

    def cb(_c, _s, _p, _i, _sig, params):
        out["code"], out["data"] = params.unpack()
        loop.quit()

    sub = bus.signal_subscribe(None, "org.freedesktop.portal.Request", "Response",
                               path, None, Gio.DBusSignalFlags.NONE, cb)
    bus.call_sync(*DEST, method, GLib.Variant(fmt, (*args, opts)), None,
                  Gio.DBusCallFlags.NONE, -1)
    loop.run()
    bus.signal_unsubscribe(sub)
    if out["code"]:
        sys.exit("portal request cancelled")
    return out["data"]

session = request("CreateSession", (), "(a{sv})",
                  {"session_handle_token": GLib.Variant("s", "fishbot")})["session_handle"]

TOKEN = os.path.expanduser("~/.cache/fishbot_restore_token")
opts = {"types": GLib.Variant("u", 1), "cursor_mode": GLib.Variant("u", 1),
        "persist_mode": GLib.Variant("u", 2)}
if os.path.exists(TOKEN):
    opts["restore_token"] = GLib.Variant("s", open(TOKEN).read().strip())
request("SelectSources", (session,), "(oa{sv})", opts)
res = request("Start", (session, ""), "(osa{sv})", {})
if "restore_token" in res:
    os.makedirs(os.path.dirname(TOKEN), exist_ok=True)
    open(TOKEN, "w").write(res["restore_token"])
node = res["streams"][0][0]

reply, fdl = bus.call_with_unix_fd_list_sync(
    *DEST, "OpenPipeWireRemote", GLib.Variant("(oa{sv})", (session, {})), None,
    Gio.DBusCallFlags.NONE, -1, None, None)
fd = fdl.get(reply.unpack()[0])

Gst.init(None)
pipe = Gst.parse_launch(
    f"pipewiresrc fd={fd} path={node} ! videoconvert ! video/x-raw,format=BGRx ! "
    "appsink name=sink max-buffers=1 drop=true sync=false")
sink = pipe.get_by_name("sink")
pipe.set_state(Gst.State.PLAYING)

def pull():
    smp = sink.try_pull_sample(Gst.SECOND)
    if not smp:
        return None
    s = smp.get_caps().get_structure(0)
    return smp, s.get_value("width"), s.get_value("height")

def dump(smp, w, h):
    buf = smp.get_buffer()
    ok, m = buf.map(Gst.MapFlags.READ)
    d = m.data
    rgb = bytearray(w * h * 3)
    rgb[0::3], rgb[1::3], rgb[2::3] = d[2::4], d[1::4], d[0::4]
    buf.unmap(m)
    GdkPixbuf.Pixbuf.new_from_bytes(GLib.Bytes(bytes(rgb)), GdkPixbuf.Colorspace.RGB,
                                    False, 8, w, h, w * 3).savev(
        os.path.join(HERE, "frame.png"), "png", [], [])

def measure(smp, w):
    """(bluish pixel count, mean R-G) over the lower ring band around the hook."""
    buf = smp.get_buffer()
    ok, m = buf.map(Gst.MapFlags.READ)
    d, cnt, tot = m.data, 0, 0
    for y in range(CY - 30, CY + R_MAX + 1, 2):
        row = y * w * 4
        for x in range(CX - R_MAX, CX + R_MAX + 1, 2):
            if R_MIN <= math.hypot(x - CX, y - CY) <= R_MAX:
                i = row + x * 4
                b, g, r = d[i], d[i + 1], d[i + 2]
                if max(r, g, b) > 110 and b > r + 5:
                    cnt += 1
                    tot += r - g
    buf.unmap(m)
    return cnt, (tot / cnt if cnt else None)

def click():
    subprocess.run(["ydotool", "click", "0xC0"], check=False)  # left down+up, at current cursor

if "--dump" in sys.argv:
    while not (f := pull()):
        pass
    dump(*f)
    print("saved frame.png")
    sys.exit()

if "--click-test" in sys.argv:
    click()
    print("clicked once at the current cursor position")
    sys.exit()

watch = "--watch" in sys.argv   # print readings, never click
streak = 0
while True:
    f = pull()
    if f:
        cnt, mean = measure(f[0], f[1])
        if watch:
            print(f"pixels={cnt:5d}  meanRG={'n/a' if mean is None else round(mean, 1)}", flush=True)
        elif cnt >= MIN_PIXELS and mean is not None and mean > TRIGGER:
            streak += 1
            if streak >= CONFIRM:
                click()                 # reel in
                streak = 0
                time.sleep(COOLDOWN)
                if RECAST:
                    click()             # recast
                    time.sleep(COOLDOWN)
        else:
            streak = 0
    time.sleep(0.02)
