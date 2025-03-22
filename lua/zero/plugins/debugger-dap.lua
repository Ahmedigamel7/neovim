return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui", -- UI for DAP
"nvim-neotest/nvim-nio" ,
		"theHamsta/nvim-dap-virtual-text", -- Inline variable values
	},
	config = function()
		local dap = require("dap")

		-- Configure Node.js Debug Adapter
		dap.adapters.node2 = {
			type = "executable",
			command = "node",
			-- Path to the Node.js debug adapter installed via Mason
			args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
		}

		-- Configure DAP for JavaScript files
		dap.configurations.javascript = {
			{
				type = "node2", -- Use the Node.js debug adapter
				request = "launch", -- Start a new debugging session
				name = "Launch Node.js",
				program = "${file}", -- Debug the current file
				cwd = vim.fn.getcwd(), -- Set working directory to the current project
				sourceMaps = true, -- Enable source maps for better debugging
				protocol = "inspector", -- Use the inspector protocol
				console = "integratedTerminal", -- Show logs in Neovim terminal
				skipFiles = { "<node_internals>/**", "node_modules/**" }, -- Skip node_modules and internal files
			},
		}

		local function get_node_process()
			local handle = io.popen("pgrep -f 'node.*--inspect'") -- Find any Node.js debug process
			local pid = handle:read("*a")
			handle:close()
			return pid:gsub("\n", "") -- Remove any newlines
		end

		-- Configure DAP for typescript files and NestJS projects
		dap.configurations.typescript = {
			{
				type = "node2", -- Use Node.js debug adapter
				request = "launch", -- Start a new debugging session
				name = "Launch NestJS",
				runtimeExecutable = "node", -- Use Node.js
				args = { "start" }, -- Start the NestJS app
				processId = get_node_process,
				program = "${workspaceFolder}/node_modules/.bin/nest", -- Use Nest CLI
				cwd = vim.fn.getcwd(), -- Set working directory
				sourceMaps = true, -- Enable source maps for breakpoints
				protocol = "inspector", -- Use the inspector protocol
				console = "integratedTerminal", -- Show logs in the Neovim terminal
				runtimeArgs = { "--inspect=9229" }, -- Enable debugging on port 9229
				outFiles = { "${workspaceFolder}/dist/**/*.js" }, -- Map compiled JS files
				skipFiles = { "<node_internals>/**", "node_modules/**" }, -- Skip node_modules and internal files
			},
			{
				type = "node2",
				request = "attach", -- Attach to a running NestJS process
				name = "Attach to NestJS",
				processId = get_nestjs_process,
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
				outFiles = { "${workspaceFolder}/dist/**/*.js" },
				skipFiles = { "<node_internals>/**", "node_modules/**" },
			},
		}

		local function get_nestjs_process()
			local handle = io.popen("pgrep -f 'node.*--inspect=9229'")
			local pid = handle:read("*a")
			handle:close()
			return pid:gsub("\n", "") -- Remove any newlines
		end

		local dapui = require("dapui")
		dapui.setup()

		-- Automatically open DAP UI when debugging starts
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		-- Automatically close DAP UI when debugging stops
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		require("nvim-dap-virtual-text").setup({
			enabled = true, -- Enable virtual text
			enabled_commands = true, -- Enable commands like :DapVirtualTextEnable
			highlight_changed_variables = true, -- Highlight changed variables
			highlight_new_as_changed = true, -- Highlight newly created variables
			show_stop_reason = true, -- Show why execution stopped
			commented = false, -- No comment markers before the virtual text
		})

		-- DAP keymaps
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue Debugging" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
		vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart Debugging" })
		vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Stop Debugging" })

		-- Configure DAP for C++
		dap.adapters.lldb = {
			type = "executable",
			command = "/usr/bin/lldb-vscode",
			name = "lldb",
		}

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}
	end,
}

-- { },
