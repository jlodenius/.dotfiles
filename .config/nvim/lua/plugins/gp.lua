return {
  "robitx/gp.nvim",
  config = function()
    local model = "deepseek-r1:8b"

    local conf = {
      default_provider = "ollama",
      default_command_agent = model,
      default_chat_agent = model,
      command_prompt_prefix_template = "Prompt:",

      providers = {
        ollama = {
          disable = false,
          endpoint = "http://localhost:11434/v1/chat/completions",
        },
      },
      agents = {
        {
          provider = "ollama",
          name = model,
          chat = true,
          command = true,
          model = model,
          system_prompt = "You are a general AI coding assistant. You will only output code. No explanations, comments or reasoning",
        },
      },
      hooks = {
        -- example of making :%GpChatNew a dedicated command which
        -- opens new chat with the entire current buffer as a context
        BufferChatNew = function(gp, _)
          -- call GpChatNew command in range mode on whole buffer
          vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatToggle popup")
        end,
        -- example of adding command which writes unit tests for the selected code
        UnitTests = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please respond by giving me the code for appropriate unit tests."
          local agent = gp.get_command_agent()
          gp.Prompt(params, gp.Target.vnew, agent, template)
        end,
      },
    }
    require("gp").setup(conf)

    vim.keymap.set({ "n", "i" }, "<C-g>g", "<cmd>GpBufferChatNew<cr>")
    vim.keymap.set("v", "<C-g><C-g>", ":<C-u>'<,'>GpRewrite<cr>")
  end,
}
