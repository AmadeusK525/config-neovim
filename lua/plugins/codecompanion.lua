local utils = require("amadeusk525.utils")

return {
    dir = "/Users/amadeusk525/Documents/amadeus/codecompanion.nvim",

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
                    codex = function()
                        local jira_token = vim.fn.system(
                            "security find-generic-password -s 'JIRA CodeCompanion' -a 'v.leonardo.franceschetti' -w"
                        ):gsub("%s+$", "")

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
                                mcpServers = {
                                    {
                                        name = "atlassian",
                                        command = "/opt/reddit/bin/uv",
                                        args = { "--directory", "/Users/amadeusk525/Documents/reddit/mcp-atlassian", "run", "mcp-atlassian" },
                                        env = {
                                            { name = "JIRA_URL",             value = "https://reddit.atlassian.net/" },
                                            { name = "JIRA_USERNAME",        value = "v.leonardo.franceschetti@reddit.com" },
                                            { name = "JIRA_API_TOKEN",       value = jira_token },
                                            { name = "CONFLUENCE_URL",       value = "https://reddit.atlassian.net/wiki" },
                                            { name = "CONFLUENCE_USERNAME",  value = "v.leonardo.franceschetti@reddit.com" },
                                            { name = "CONFLUENCE_API_TOKEN", value = jira_token },
                                        },
                                    },
                                },
                                session_config_options = {
                                    model = "gpt-5.5",
                                },
                            },
                            env = {
                                APP_SERVER_LOGS = "/tmp/codex-acp-logs",

                            },
                        })
                    end,
                    cursor_cli = function()
                        local jira_token = vim.fn.system(
                            "security find-generic-password -s 'JIRA CodeCompanion' -a 'v.leonardo.franceschetti' -w"
                        ):gsub("%s+$", "")

                        return require("codecompanion.adapters.acp").extend("cursor_cli", {
                            defaults = {
                                timeout = 60000,
                                mcpServers = {
                                    {
                                        name = "atlassian",
                                        command = "/opt/reddit/bin/uv",
                                        args = { "--directory", "/Users/amadeusk525/Documents/reddit/mcp-atlassian", "run", "mcp-atlassian" },
                                        env = {
                                            { name = "JIRA_URL",             value = "https://reddit.atlassian.net/" },
                                            { name = "JIRA_USERNAME",        value = "v.leonardo.franceschetti@reddit.com" },
                                            { name = "JIRA_API_TOKEN",       value = jira_token },
                                            { name = "CONFLUENCE_URL",       value = "https://reddit.atlassian.net/wiki" },
                                            { name = "CONFLUENCE_USERNAME",  value = "v.leonardo.franceschetti@reddit.com" },
                                            { name = "CONFLUENCE_API_TOKEN", value = jira_token },
                                        },
                                    },
                                },
                            },
                        })
                    end,
                },
            },
            interactions = {
                chat = {
                    adapter = {
                        name = "codex",
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
                            opts = { allowed_in_yolo_mode = true },
                        },
                        ["delete_file"] = {
                            opts = { allowed_in_yolo_mode = true },
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
                            opts = { allowed_in_yolo_mode = true },
                        },
                        ["read_file"] = {
                            opts = { require_approval_before = false },
                        },
                        ["run_command"] = {
                            opts = { allowed_in_yolo_mode = true },
                        },
                    }),
                    opts = {
                        system_prompt = function(context)
                            return context.default_system_prompt
                                .. "\n\n"
                                .. [[
Additional instructions:
- Never use analogies. If you want to use analogies for simplicity,
  explain the real situation instead, but simplifying certain parts whose
  intricacies are not necessary for broad understanding
- Use ASD-STE100 Simplified Technical English
- Whenever committing, use conventional commit messages and use imperative verbs
- Feel free to ask/clarify things with me if you're not sure, do not assume, always verify
- Always obey the agent files in the repositories
- Always lint and test before pushing
- Don't push code unless I explicitly ask you to
- Use atomic commits always. Each commit should have a clear, small purpose, should pass lint and tests
                                ]]
                        end,
                    },
                },
                inline = {
                    adapter = {
                        name = "codex",
                    },
                },
            },
            mcp = {
                servers = {
                    ["atlassian"] = {
                        cmd = { "/opt/reddit/bin/uv", "--directory", "/Users/amadeusk525/Documents/reddit/mcp-atlassian", "run", "mcp-atlassian" },
                        env = {
                            JIRA_URL = "https://reddit.atlassian.net/",
                            JIRA_USERNAME = "v.leonardo.franceschetti@reddit.com",
                            JIRA_API_TOKEN =
                            "cmd:security find-generic-password -s 'JIRA CodeCompanion' -a 'v.leonardo.franceschetti' -w | tr -d '\\n'",
                            CONFLUENCE_URL = "https://reddit.atlassian.net/wiki",
                            CONFLUENCE_USERNAME = "v.leonardo.franceschetti@reddit.com",
                            CONFLUENCE_API_TOKEN =
                            "cmd:security find-generic-password -s 'JIRA CodeCompanion' -a 'v.leonardo.franceschetti' -w | tr -d '\\n'"
                        },
                    },
                },
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
                            { "~/.cursor/skills/",                   recursive = true },
                            { "~/.agents/skills/",                   recursive = true },
                        },
                    },
                },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
        vim.keymap.set("v", "<leader>cc", function()
            vim.api.nvim_input(":CodeCompanion ")
        end, { noremap = true, silent = true })
    end,
}
