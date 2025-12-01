-- lsp 

-- require('lspconfig').gopls.setup({})
return {
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  --
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
    },
    config = function(_, _)
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert(require('wilkuu.plugin_maps').cmp_mapping(cmp)),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'vimtex'},
          { name = 'path' },
        },
      })
    end
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x', 
    -- LSP Configuration & Plugins
    dependencies = {
      'neovim/nvim-lspconfig',
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },

    config = function (pl,opts) 
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig({
        sign_text = "",
        lsp_attach = require('wilkuu.plugin_maps').lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      }) 
      require("wilkuu.lsp")()
    end 
  },
  
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

} 
