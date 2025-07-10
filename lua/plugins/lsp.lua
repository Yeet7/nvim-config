local wk = require("which-key")
wk.add({
  { "<leader>r", group = "Vimtex", icon = "" },
})
return {
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end,
    keys = {
      { "<leader>rr", "<cmd>VimtexCompile<cr>", desc = "Compiles .tex File" },
    },
  },
  { "SirVer/ultisnips" },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "mfussenegger/nvim-dap",
    optional = false,
    dependencies = {
      "suketa/nvim-dap-ruby",
      config = function()
        require("dap-ruby").setup()
      end,
    },
  },
  {
    "suketa/nvim-dap-ruby",
    config = function()
      require("dap-ruby").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- 1. KEEPS YOUR CUSTOM KEYMAPS
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(keys, {
        {
          "gd",
          function()
            require("telescope.builtin").lsp_definitions({ reuse_win = false })
          end,
          desc = "Goto Definition",
          has = "definition",
        },
      })
      opts.keys = keys

      -- 2. MERGES THE CORRECT SERVER CONFIGURATION
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        -- This is the single, correct configuration for ruby-lsp
        ruby_ls = {
          cmd = { "/home/brandon/.rbenv/shims/ruby-lsp" },
          on_attach = function(client, bufnr)
            -- This enables "fix all" on save for both safe and unsafe issues
            if client.supports_method("textDocument/codeAction") then
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("LspFixOnSave" .. bufnr, { clear = true }),
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.code_action({
                    context = { only = { "source.fixAll.rubocop" } },
                    apply = true,
                    bufnr = bufnr,
                  })
                end,
              })
            end
          end,
          initialization_options = {
            safeAutocorrect = false,
          },
        },
        -- This disables the conflicting standalone server
        rubocop = {
          enable = false,
        },
      })
    end,
  },
  { "olimorris/neotest-rspec" },
}
