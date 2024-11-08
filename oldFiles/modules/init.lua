require("config.lazy")

--- require "options"
--- require "plugins"

vim.o.background = "dark" -- or "light" for light mode
 --- vim.cmd([[colorscheme gruvbox]])

vim.filetype.add({
	pattern = { 
		[".*/waybar/config"] = 'jsonc',
		[".*/mako/config"] = 'dosini',
		[".*/kitty/*.conf"] = 'bash',
		[".*/hypr/.*%.conf"] = 'hyprlang',
	},
})
