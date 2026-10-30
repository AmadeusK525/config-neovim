local M = {}

function M.merge_tables(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == "table" and type(t1[k]) == "table" then
            M.merge_tables(t1[k], v)
        else
            t1[k] = v
        end
    end
    return t1
end

function M.create_floating_window(buf, opts)
    opts = opts or {}

    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.width or math.floor(vim.o.lines * 0.8)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    if not vim.api.nvim_buf_is_valid(buf) then
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    })

    return { buf = buf, win = win }
end

return M
