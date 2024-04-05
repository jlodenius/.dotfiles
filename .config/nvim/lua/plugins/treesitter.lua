return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
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
        "python",
      },
      sync_install = false,
    })

    -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
    require("ts_context_commentstring").setup()
  end,
}
