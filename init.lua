local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Initialize Lazy
if not vim.loop.fs_stat(lazypath) then 
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
})

end 
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.localleader = ","
vim.opt.termguicolors = true
vim.opt.guicursor = ""

require("lazy").setup("plugins", {
  rocks = { enabled = false },
  dev = {
    path = "~/.local/share/nvim/nix",
    fallback = false,
  }, 
})

-- Workaround for Rustanalyzer being an ass 
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
require("wilkuu")
