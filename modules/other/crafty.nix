{
  config,
  lib,
  pkgs,
  ...
}: let
  craftyMac = "4C:24:98:FB:A7:86";
  craftyName = "STORZ&BICKEL";

  # bleak available to the script
  pythonEnv = pkgs.python3.withPackages (ps: [ps.bleak]);

  # The poller. Reads battery (+ temps) and writes JSON for the bar.
  craftyPoller = pkgs.writeScript "crafty-poll.py" ''
    #!${pythonEnv}/bin/python3
    import asyncio, json, os
    from bleak import BleakScanner, BleakClient

    NAME = "${craftyName}"
    BATTERY = "00000041-4c45-4b43-4942-265a524f5453"
    CUR_TEMP = "00000011-4c45-4b43-4942-265a524f5453"
    TGT_TEMP = "00000021-4c45-4b43-4942-265a524f5453"
    OUT = os.path.expanduser("~/.cache/crafty-battery.json")

    FAST_DELAY = 2     # seconds between polls while connected/successful
    SLOW_DELAY = 60    # seconds between retries while offline

    def read_last():
        try:
            with open(OUT) as f: return json.load(f)
        except Exception: return None

    def write(obj):
        os.makedirs(os.path.dirname(OUT), exist_ok=True)
        with open(OUT, "w") as f: json.dump(obj, f)

    def write_offline():
        last = read_last()
        if last and "percentage" in last:
            pct = last["percentage"]
            write({"text": f"{pct}%", "percentage": pct,
                   "tooltip": f"Crafty+ {pct}% (last known, offline)", "class": "stale"})
        else:
            write({"text": "", "tooltip": "Crafty offline", "class": "offline"})

async def poll_once():
        try:
            dev = await BleakScanner.find_device_by_name(NAME, timeout=8)
            if not dev:
                write_offline()
                return False
            async with BleakClient(dev, timeout=15) as c:
                await asyncio.sleep(1)
                batt = int.from_bytes(await c.read_gatt_char(BATTERY), "little")
                cur  = int.from_bytes(await c.read_gatt_char(CUR_TEMP), "little") / 10
                tgt  = int.from_bytes(await c.read_gatt_char(TGT_TEMP), "little") / 10
                write({"text": f"{batt}%", "percentage": batt,
                       "tooltip": f"Crafty+ {batt}%\nCurrent {cur:.1f}°C / Target {tgt:.1f}°C",
                       "class": "connected"})
                return True
        except Exception:
            write_offline()   # adapter off, scan fail, connect fail — all handled
            return False

    async def main():
        while True:
            ok = await poll_once()
            await asyncio.sleep(FAST_DELAY if ok else SLOW_DELAY)

    asyncio.run(main())
  '';
in {
  home-manager.users.zozano = {
    # Make bleak + the script available if you want to run it manually too
    home.packages = [
      pythonEnv
      pkgs.socat
      pkgs.jq
    ];

    systemd.user.services.crafty-battery = {
      Unit = {
        Description = "Poll Crafty+ battery over BLE";
        After = ["bluetooth.target"];
      };

      Service = {
        ExecStart = "${craftyPoller}";
        Restart = "always";
        RestartSec = "10s";
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
