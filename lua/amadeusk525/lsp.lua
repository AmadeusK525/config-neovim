local M = {}

local function enable_dynamic_registration(table)
    for _, v in pairs(table) do
        if type(v) == "table" then
            enable_dynamic_registration(v)
        end
    end

    if table["dynamicRegistration"] ~= nil then
        table["dynamicRegistration"] = true
    end
end

function M.make_client_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    enable_dynamic_registration(capabilities)

    return capabilities
end

return M
