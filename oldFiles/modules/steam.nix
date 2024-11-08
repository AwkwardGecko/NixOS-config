
	##################
	### MOUNT HOME ###
	##################

	{ config, pkgs, lib, ... }:

{
	programs.steam = {
		enable = true;				# Enable Steam
		gamescopeSession.enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
		localNetworkGameTransfers.openFirewall = true;
	};
}
