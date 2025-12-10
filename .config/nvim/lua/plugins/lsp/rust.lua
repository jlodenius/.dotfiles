return {
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    event = { "BufRead Cargo.toml" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("crates").setup({
        completion = {
          cmp = {
            enabled = true,
          },
        },
      })
      require("cmp").setup.buffer({
        sources = { { name = "crates" } },
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    config = function()
      require("mason-registry")
      local cfg = require("rustaceanvim.config")
      local extension_path = vim.fn.expand("$MASON/packages/codelldb/extension/")
      local codelldb_path = extension_path .. "/adapter/codelldb"
      local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},

        -- LSP configuration
        server = {
          on_attach = function()
            local bufnr = vim.api.nvim_get_current_buf()

            vim.keymap.set(
              "n",
              "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
              function() vim.cmd.RustLsp({ "hover", "actions" }) end,
              { silent = true, buffer = bufnr }
            )

            -- Setup DAP stuff
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                features = "all",
              },
              checkOnSave = {
                enable = true,
              },
              check = {
                command = "clippy",
              },
              imports = {
                group = {
                  enable = false,
                },
              },
              completion = {
                postfix = {
                  enable = false,
                },
              },
            },
          },
        },

        -- DAP configuration
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },
  -- Better diagnostics?
  -- {
  --   "alexpasmantier/krust.nvim",
  --   ft = "rust",
  -- },
}
