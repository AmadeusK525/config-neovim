return {
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
        },
    },
}
