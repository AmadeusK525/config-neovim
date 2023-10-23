function ZapColors(color)
    vim.o.background = ""
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    color = color or "kanagawa"
	vim.cmd.colorscheme(color)

    vim.cmd [[
        hi LspReferenceRead cterm=bold ctermbg=65 guibg=#303030
        hi LspReferenceText cterm=bold ctermbg=65 guibg=#303030
        hi LspReferenceWrite cterm=bold ctermbg=65 guibg=#303030
    ]]
end

ZapColors()
