vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader><CR>", ":source ~/.config/nvim/init.lua<CR>", { noremap = true, desc = "Reload nvim config" })

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Copilot keymaps
-- keymap.set("i", "<C-a>", 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })
keymap.set("i", "<C-j>", "copilot#Next()", { expr = true, silent = true })
keymap.set("i", "<C-k>", "copilot#Previous()", { expr = true, silent = true })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<leader>n", ":let @/ = expand('<cword>')<CR>gn", { silent = true, desc = "Search word under cursor" })
keymap.set(
	"x",
	"<leader>r",
	":s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>",
	{ silent = true, desc = "Replace word under cursor" }
)

-- Keymap to show error info in a floating window and copy it to the system clipboard
keymap.set("n", "<leader>e", function()
	local diagnostics = vim.diagnostic.get()
	if #diagnostics == 0 then
		print("No errors or warnings!")
		return
	end
	local msg = ""
	for _, diagnostic in ipairs(diagnostics) do
		msg = msg .. diagnostic.message .. "\n\n"
	end
	-- Display the error messages in a floating window
	vim.api.nvim_echo({ { msg, "Error" } }, false, {})
	-- Copy the message to the system clipboard
	vim.fn.setreg("+", msg)
	print("Error info copied to clipboard!")
end, { desc = "Show and copy error info to system clipboard" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move selected lines down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move selected lines up" })

keymap.set("n", "<C-j>", ":cnext<CR>", { noremap = true })
keymap.set("n", "<C-k>", ":cprev<CR>", { noremap = true })
keymap.set("n", "<C-p>", ":GFiles<CR>", { noremap = true })

keymap.set("v", "<leader>p", '"_dP', { noremap = true, desc = "Paste without yanking" })
keymap.set("v", "<leader>y", '"+y', { noremap = true, desc = "Copy to system clipboard" })
keymap.set("n", "<leader>y", '"+y', { noremap = true, desc = "Copy to system clipboard" })
keymap.set("n", "<leader>Y", 'gg"+yG', { noremap = true, desc = "Copy all to system clipboard" })
keymap.set("n", "<leader>d", ":%d<CR>", { noremap = true, silent = true, desc = "Delete all " })

keymap.set("n", "<C-t>", ":split | terminal<CR>", { desc = "Open a new terminal split" })
keymap.set("t", "<C-Q>", [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true, desc = "Close terminal" })

keymap.set("n", "<leader>p", "o<esc>p", { noremap = true, desc = "Paste in the next line" })

vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true, desc = "Close current buffer" })
vim.keymap.set(
	"n",
	"<leader>bw",
	":bw<CR>",
	{ noremap = true, silent = true, desc = "Close current buffer without saving" }
)
vim.keymap.set("n", "<leader>bl", ":ls<CR>", { noremap = true, silent = true, desc = "List buffers" })

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true, desc = "New tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true, desc = "Close current tab" })
for i = 1, 9 do
	vim.keymap.set(
		"n",
		"<leader>" .. i,
		":tabnext " .. i .. "<CR>",
		{ noremap = true, silent = true, desc = "Go to tab " .. i }
	)
end
