return {
    "neovim/nvim-lspconfig",

    opts = {},
    dependencies = {
        { "mason-org/mason.nvim",           opts = {} },
        { "mason-org/mason-lspconfig.nvim", opts = {} },
        {
            "saghen/blink.cmp",
            version = "1.3.1",
            opts = {
                completion = {
                    sources = {
                        per_filetype = {
                            codecompanion = { "codecompanion" },
                        },
                    },
                    list = {
                        selection = {
                            preselect = true,
                            auto_insert = false,
                        },
                    },
                    ghost_text = {
                        enabled = false,
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 10,
                    },
                },
                signature = {
                    enabled = true,
                },
            },
        },
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.goto_next()
                    vim.api.nvim_feedkeys("zz", "n", false)
                end, opts)
                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.goto_prev()
                    vim.api.nvim_feedkeys("zz", "n", false)
                end, opts)
                vim.keymap.set("n", "[]", function() vim.diagnostic.setqflist { show = true } end, opts)
                vim.keymap.set("n", "<leader>qf", function()
                    vim.lsp.buf.code_action({
                        context = {
                            only = code_action_kind_fixes,
                        }
                    })
                end, opts)
                vim.keymap.set("n", "<leader>qr", function()
                    vim.lsp.buf.code_action({
                        context = {
                            only = code_action_kind_refactors,
                        }
                    })
                end, opts)
                vim.keymap.set("n", "<leader>ln", function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        context = {
                            only = { "source.fixAll" },
                        }
                    })
                end, opts)
                vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>he", vim.lsp.buf.signature_help, opts)

                -- Symbol highlight --
                if client.server_capabilities.documentHighlightProvider then
                    vim.cmd [[
                        hi LspReferenceRead cterm=bold ctermbg=65 guibg=#303030
                        hi LspReferenceText cterm=bold ctermbg=65 guibg=#303030
                        hi LspReferenceWrite cterm=bold ctermbg=65 guibg=#303030
                    ]]

                    vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
                    vim.api.nvim_clear_autocmds { buffer = bufnr, group = 'lsp_document_highlight' }
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        callback = vim.lsp.buf.document_highlight,
                        group = 'lsp_document_highlight',
                        buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd('CursorMoved', {
                        callback = vim.lsp.buf.clear_references,
                        group = 'lsp_document_highlight',
                        buffer = bufnr,
                    })
                end
            end
        })
    end
}
