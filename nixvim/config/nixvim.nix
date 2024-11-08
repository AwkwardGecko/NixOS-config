
	{self, ...}: {
		imports = [
			./bufferline.nix
		];
	
		colorschemes.gruvbox.enable = true;

		plugins = {
			lualine.enable = true;
		};
	};
