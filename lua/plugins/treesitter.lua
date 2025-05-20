return {
    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            auto_install = true,

            highlight = {
                enable = true,

                -- Instead of true/false it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        }
    end
}
