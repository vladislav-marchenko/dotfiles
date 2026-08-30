return {
  {
    "williamboman/mason.nvim",
    version = "1.8.0",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "1.30.0",
    opts = {
      ensure_installed = {
        "pyright",
        "pylsp",
        "tsserver", -- ts_ls
        "tailwindcss",
        "lua_ls",
        "jsonls",
        "cssls",
        "eslint",
      },
      auto_install = true,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "codeium" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        underline = {
          severity = vim.diagnostic.severity.ERROR,
        },
        virtual_text = {
          spacing = 2,
          source = "if_many",
        },
        severity_sort = true,
        float = {
          border = "rounded",
          source = "if_many",
        },
      })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
        undercurl = true,
        underline = true,
        sp = "#ff6b6b",
      })

      vim.lsp.config("pylsp", {})
      vim.lsp.config("eslint", {
        settings = {
          format = false,
          workingDirectory = { mode = "auto" },
        },
      })
      vim.lsp.config("ts_ls", {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          }
        }
      })
      for _, server in ipairs({ "pylsp", "ts_ls", "eslint", "lua_ls", "tailwindcss", "jsonls", "cssls" }) do
        vim.lsp.enable(server)
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", function()
        require("telescope.builtin").lsp_references()
      end, { desc = "LSP references" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
