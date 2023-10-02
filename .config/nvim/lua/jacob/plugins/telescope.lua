local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

telescope.setup({
	defaults = {
		-- DEFAULT MAPPINGS
		-- https://github.com/nvim-telescope/telescope.nvim#default-mappings
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-h>"] = actions.select_horizontal, -- open file in horizontal split
				["<C-v>"] = actions.select_vertical, -- open file in vertical split
				["<C-q>"] = actions.smart_add_to_qflist, -- add to qf list
			},
		},
	},
})

telescope.load_extension("fzf")
