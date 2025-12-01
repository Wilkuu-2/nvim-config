return {
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "sioyek"
    end
  },
  -- TODO: This is just for .md files, move it 
  -- {
  --  "toppair/peek.nvim",
  --   event = { "VeryLazy" },
  --   build = "deno task build:fast",
  --   config = function()
  --       require("peek").setup({
  --         auto_load = false,
  --         close_on_bdelete = true,
  --         syntax = true,
  --         app = {'chromium', '--new-window'},
  --
  --         change_on_update = true,
  --         throttle_at = 200000,
  --         throttle_time = 'auto'
  --       })
  --       vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  --       vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  --   end,
  -- },
  {
    "micangl/cmp-vimtex",
  }
}
