{ config, lib, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		jellyfin-media-player
	];
};
