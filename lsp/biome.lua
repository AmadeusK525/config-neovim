local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.synchronization.dynamicRegistration = true
-- capabilities.textDocument.definition.dynamicRegistration = true
-- capabilities.textDocument.typeDefinition.dynamicRegistration = true
-- capabilities.textDocument.implementation.dynamicRegistration = true
-- capabilities.textDocument.references.dynamicRegistration = true
-- capabilities.textDocument.callHierarchy.dynamicRegistration = true
-- capabilities.textDocument.typeHierarchy.dynamicRegistration = true
-- capabilities.textDocument.documentHighlight.dynamicRegistration = true
-- capabilities.textDocument.documentLink.dynamicRegistration = true
-- capabilities.textDocument.hover.dynamicRegistration = true
-- capabilities.textDocument.codeLens.dynamicRegistration = true
capabilities.workspace.didChangeWatchedFiles = {
    dynamicRegistration = true,
}
capabilities.workspace.didChangeConfiguration = {
    dynamicRegistration = true,
}
capabilities.textDocument.rangeFormatting = {
    dynamicRegistration = true,
}
capabilities.textDocument.onTypeFormatting = {
    dynamicRegistration = true,
}
capabilities.textDocument.rename.dynamicRegistration = true
capabilities.textDocument.documentHighlight.dynamicRegistration = true
capabilities.textDocument.formatting = {
    dynamicRegistration = true,
}

return {
    capabilities = capabilities,
    -- on_attach = function(client, bufnr)
    -- client.capabilities.workspace.didChangeConfiguration.dynamicRegistration = true
    -- client.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
    -- client.capabilities.textDocument.rangeFormatting.dynamicRegistration = true
    -- client.capabilities.textDocument.onTypeFormatting.dynamicRegistration = true
    -- client.capabilities.textDocument.rename.dynamicRegistration = true
    -- client.capabilities.textDocument.formatting.dynamicRegistration = true
    -- client.server_capabilities.documentFormattingProvider = true
    -- client.server_capabilities.documentRangeFormattingProvider = true
    -- end,
    root_dir = require("lspconfig.util").root_pattern("biome.json", "biome.jsonc"),
    single_file_support = false,
}
