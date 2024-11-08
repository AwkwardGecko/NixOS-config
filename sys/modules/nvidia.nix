
	##############
	### NVIDIA ###
	##############

	{ config, pkgs, lib, ... }: {
	
	hardware = {
		
		nvidia = {
			modesetting.enable = true;
			open = true;
			nvidiaSettings = true;
			powerManagement.enable = false;
			powerManagement.finegrained = false;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
		};
		
		graphics = {
			enable = true;
			enable32Bit = true;
		};

	};
}
