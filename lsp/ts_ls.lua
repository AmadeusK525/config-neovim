
-- Disable formatting because that will be handled by "biome"
-- local format_settings = {
--     convertTabsToSpaces = true,
--     indentSize = 4,
--     indentStyle = "Smart",
--     semicolons = "insert",
--     tabSize = 4,
--     trimTrailingWhitespace = true,
-- }

return {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    init_options = {
        preferences = {
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
            importModuleSpecifierPreference = "non-relative",
        }
    },
    -- settings = {
    --     typescript = {
    --         format = format_settings,
    --     },
    --     javascript = {
    --         format = format_settings,
    --     },
    -- }
}
