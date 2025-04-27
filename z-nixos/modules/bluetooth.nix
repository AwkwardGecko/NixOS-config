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
  
  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   xpadneo
  # ];

  boot.extraModprobeConfig = '' bluetooth disable_ertm=1 '';
  boot.initrd.kernelModules = [ 
    "joydev"
    "uhid"
    # "hid_xpadneo"
  ];

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.xpadneo
    # bluez-experimental
    #bluez-alsa
    # bluez-tools
  ];

  # hardware.xpadneo.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      # MultiProfile = "multiple";
      # Experimental = true;
      Privacy = "device";
      JustWorksRepairing = "always";
      FastConnectable = "true";
      Class = "0x000100";
    };
  };

  # hardware.enableAllFirmware = true;

  services.blueman.enable = true;
}
