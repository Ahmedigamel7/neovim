return {
	"navarasu/onedark.nvim",
	config = function()
		require("onedark").setup({})
    vim.cmd[[colorscheme onedark]]
	end,
}
