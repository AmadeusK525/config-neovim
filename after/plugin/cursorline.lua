local cl = require('nvim-cursorline')

cl.setup {
    cursorline = {
        enable = true,
        timeout = 0,
        number = false,
    },
    cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
    }
}

vim.api.nvim_create_autocmd('ColorScheme', {
    command = [[highlight CursorLine guibg=#202020]]
})
