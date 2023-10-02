local setup, lualine = pcall(require, "lualine")
if not setup then
	return
end

lualine.setup({
	sections = {
		lualine_a = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
	},
})
