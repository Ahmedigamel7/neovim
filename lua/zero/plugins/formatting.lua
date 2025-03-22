return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				clangd = { "clang-format" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
-- return {
-- 	"mhartington/formatter.nvim",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	config = function()
-- 		local formatter = require("formatter")
-- 		formatter.setup({
-- 			filetype = {
-- 				javascript = {
-- 					function()
-- 						return {
-- 							exe = "prettier",
-- 							args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
-- 							stdin = true,
-- 						}
-- 					end,
-- 				},
-- 				typescript = {
-- 					function()
-- 						return {
-- 							exe = "prettier",
-- 							args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
-- 							stdin = true,
-- 						}
-- 					end,
-- 				},
-- 				javascriptreact = {
-- 					function()
-- 						return {
-- 							exe = "prettier",
-- 							args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
-- 							stdin = true,
-- 						}
-- 					end,
-- 				},
-- 				typescriptreact = {
-- 					function()
-- 						return {
-- 							exe = "prettier",
-- 							args = { "--stdin-filepath", '"' .. vim.api.nvim_buf_get_name(0) .. '"' },
-- 							stdin = true,
-- 						}
-- 					end,
-- 				},
-- 				python = {
-- 					function()
-- 						return {
-- 							exe = "black",
-- 							args = { "-" },
-- 							stdin = true,
-- 						}
-- 					end,
-- 				},
-- 				cpp = {
-- 					function()
-- 						return {
-- 							exe = "clang-format",
-- 							args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
-- 							stdin = true,
-- 						}
-- 					end,
-- 				},
-- 				css = {
-- 					function()
-- 						return {
-- 							exe = "prettier",
-- 							args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
-- 							stdin = true,
-- 						}
-- 					end,
-- 				},
-- 				html = {
-- 					function()
-- 						return {
-- 							exe = "prettier",
-- 							args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
-- 							stdin = true,
-- 						}
-- 					end,
-- 				},
-- 				lua = {
-- 					function()
-- 						return {
-- 							exe = "stylua",
-- 							args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "-" },
-- 							stdin = true,
-- 						}
-- 					end,
-- 				},
-- 				bash = {
-- 					function()
-- 						return {
-- 							exe = "shfmt",
-- 							args = { "-i", "2" }, -- Use 2 spaces for indentation
-- 							stdin = true,
-- 						}
-- 					end,
-- 				},
-- 			},
-- 		})
-- 		vim.keymap.set("n", "<leader>f", "<cmd>Format<cr>", { noremap = true, silent = true })
-- 	end,
-- }
