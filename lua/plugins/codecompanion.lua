local utils = require("amadeusk525.utils")

return {
	"olimorris/codecompanion.nvim",

	event = "VeryLazy",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"cairijun/codecompanion-agentskills.nvim",
	},
	config = function()
		local codecompanion = require("codecompanion")
		local default_config = require("codecompanion.config")

		codecompanion.setup({
			adapters = {
				http = {
					copilot = function()
						return require("codecompanion.adapters.http").extend("copilot", {
							schema = {
								top_p = {
									enabled = function(self)
										local model = self.schema.model.default
										if type(model) == "function" then
											model = model()
										end
										if model == "gpt-5.5" then
											return false
										end
										return not vim.startswith(model, "o1")
									end,
								},
							},
						})
					end,
				},
				acp = {
					opencode = function()
						return require("codecompanion.adapters.acp").extend("opencode", {
							env = {
								XDG_CONFIG_HOME = "/Users/amadeusk525/.snoocode/opencode-config",
							},
							defaults = {
								mcpServers = "inherit_from_config",
							},
						})
					end,
					codex = function()
						return require("codecompanion.adapters.acp").extend("codex", {
							commands = {
								default = {
									"npm",
									"--prefix",
									"/Users/amadeusk525/Documents/amadeus/codex-acp",
									"start",
								},
							},
							defaults = {
								auth_method = "chat-gpt",
								mcpServers = "inherit_from_config",
							},
							env = {
								APP_SERVER_LOGS = "/tmp/codex-acp-logs",
							},
						})
					end,
					cursor_cli = {
						defaults = {
							timeout = 60000,
							mcpServers = "inherit_from_config",
						},
					},
				},
			},
			interactions = {
				chat = {
					adapter = {
						name = "opencode",
						model = "opencode/deepseek-v4.1-flash-free",
					},
					keymaps = {
						close = {
							modes = {
								n = "<C-c>",
								i = "<C-c>",
							},
							index = 4,
							callback = function(chat)
								chat.ui:hide()
							end,
							description = "Hide the chat buffer",
						},
					},
					tools = utils.merge_tables(default_config.interactions.chat.tools, {
						["create_file"] = {
							opts = { protect = false },
						},
						["delete_file"] = {
							opts = { protect = false },
						},
						["file_search"] = {
							opts = { require_approval_before = false },
						},
						["get_diagnostics"] = {
							opts = { require_approval_before = false },
						},
						["get_changed_files"] = {
							opts = { require_approval_before = false },
						},
						["grep_search"] = {
							opts = { require_approval_before = false },
						},
						["insert_edit_into_file"] = {
							opts = { protect = false },
						},
						["read_file"] = {
							opts = { require_approval_before = false },
						},
						["run_command"] = {
							opts = { protect = false },
						},
					}),
					opts = {
						system_prompt = function(context)
							local instructions_path = vim.fn.expand("~/.agents/AGENTS.md")
							local ok, lines = pcall(vim.fn.readfile, instructions_path)
							if not ok or vim.tbl_isempty(lines) then
								return context.default_system_prompt
							end
							return context.default_system_prompt .. "\n\n" .. table.concat(lines, "\n")
						end,
					},
				},
				inline = {
					adapter = {
						name = "opencode",
						model = "opencode/deepseek-v4.1-flash-free",
					},
				},
			},
			mcp = {
				opts = {
					default_servers = { "atlassian" },
					acp_enabled = true,
				},
			},
			extensions = {
				agentskills = {
					opts = {
						paths = {
							{ vim.fn.getcwd() .. "/.cursor/skills/", recursive = true },
							{ vim.fn.getcwd() .. "/.agents/skills/", recursive = true },
							{ "~/.cursor/skills/", recursive = true },
							{ "~/.agents/skills/", recursive = true },
						},
					},
				},
			},
		})

		vim.keymap.set(
			{ "n", "v" },
			"<leader>ca",
			"<cmd>CodeCompanionChat Toggle<cr>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set("v", "<leader>cc", function()
			vim.api.nvim_input(":CodeCompanion ")
		end, { noremap = true, silent = true })
	end,
}
