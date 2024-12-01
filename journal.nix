I've got a real head scratcher here, and I'm bashing my head against a wall.

I cannot connect my Xbox controller to my computer. This isn't necessarily a NixOS issue, as I encounter the same issues on my EndeavourOS partition.

my config file:
```
{
   hardware = { 
      enableAllFirmware = true;
      bluetooth = {
         enable = true;
         powerOnBoot = true;
         settings.General.Experimental = true;
   };

   services.blueman.enable = true;
   environment.systemPackages = with pkgs; [
      bluez
      bluez-alsa
      bluez-tools
   ];
}
```
Plugging the controller in with a cable is fine, and I have no trouble.

Starting with bluetoothctl:
```
[bluetooth]# hci0 new_settings: powered connectable discoverable bondable ssp br/edr le secure-conn wide-band-speech 
[bluetooth]# [CHG] Controller 50:2F:9B:B1:CD:B1 Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# power on
[bluetooth]# Changing power on succeeded
[bluetooth]# agent on
Agent is already registered
[bluetooth]# default-agent
[bluetooth]# Default agent request successful
[bluetooth]# scan on
[bluetooth]# SetDiscoveryFilter success
[bluetooth]# Discovery started
[bluetooth]# [CHG] Controller 50:2F:9B:B1:CD:B1 Discovering: yes
[bluetooth]# [NEW] Device AC:8E:BD:31:ED:3D Xbox Wireless Controller
[bluetooth]# pair AC:8E:BD:31:ED:3D 
Attempting to pair with AC:8E:BD:31:ED:3D
[bluetooth]# [CHG] Device AC:8E:BD:31:ED:3D Connected: yes
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D Bonded: yes
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D UUIDs: 00000001-5f60-4c4f-9c83-a7953298d40d
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D UUIDs: 0000180f-0000-1000-8000-00805f9b34fb
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D UUIDs: 00001812-0000-1000-8000-00805f9b34fb
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D ServicesResolved: yes
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D Paired: yes
[Xbox Wireless Controller]# [NEW] Primary Service (Handle 0x0008)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0008
	00001801-0000-1000-8000-00805f9b34fb
	Generic Attribute Profile
[Xbox Wireless Controller]# [NEW] Primary Service (Handle 0x0009)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0009
	0000180a-0000-1000-8000-00805f9b34fb
	Device Information
[Xbox Wireless Controller]# [NEW] Characteristic (Handle 0x000a)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0009/char000a
	00002a29-0000-1000-8000-00805f9b34fb
	Manufacturer Name String
[Xbox Wireless Controller]# [NEW] Characteristic (Handle 0x000c)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0009/char000c
	00002a50-0000-1000-8000-00805f9b34fb
	PnP ID
[Xbox Wireless Controller]# [NEW] Characteristic (Handle 0x000e)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0009/char000e
	00002a26-0000-1000-8000-00805f9b34fb
	Firmware Revision String
[Xbox Wireless Controller]# [NEW] Characteristic (Handle 0x0010)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0009/char0010
	00002a25-0000-1000-8000-00805f9b34fb
	Serial Number String
[Xbox Wireless Controller]# [NEW] Primary Service (Handle 0x0012)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0012
	0000180f-0000-1000-8000-00805f9b34fb
	Battery Service
[Xbox Wireless Controller]# [NEW] Characteristic (Handle 0x0013)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0012/char0013
	00002a19-0000-1000-8000-00805f9b34fb
	Battery Level
[Xbox Wireless Controller]# [NEW] Descriptor (Handle 0x2e0a)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0012/char0013/desc0015
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
[Xbox Wireless Controller]# [NEW] Primary Service (Handle 0x0024)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0024
	00000001-5f60-4c4f-9c83-a7953298d40d
	Vendor specific
[Xbox Wireless Controller]# [NEW] Characteristic (Handle 0x0025)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0024/char0025
	00000002-5f60-4c4f-9c83-a7953298d40d
	Vendor specific
[Xbox Wireless Controller]# [NEW] Characteristic (Handle 0x0027)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0024/char0027
	00000003-5f60-4c4f-9c83-a7953298d40d
	Vendor specific
[Xbox Wireless Controller]# [NEW] Characteristic (Handle 0x0029)
	/org/bluez/hci0/dev_AC_8E_BD_31_ED_3D/service0024/char0029
	00000004-5f60-4c4f-9c83-a7953298d40d
	Vendor specific
[Xbox Wireless Controller]# Pairing successful
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D Modalias: usb:v045Ep0B13d0509
```
At this point, everything seems fine, and the controller is seen my Steam, but the moment I press any buttons, bluetoothctl throws the following output:
```

[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D ServicesResolved: no
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D Connected: no
[bluetooth]# [CHG] Device AC:8E:BD:31:ED:3D Connected: yes
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D Connected: no
[bluetooth]# [CHG] Device AC:8E:BD:31:ED:3D Connected: yes
[Xbox Wireless Controller]# [CHG] Device AC:8E:BD:31:ED:3D ServicesResolved: yes
```
It'll then get stuck in a loop between connecting and disconnecting rapidly. My notification daemon will fill up will overflow with connect/disconnect messages repeatedly.

