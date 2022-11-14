local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason.setup()

mason_lspconfig.setup({
	-- list of servers to install
	-- ADD MORE (https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers)
	ensure_installed = {
		"tsserver",
		"html",
		"cssls",
		"tailwindcss",
		"sumneko_lua",
		"emmet_ls",
	},
})

mason_null_ls.setup({
	-- list of sources
	-- ADD MORE (https://github.com/jayp0521/mason-null-ls.nvim#available-null-ls-sources)
	ensure_installed = {
		"prettierd",
		"stylua",
		"eslint_d",
	},
})