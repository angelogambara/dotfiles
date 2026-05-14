---@type LazySpec
return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	cmd = { "Oil" },
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Open Oil" },
	},
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		default_file_explorer = true,
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,

		columns = { "icon", "size", "mtime" },
		view_options = { show_hidden = true },

		keymaps = {
			["gx"] = {
				desc = "Run custom command on selection",
				callback = function()
					local oil = require("oil")
					local dir = oil.get_current_dir()
					local mode = vim.api.nvim_get_mode().mode

					local vmin = vim.fn.line(mode:match("[vV\x16]") and "v" or ".")
					local vmax = vim.fn.line(".")
					vmin, vmax = math.min(vmin, vmax), math.max(vmin, vmax)

					vim.ui.input({
						prompt = "Run command: ",
						default = "xdg-open",
					}, function(command)
						if not command or command == "" then return end
						local cmd_table = vim.split(command, " ", { trimempty = true })

						if vim.fn.executable(cmd_table[1]) ~= 1 then
							vim.notify("Command not found: " .. cmd_table[1], 3)
							return
						end

						for lnum = vmin, vmax do
							local entry = oil.get_entry_on_line(0, lnum)
							if entry then
								table.insert(cmd_table, dir .. entry.name)
							end
						end

						vim.fn.jobstart(cmd_table, { detach = true })
						vim.api.nvim_input("<Esc>")
					end)
				end,
			},
		},
	},
}
