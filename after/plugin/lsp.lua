local lsp = require('lsp-zero').preset('recommended')
local lspconfig = require('lspconfig')
local lsp_signature = require('lsp_signature')

local mason = require('mason')
local masonconfig = require('mason-lspconfig')

mason.setup()
masonconfig.setup {
    ensure_installed = {
        'autotools_ls',
        'bashls',
        'clangd',
        'cmake',
        'cssls',
        'gopls',
        'graphql',
        'html',
        'jsonls',
        'lemminx',
        'lua_ls',
        'marksman',
        'pyright',
        'ruby_ls',
        'terraformls',
        'tsserver',
        'yamlls',
    },
    handlers = {
        lsp.default_setup,
        cssls = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            lspconfig.cssls.setup {
                on_attach = lsp.on_attach,
                capabilities = capabilities,
            }
        end,
        html = function()
            lspconfig.html.setup {
                on_attach = lsp.on_attach,
                init_options = {
                    provideFormatter = true
                }
            }
        end,
        jsonls = function()
            lspconfig.tsserver.setup {
                on_attach = lsp.on_attach,
                settings = {
                    format = {
                        enable = true
                    }
                }
            }
        end,
        tsserver = function()
            local format_settings = {
                convertTabsToSpaces = true,
                indentSize = 2,
                semicolons = 'remove',
                tabSize = 2,
                trimTrailingWhitespace = true,
            }
            lspconfig.tsserver.setup {
                on_attach = lsp.on_attach,
                settings = {
                    typescript = {
                        format = format_settings,
                    },
                    javascript = {
                        format = format_settings,
                    },
                }
            }
        end,
        yamlls = function()
            lspconfig.yamlls.setup {
                on_attach = lsp.on_attach,
                settings = {
                    yaml = {
                        completion = true,
                        format = {
                            enabled = true,
                            singleQuote = false,
                        },
                        hover = true,
                        schemas = {
                            ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = {
                                "*openapi.yaml",
                                "*openapi.json",
                            },
                        },
                        schemaStore = {
                            enable = true,
                        },
                    }
                }
            }
        end,
    }
}

lsp.set_preferences({
    sign_icons = {}
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "<leader>gf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
        vim.api.nvim_feedkeys("zz", "n", false)
    end, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
        vim.api.nvim_feedkeys("zz", "n", false)
    end, opts)
    vim.keymap.set("n", "[]", function() vim.diagnostic.setqflist { show = false } end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

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

    lsp_signature.on_attach(client, bufnr)
end)

lsp.setup()
