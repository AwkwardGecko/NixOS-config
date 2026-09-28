#!/usr/bin/env python3
import subprocess, sys, time
import gi
gi.require_version("Gst", "1.0")
gi.require_version("GdkPixbuf", "2.0")
from gi.repository import Gio, GLib, Gst, GdkPixbuf

X, Y, W, H = 900, 500, 40, 40   # watch region (monitor pixels)
MIN_HITS = 20                   # sampled red pixels required to trigger
COOLDOWN = 4.0                  # seconds between reel-in and recast

def is_red(r, g, b):
    return r > 170 and g < 70 and b < 70

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
request("SelectSources", (session,), "(oa{sv})",
        {"types": GLib.Variant("u", 1), "cursor_mode": GLib.Variant("u", 1)})
node = request("Start", (session, ""), "(osa{sv})", {})["streams"][0][0]

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
                                    False, 8, w, h, w * 3).savev("frame.png", "png", [], [])

def hits(smp, w):
    buf = smp.get_buffer()
    ok, m = buf.map(Gst.MapFlags.READ)
    d, c = m.data, 0
    for y in range(Y, Y + H, 2):
        row = (y * w + X) * 4
        for x in range(0, W, 2):
            i = row + x * 4
            c += is_red(d[i + 2], d[i + 1], d[i])
    buf.unmap(m)
    return c

def click():
    subprocess.run(["ydotool", "click", "0xC0"], check=False)  # left down+up

if "--dump" in sys.argv:
    while not (f := pull()):
        pass
    dump(*f)
    print("saved frame.png")
    sys.exit()

while True:
    f = pull()
    if f and hits(f[0], f[1]) >= MIN_HITS:
        click()                 # reel in
        time.sleep(COOLDOWN)
        click()                 # recast
        time.sleep(COOLDOWN)
    time.sleep(0.02)
