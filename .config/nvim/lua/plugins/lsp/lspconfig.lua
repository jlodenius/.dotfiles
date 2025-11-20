return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    event = "VeryLazy",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      max_concurrent_installers = 4,
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "html",
          "cssls",
          "ts_ls",
          "tailwindcss",
          "lua_ls",
          "emmet_ls",
          "svelte",
          "pyright",
          "graphql",
          "pylsp",
        },
        automatic_installation = true,
        handlers = {
          -- Default handler for servers without custom config
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
          -- Custom handlers for servers with specific configs
          ["html"] = function()
            lspconfig.html.setup({
              capabilities = capabilities,
              filetypes = { "hbs" },
            })
          end,
          ["ts_ls"] = function()
            lspconfig.ts_ls.setup({
              capabilities = capabilities,
              handlers = {
                ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
                  -- Process diagnostics
                  for _, diagnostic in ipairs(result.diagnostics) do
                    -- Filter ESLint diagnostics from ts_ls to prevent duplicates
                    if diagnostic.source == "eslint" then
                      diagnostic = nil
                    -- Ensure TypeScript warnings show as warnings, not hints
                    elseif diagnostic.code == 6133 then
                      -- "declared but never read" should be a warning
                      diagnostic.severity = vim.lsp.protocol.DiagnosticSeverity.Warning
                    end
                  end

                  -- Filter out nil diagnostics
                  result.diagnostics = vim.tbl_filter(function(d) return d ~= nil end, result.diagnostics)

                  vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
                end,
              },
            })
          end,
          ["eslint"] = function()
            lspconfig.eslint.setup({
              capabilities = capabilities,
              settings = {
                workingDirectories = { mode = "auto" },
              },
            })
          end,
          ["cssls"] = function()
            lspconfig.cssls.setup({
              capabilities = capabilities,
              settings = {
                css = { lint = { unknownAtRules = "ignore" } },
              },
            })
          end,
          ["tailwindcss"] = function()
            lspconfig.tailwindcss.setup({
              capabilities = capabilities,
              settings = {
                tailwindCSS = {
                  experimental = {
                    classRegex = {
                      { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                      { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                    },
                  },
                },
              },
            })
          end,
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  telemetry = { enable = false },
                  diagnostics = { globals = { "vim" } },
                  workspace = {
                    checkThirdParty = false,
                    library = {
                      [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                      [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                  },
                },
              },
            })
          end,
          ["emmet_ls"] = function()
            lspconfig.emmet_ls.setup({
              capabilities = capabilities,
              filetypes = {
                "html",
                "typescriptreact",
                "javascriptreact",
                "css",
                "sass",
                "scss",
                "less",
                "svelte",
              },
            })
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      -- Setup language servers natively

      -- Rust
      vim.lsp.config("rust_analyzer", {
        -- Server-specific settings. See `:help lspconfig-setup`
        settings = {
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
      })
      vim.lsp.enable("rust_analyzer")

      --  Global keymaps
      vim.keymap.set("n", "åd", function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { noremap = true, silent = true, buffer = bufnr }

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gv", ":vsplit | lua vim.lsp.buf.definition()<CR>", opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          -- Disable semanticTokensProvider
          -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })
    end,
  },
}
