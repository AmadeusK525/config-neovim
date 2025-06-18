return {
    "github/copilot.vim",

    config = function()
        vim.cmd("Copilot disable") -- I don't want this shitty autocomplete, only using to setup for CodeCompanion
    end,
}
