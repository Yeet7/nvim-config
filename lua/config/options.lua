local tex = require("lazyvim.plugins.extras.lang.tex")
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Vimtex & Snippets

vim.g.vimtex_view_method = "zathura"

-- LuaSnip

-- Ruby Rubocop LSP setup, find the actual LSP initiation in the ../plugins/lsp.lua

vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "rubocop"
