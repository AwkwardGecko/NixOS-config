	
	#############
	### KITTY ###
	#############

	{ config, pkgs, lib, ... }: {

	programs.kitty = {
		enable = true;
		shellIntegration.enableFishIntegration = true;
					
		settings = {
			shell = "fish";
		};

		font.name = "JetBrainsMono"
		themeFile = "GruvboxMaterialDarkMedium";
	};
}
