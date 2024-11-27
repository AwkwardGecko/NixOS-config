
	#############
	### FONTS ###
	#############

	{ config, pkgs, lib, ... }: {

	fonts.fontconfig.enable = true;

	home.packages = with pkgs; [
		#corefonts
		#dina-font
		fira-code
		fira-code-symbols
		font-awesome
		#gyre-fonts
		jetbrains-mono
		liberation_ttf
		#ipafont
		mplus-outline-fonts.githubRelease
		nerdfonts
		noto-fonts
		noto-fonts-emoji
		#noto-fonts-extra
		proggyfonts
		#ubuntu_font_famly
		#vazir-fonts
	];
}
