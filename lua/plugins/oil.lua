return {
    'stevearc/oil.nvim',
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    lazy = false,

    opts = {
        view_options = {
            show_hidden = true,
        },
    },

    init = function(oil)
        vim.keymap.set("n", "<leader>o", vim.cmd.Oil)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil",
            callback = function(args)
                local oil_actions = require("oil.actions")
                local bufnr = args.buf
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "<leader>yf", function() oil_actions.copy_to_system_clipboard.callback() end, opts)
            end
        })
    end
}
