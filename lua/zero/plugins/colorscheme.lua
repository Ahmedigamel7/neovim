
return {

	"navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    require("onedark").setup({
    })

    vim.cmd("colorscheme onedark")
  end,
}
