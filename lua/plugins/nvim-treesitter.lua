local spec = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  verylazy = true,
  opts = {
    ensure_installed = {
      -- "bash",
      "latex",
      "lua",
      "ruby",
      "vim",
      "vimdoc",
    },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
      disable = { "latex" },
    },
    indent = {
      enable = true,
      disable = { "latex" },
    },
  },
}
return spec
