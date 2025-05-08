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

local function get_visual_selection()
  local start_pos = vim.fn.getpos("v") -- start of visual selection
  local end_pos = vim.fn.getpos(".")   -- end of visual selection

  local start_row, start_col = start_pos[2], start_pos[3]
  local end_row, end_col = end_pos[2], end_pos[3]

  -- normalize ordering (in case selection is backwards)
  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

  if #lines == 0 then return "" end

  -- trim start and end columns
  lines[1] = string.sub(lines[1], start_col)
  if #lines == 1 then
    lines[1] = string.sub(lines[1], 1, end_col - start_col + 1)
  else
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
  end

  return table.concat(lines, "\n")
end

vim.keymap.set('n', '<leader>pf', builtin.find_files)
vim.keymap.set('n', '<leader>pa', function()
    builtin.find_files({ hidden = true, no_ignore = true })
end)
vim.keymap.set('n', '<leader>pg', builtin.git_files)
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<C-f>', builtin.grep_string)
vim.keymap.set('v', '<C-f>', function()
    local text = get_visual_selection()
    builtin.grep_string({ search = text });
end)
vim.keymap.set('n', '<leader>lps', builtin.live_grep)
vim.keymap.set('n', '<leader>er', builtin.diagnostics)
vim.keymap.set('n', '<leader>tig', builtin.git_bcommits)
vim.keymap.set('n', '<leader>gtig', builtin.git_commits)
