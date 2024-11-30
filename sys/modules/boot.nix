
	############
	### BOOT ###
	############

	{ config, pkgs, lib, ... }:
{
	boot.loader = {
		systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    boot.extraModulePackages = with config.boot.kernelPackages; [
        btusb
    ];
}
