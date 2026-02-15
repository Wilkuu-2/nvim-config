-- Bootstrap 
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.opt.guicursor = ""

local wilkuu_prefix = "lua.wilkuu."

require(wilkuu_prefix .. "options")
require(wilkuu_prefix .. "keymaps").vim()

-- TODO: Make a config flag for adding/removing plugin managers. (So that you can use it safely as root)
-- Initialize Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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

require("lazy").setup("plugins", {
  rocks = { enabled = false },
  dev = {
    path = "~/.local/share/nvim/nix",
    fallback = false,
  },
})


require("lua.workarounds")
-- require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
require(wilkuu_prefix .. "plugin_config")

