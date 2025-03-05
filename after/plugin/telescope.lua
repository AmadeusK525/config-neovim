local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
}
telescope.load_extension('fzf')

vim.keymap.set('n', '<leader>pf', builtin.find_files)
vim.keymap.set('n', '<leader>pa', function()
    builtin.find_files({ hidden = true, no_ignore = true })
end)
vim.keymap.set('n', '<leader>pg', builtin.git_files)
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>lps', builtin.live_grep)
vim.keymap.set('n', '<leader>er', builtin.diagnostics)
vim.keymap.set('n', '<leader>tig', builtin.git_bcommits)
vim.keymap.set('n', '<leader>gtig', builtin.git_commits)
