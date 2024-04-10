return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    local function find_root_with_markers(starting_path, root_markers)
      local path = vim.fn.fnamemodify(starting_path, ":p:h")
      local sep = package.config:sub(1, 1)

      while path and #path > 1 do
        for _, marker in ipairs(root_markers) do
          local marker_path = path .. sep .. marker
          if vim.fn.isdirectory(marker_path) ~= 0 or vim.fn.filereadable(marker_path) ~= 0 then return path end
        end
        path = vim.fn.fnamemodify(path, ":h")
      end
      return nil
    end

    local function root_has_file(starting_path, root_markers, target_files)
      local root_path = find_root_with_markers(starting_path, root_markers)
      if root_path then
        local sep = package.config:sub(1, 1)
        for _, file in ipairs(target_files) do
          local file_path = root_path .. sep .. file
          if vim.fn.filereadable(file_path) ~= 0 then return true end
        end
      end
      return false
    end

    -- More settings & formatters
    -- https://github.com/stevearc/conform.nvim
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        less = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        lua = { "stylua" },
        python = { "black" },
      },
      formatters = {
        prettier = {
          condition = function()
            local root_markers = { ".git", "package.json" }
            local target_files = { ".prettierrc", ".prettierrc.json" }
            local starting_path = vim.fn.expand("%:p")
            return root_has_file(starting_path, root_markers, target_files)
          end,
          prepend_args = { "--no-semi", "--single-quote" },
        },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout = 500,
      },
    })

    vim.keymap.set(
      { "n", "v" },
      "<leader>cf",
      function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout = 500,
        })
      end,
      { desc = "Format file or range" }
    )
  end,
}
