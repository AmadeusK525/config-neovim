local utils = require("amadeusk525.utils")

local floating_state = {
    buf = -1,
    win = -1,
}

vim.api.nvim_create_user_command("Floaterminal", function()
    if not vim.api.nvim_win_is_valid(floating_state.win) then
        floating_state = utils.create_floating_window(floating_state.buf)
        if vim.bo[floating_state.buf].buftype ~= "terminal" then
            vim.cmd.term()
        end
    else
        vim.api.nvim_win_hide(floating_state.win)
    end
end, {})

vim.keymap.set({ "n", "t" }, "<leader>ft", vim.cmd.Floaterminal)
