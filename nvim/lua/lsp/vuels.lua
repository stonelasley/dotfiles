local M = {}

function M.on_attach(client)
    client.resolved_capabilities.document_formatting = true
end

M.cmd = { 'vls' }
M.settings = {
    vetur = {
        completion = {
            autoImport = true,
            useScaffoldSnippets = true,
        },
        --format = {
        --    defaultFormatter = {
        --        html = "prettier",
        --        js = "prettier",
        --        ts = "prettier",
        --    }
        --},
        validation = {
            template = true,
            script = true,
            style = true,
            templateProps = true,
            interpolation = true,
        },
        experimental = {
            templateInterpolationService = true,
        },
    },
}
return M
