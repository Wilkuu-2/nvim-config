
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('wilkuu-lsp-attach', {clear = true}), 
	callback = function (event) 


    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('wilkuu-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('wilkuu-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'wilkuu-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

  require('wilkuu.keymaps').lsp(event)



  -- Enable your LSP's here 
  vim.lsp.enable('nixd')
  --  vim.lsp.config('nixd', {})
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

  vim.lsp.config('ts_ls', {
    init_options = {
        -- plugins = {
        --   {
        --     name = "@vue/typescript-plugin",
        --     location = nix_stuff.vue_ts_plugin,
        --     languages = {"vue", "javascript", "typescript"},
        --   },
        -- },
      },
      filetypes = {
        "javascript",
        "typescript",
        "vue",
      },
  })
  vim.lsp.config('volar', {
    init_options = {
        vue = {
          hybridMode = false,
        },
      },
  })

  vim.lsp.enable('lua_ls')
  vim.lsp.enable('rust_analyzer')
  vim.lsp.config('rust_analyzer', {
    settings = {
      ["rust-analyzer"] = {
        imports = {
            granularity = {
                group = "module",
            },
            prefix = "self",
        },
        cargo = {
            buildScripts = {
                enable = true,
            },
        },
        procMacro = {
            enable = true
        },
       check = {
          command = "clippy",
          extraArgs = {
            "--all-targets",
            "--all-features",
          },
        },
      },
    }
  })
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
})

-- vim: ts=2 sts=2 sw=2 et