Opening up Blueman displays the following error:
```
Connection Failed: le-connection-abort-by-local
```
Below are the outputs of all the commands I know which might produce anything of value. The only thing which I can see which might indicate something is wrong is that the battery level 

**/etc/bluetooth/main.conf** 
```
[General]
ControllerMode=dual
Experimental=true

[Policy]
AutoEnable=true
```
I've tried my best to find answers online, but I've had no luck.
**hciconfig:**
```
hci0:   Type: Primary  Bus: USB
	   BD Address: 50:2F:9B:B1:CD:B1  ACL MTU: 1021:4  SCO MTU: 96:6
	   UP RUNNING PSCAN ISCAN 
	   RX bytes:25961 acl:801 sco:0 events:493 errors:0
	   TX bytes:10739 acl:154 sco:0 commands:270 errors:0
```
**systemctl status bluetooth:**

```
● bluetooth.service - Bluetooth service
     Loaded: loaded (/etc/systemd/system/bluetooth.service; enabled; preset: ignored)
    Drop-In: /nix/store/vg3z06cijz74y8g9a6fbyiqaiyv9373p-system-units/bluetooth.service.d
             └─overrides.conf
     Active: active (running) since Sun 2024-12-01 20:58:00 AEDT; 25min ago
 Invocation: d42b4c140ca7418daba1806d0913d351
       Docs: man:bluetoothd(8)
   Main PID: 931 (bluetoothd)
     Status: "Running"
         IP: 0B in, 0B out
         IO: 2.5M read, 152K written
      Tasks: 1 (limit: 18916)
     Memory: 3.7M (peak: 4.4M)
        CPU: 199ms
     CGroup: /system.slice/bluetooth.service
             └─931 /nix/store/dl087c9ph8lni59k5qzibjz9ysj374g3-bluez-5.78/libexec/bluetooth/bluetoothd -f /etc/bluetooth/main.conf

Dec 01 21:04:18 z-nixos bluetoothd[931]: profiles/input/hog-lib.c:report_read_cb() Error reading Report value: Request attribute has encountered an unlikely error
Dec 01 21:04:18 z-nixos bluetoothd[931]: profiles/input/hog-lib.c:report_reference_cb() Read Report Reference descriptor failed: Request attribute has encountered an unlikely error
Dec 01 21:04:18 z-nixos bluetoothd[931]: profiles/input/hog-lib.c:report_read_cb() Error reading Report value: Request attribute has encountered an unlikely error
Dec 01 21:04:18 z-nixos bluetoothd[931]: profiles/input/hog-lib.c:report_reference_cb() Read Report Reference descriptor failed: Request attribute has encountered an unlikely error
Dec 01 21:11:43 z-nixos bluetoothd[931]: Path / reserved for Adv Monitor app :1.97
Dec 01 21:12:11 z-nixos bluetoothd[931]: src/device.c:device_set_wake_support() Unable to set wake_support without RPA resolution
Dec 01 21:12:39 z-nixos bluetoothd[931]: Adv Monitor app :1.97 disconnected from D-Bus
Dec 01 21:13:06 z-nixos bluetoothd[931]: Path / reserved for Adv Monitor app :1.98
Dec 01 21:14:10 z-nixos bluetoothd[931]: src/device.c:set_wake_allowed_complete() Set device flags return status: Invalid Parameters
Dec 01 21:14:14 z-nixos bluetoothd[931]: profiles/battery/battery.c:parse_battery_level() Trying to update an unregistered battery
```
**systemctl --global --user is-enabled obex:**
```
enabled
```
**journalctl -r -u bluetooth > /tmp/bluetoothd.out:**
```
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/opus_05_duplex
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSink/opus_05_duplex
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/opus_05
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSink/opus_05
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/faststream_duplex
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/faststream
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/aptx_ll_duplex_0
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/aptx_ll_duplex_1
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/aptx_ll_0
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/aptx_ll_1
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/sbc
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSink/sbc
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/opus_g
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSink/opus_g
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/aac
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSink/aac
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/aptx
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSink/aptx
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/aptx_hd
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSink/aptx_hd
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Endpoint registered: sender=:1.25 path=/MediaEndpoint/A2DPSource/ldac
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Battery Provider Manager created
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Bluetooth management interface 1.22 initialized
Nov 04 00:15:08 z-nixos bluetoothd[39068]: src/plugin.c:init_plugin() System does not support asha plugin
Nov 04 00:15:08 z-nixos bluetoothd[39068]: src/plugin.c:init_plugin() System does not support csip plugin
Nov 04 00:15:08 z-nixos bluetoothd[39068]: src/plugin.c:init_plugin() System does not support ccp plugin
Nov 04 00:15:08 z-nixos bluetoothd[39068]: src/plugin.c:init_plugin() System does not support micp plugin
Nov 04 00:15:08 z-nixos bluetoothd[39068]: profiles/audio/micp.c:micp_init() D-Bus experimental not enabled
Nov 04 00:15:08 z-nixos bluetoothd[39068]: src/plugin.c:init_plugin() System does not support vcp plugin
Nov 04 00:15:08 z-nixos bluetoothd[39068]: src/plugin.c:init_plugin() System does not support mcp plugin
Nov 04 00:15:08 z-nixos bluetoothd[39068]: src/plugin.c:init_plugin() System does not support bass plugin
Nov 04 00:15:08 z-nixos bluetoothd[39068]: src/plugin.c:init_plugin() System does not support bap plugin
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Starting SDP server
Nov 04 00:15:08 z-nixos systemd[1]: Started Bluetooth service.
Nov 04 00:15:08 z-nixos bluetoothd[39068]: Bluetooth daemon 5.78
Nov 04 00:15:08 z-nixos (uetoothd)[39068]: bluetooth.service: ConfigurationDirectory 'bluetooth' already exists but the mode is different. (File system: 755 ConfigurationDirectoryMode: 555)
Nov 04 00:15:08 z-nixos systemd[1]: Starting Bluetooth service...
```
**sudo systemctl list-units | grep blue:**

