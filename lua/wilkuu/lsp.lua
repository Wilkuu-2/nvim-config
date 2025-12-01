return function()
  local nix_stuff = require('wilkuu.nix')
 
  vim.lsp.enable('nil_ls')
  vim.lsp.enable('statix')
  vim.lsp.enable('tailwindcss')
  vim.lsp.enable('ltex')
  vim.lsp.config('ltex',{
    filetypes = {"bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto", "rmd", "context", "html", "xhtml", "mail", "text", "typst"},
    settings = { ltex = {
        language = "auto"
      },
    },

  })

  vim.lsp.enable('codebook');
  vim.lsp.config('codebook', {
    filetypes =  { "c", "css", "gitcommit", "go", "haskell", "html", "java", "javascript", "javascriptreact", "lua", "markdown", "php", "python", "ruby", "rust", "toml", "text", "typescript", "typescriptreact", "typst"}
  });

  -- vim.lsp.config('ts_ls', {
  --   init_options = {
  --       plugins = {
  --         {
  --           name = "@vue/typescript-plugin",
  --           location = nix_stuff.vue_ts_plugin,
  --           languages = {"vue", "javascript", "typescript"},
  --         },
  --       },
  --     },
  --     filetypes = {
  --       "javascript",
  --       "typescript",
  --       "vue",
  --     },
  -- })
  vim.lsp.config('volar', {
    init_options = {
        vue = {
          hybridMode = false,
        },
      },
  })

  vim.lsp.enable('lua_ls')
  vim.lsp.enable('rust_analyzer')
  vim.lsp.enable('zls')
  -- vim.lsp.config('intelephense', {
  --   cmd = {"intelephense", "--stdio"},
  --   filetypes = {"php"},
  -- }
  vim.lsp.enable('phpactor')

  vim.lsp.enable('pyright')
  vim.lsp.enable('clangd')
  vim.lsp.config('clangd', {
       filetypes = {"c", "c++"},
       autostart = true,
       cmd = { "/home/wilkuu/.nix-profile/bin/clangd" }
  })
  vim.lsp.enable('tinymist')

  vim.lsp.enable('java_language_server')
  vim.lsp.config('java_language_server',
    { cmd = {"java-language-server"},
      settings = {}
    })

  -- vim.lsp.config('texlab', {
  --     settings = { texlab = {
  --     auxDirectory = "./latex_build",
  --     bibtexFormatter = "texlab",
  --     build = {
  --       args = { "-pdf","-bibtex", "-interaction=nonstopmode", "-synctex=1","-auxdir=./latex_build","-output-directory=./latex_build", "%f"},
  --       executable = "latexmk",
  --       -- args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates", "--outdir", "./latex_build" },
  --       -- executable = "/usr/bin/tectonic",
  --       forwardSearchAfter = false,
  --       onSave = true
  --     },
  --     chktex = {
  --       onEdit = false,
  --       onOpenAndSave = false
  --     },
  --     diagnosticsDelay = 300,
  --     formatterLineLength = 80,
  --     latexFormatter = "latexindent",
  --     latexindent = {
  --       modifyLineBreaks = false
  --     }
  --   }}}
end
