return {
    "olimorris/codecompanion.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "copilot",
                },
                inline = {
                    adapter = "copilot",
                },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
        vim.keymap.set("v", "<leader>cc", function()
            vim.api.nvim_input(":CodeCompanion ")
        end, { noremap = true, silent = true })
    end,
}