```
  sys-devices-pci0000:00-0000:00:02.1-0000:02:00.0-usb1-1\x2d5-1\x2d5:1.0-bluetooth-hci0.device         loaded active plugged   /sys/devices/pci0000:00/0000:00:02.1/0000:02:00.0/usb1/1-5/1-5:1.0/bluetooth/hci0
  sys-subsystem-bluetooth-devices-hci0.device                                                           loaded active plugged   /sys/subsystem/bluetooth/devices/hci0
  bluetooth.service                                                                                     loaded active running   Bluetooth service
  bluetooth.target                                                                                      loaded active active    Bluetooth Support
```
**rfkill list:**

```
0: hci0: Bluetooth
	Soft blocked: no
	Hard blocked: no
```
**btmgmt info:**
```
Index list with 1 item
hci0:	Primary controller
	addr 50:2F:9B:B1:CD:B1 version 11 manufacturer 2 class 0x7c0104
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr le advertising secure-conn debug-keys privacy configuration static-addr phy-configuration wide-band-speech 
	current settings: powered connectable discoverable ssp br/edr le secure-conn wide-band-speech 
	name z-nixos
	short name 
hci0:	Configuration options
	supported options: public-address 
	missing options: 
```
**hciconfig -a hci0:**
```
hci0:	Type: Primary  Bus: USB
	BD Address: 50:2F:9B:B1:CD:B1  ACL MTU: 1021:4  SCO MTU: 96:6
	UP RUNNING PSCAN ISCAN 
	RX bytes:25973 acl:801 sco:0 events:495 errors:0
	TX bytes:10759 acl:154 sco:0 commands:272 errors:0
	Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH SNIFF 
	Link mode: PERIPHERAL ACCEPT 
	Name: 'z-nixos'
	Class: 0x7c0104
	Service Classes: Rendering, Capturing, Object Transfer, Audio, Telephony
	Device Class: Computer, Desktop workstation
	HCI Version: 5.2 (0xb)  Revision: 0x2184
	LMP Version: 5.2 (0xb)  Subversion: 0x2184
	Manufacturer: Intel Corp. (2)
```
