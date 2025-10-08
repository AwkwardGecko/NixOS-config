{ config, lib, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		adwaita-icon-theme
		hicolor-icon-theme
	];
}
