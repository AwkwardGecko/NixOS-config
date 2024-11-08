	{self, pkgs, ...}: {

		extraPlugins = with pkgs.vimPlugins; [
			indent-blankline-nvim
		];

		plugins = {
		
			lsp = {
				enable = true;
				
				#servers = {
				#	tsserver.enable = true;
				#	lua-ls.enable = true;
				#	rust-analyzer.enable = true;
				#};
			};
			
			telescope.enable = true;
			oil.enable = true;
			luasnip.enable = true;
			treesitter.enable = true;
		};

		imports = [
			./bufferline.nix
		];
	
		colorschemes.gruvbox.enable = true;

		plugins = {
			lualine.enable = true;
		};
	}

