return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local utils = require("jabba-utils")

    local pyproject_root = function()
      local root_markers = { "pyproject.toml" }
      local root_file = utils.find_root_with_markers(utils.current_path(), root_markers)
      return root_file .. "/pyproject.toml"
    end

    -- List of built-in linters:
    -- https://github.com/mfussenegger/nvim-lint
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      vue = { "eslint_d" },
      python = { "mypy", "flake8" },
      css = { "stylelint" },
    }
    lint.linters.flake8.args = {
      function() return "--config" .. pyproject_root() end,
    }
    lint.linters.mypy.args = {
      function() return "--config-file" .. pyproject_root() end,
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function() lint.try_lint() end,
    })

    vim.keymap.set("n", "<leader>L", function() lint.try_lint() end, { desc = "Trigger linting for current file" })
  end,
}
