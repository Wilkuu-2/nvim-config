return {
  "mason-org/mason.nvim",
  opts = {},
  cond = function () 
    return not vim.g._w_settings.nix
  end 

}
