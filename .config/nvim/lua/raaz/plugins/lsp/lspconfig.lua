return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local util = require("lspconfig/util")

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["gopls"] = function()
				lspconfig["gopls"].setup({
					-- on_attach = on_attach,
					capabilities = capabilities,
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_dir = util.root_pattern("go.work", "go.mod", ".git"),
					settings = {
						gopls = {
							completeUnimported = true,
							usePlaceholders = true,
							analyses = {
								unusedparams = true,
							},
						},
					},
				})
			end,

			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,

			["rust_analyzer"] = function()
				lspconfig["pyright"].setup({
					-- on_attach = on_attach,
					capabilities = capabilities,
					filetypes = { "rust" },
					root_dir = util.root_pattern("Cargo.toml", ".git"),
				})
			end,

			["pyright"] = function()
				lspconfig["pyright"].setup({
					-- on_attach = on_attach,
					capabilities = capabilities,
					filetypes = { "python" },
				})
			end,
		})
	end,
}

-- local on_attach = require("plugins.configs.lspconfig").on_attach
-- local capabilities = require("plugins.configs.lspconfig").capabilities
--
-- local lspconfig = require("lspconfig")
-- local util = require "lspconfig/util"
--
-- lspconfig.gopls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = {"gopls"},
--   filetypes = { "go", "gomod", "gowork", "gotmpl" },
--   root_dir = util.root_pattern("go.work", "go.mod", ".git"),
--   settings = {
--     gopls = {
--       completeUnimported = true,
--       usePlaceholders = true,
--       analyses = {
--         unusedparams = true,
--       },
--     },
--   },
-- }
--
-- local function organize_imports()
--   local params = {
--     command = "_typescript.organizeImports",
--     arguments = {vim.api.nvim_buf_get_name(0)},
--   }
--   vim.lsp.buf.execute_command(params)
-- end
--
-- lspconfig.ts_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   init_options = {
--     preferences = {
--       disableSuggestions = true,
--     }
--   },
--   commands = {
--     OrganizeImports = {
--       organize_imports,
--       description = "Organize Imports",
--     }
--   }
-- }
--
-- lspconfig.templ.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "templ" }
-- }
