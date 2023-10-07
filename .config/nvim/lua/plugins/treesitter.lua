return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        context_commentstring = { enable = true }, -- requires commentstring plugin (used to comment jsx/tsx)
        ensure_installed = {
            "rust",
            "json",
            "javascript",
            "typescript",
            "tsx",
            "yaml",
            "html",
            "css",
            "markdown",
            "graphql",
            "bash",
            "lua",
            "vim",
            "vimdoc",
            "dockerfile",
            "gitignore",
            "svelte",
        },
        sync_install = false,
      })
    end,
 }
