
	###########
	### GIT ###
	###########

	{ config, pkgs, lib, ... }: {

	programs.git = {
		enable = true;
		userName = "Zozano";
		userEmail = "private@private.com";
		extraConfig = {
			init.defaultBranch = "main";
		};
	};
}
