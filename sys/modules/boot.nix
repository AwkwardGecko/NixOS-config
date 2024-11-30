
	############
	### BOOT ###
	############

	{ config, pkgs, lib, ... }:
{
	boot.loader = {
		systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        extraModulePackages = with config.boot.kernelPackages; [
          btusb
        ];
	};
}
