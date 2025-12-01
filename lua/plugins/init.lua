return {
  { "catppuccin/nvim",
  name="catppuccin",
  priority = 1000,
  opts = {
	flavour = mocha,
	background = {
		dark = mocha,
		light = latte,
	},
	integrations = {
		cmp = true,
		 gitsigns = true,
        	nvimtree = true,
        	treesitter = true,
        	notify = false,
        	mini = {
            	enabled = true,
            	indentscope_color = "",
        	},
	}

  },
  config = function(lp, opts) 
	require("catppuccin").setup(opts)
	vim.cmd.colorscheme "catppuccin-mocha"
	end
 },

 -- { "wn_notes",
 --    dir='/store1/Personal/wilkuunotes',
 --    dev='true',
 --  },
 {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
}
