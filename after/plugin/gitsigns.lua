local gitsigns = require('gitsigns')

gitsigns.setup {
    signs                   = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signcolumn              = true,
    numhl                   = false,
    linehl                  = false,
    word_diff               = false,
    auto_attach             = true,
    attach_to_untracked     = false,
    current_line_blame      = true,
    current_line_blame_opts = {
        delay = 1000,
        ignore_whitespace = true
    },
    update_debounce         = 500,
}
