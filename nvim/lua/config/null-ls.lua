local formatters = require("null-ls").builtins.formatting
local stylua = formatters.stylua
local prettier = formatters.prettierd.with({
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
        "markdown",
        "graphql",
    },
})

require("null-ls").setup({
    sources = {
        stylua,
        prettier,
        --.with({
        --args = { "-s", "-", "--search-parent-directories"  },
        --})
        -- require("null-ls").builtins.diagnostics.eslint,
        -- require("null-ls").builtins.completion.spell,
    },
})
