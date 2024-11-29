
	#################
	### BLUETOOTH ###
	#################

	{ config, pkgs, lib, ... }: {


   hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez5-experimental;
      settings.Policy.AutoEnable = "true";
      settings.General.Enable = "Source,Sink,Media,Socket";
   };
   services.blueman.enable = true;
   environment.systemPackages = with pkgs; [
        bluez5-experimental 
        bluez-tools
        bluez-alsa
        bluetuith # can transfer files via OBEX
      ];
};}


   #    hardware.bluetooth = {
   #      enable = true;
   #      powerOnBoot = true;
   #    };
	  # services.blueman.enable = true;

	# environment.systemPackages = with pkgs; [
	#	bluez
	#	bluez-alsa
	#	bluez-tools
	# ];
}
