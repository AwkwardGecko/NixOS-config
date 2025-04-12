#################
### BLUETOOTH ###
#################

{
   config,
   pkgs,
   lib,
   ...
}:

{

  boot.blacklistedKernelModules = [ "xpad" ];
  

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.extraModprobeConfig = '' options bluetooth disable_ertm=1 '';
  boot.initrd.kernelModules = [ 
    "joydev"
    "uhid"
    "hid_xpadneo"
  ];

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.xpadneo
    #bluez-experimental
    #bluez-alsa
    #bluez-tools
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      Experimental = true;
      Privacy = "device";
      JustWorksRepairing = "always";
      FastConnectable = "true";
      Class = "0x000100";
    };
  };

  hardware.enableAllFirmware = true;

  services.blueman.enable = true;
}
