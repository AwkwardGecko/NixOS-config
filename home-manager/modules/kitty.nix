	
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

		font.name = "JetBrains Mono"
		themeFile = "GruvboxMaterialDarkMedium";
	};
}
