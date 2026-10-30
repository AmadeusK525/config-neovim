return {
    "willothy/flatten.nvim",

    -- Ensure it loads before anything else triggers a terminal
    lazy = false,
    priority = 1001,

    opts = {
        window = {
            open = "tab",
        },
    },
}
