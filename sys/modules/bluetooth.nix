
	#################
	### BLUETOOTH ###
	#################

	{ config, pkgs, lib, ... }: {


      hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };

    services.blueman.enable = true
    


}   
      #services.blueman.enable = true;

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

