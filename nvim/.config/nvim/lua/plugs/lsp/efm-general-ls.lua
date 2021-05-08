
-- python
local flake8 = {
    lintCommand = "/Users/john/miniconda3/envs/neovim/bin/flake8 --ignore=E501 --max-line-length 120 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = {"%f=%l:%c: %m"}
}
local isort = {formatCommand = "/Users/john/miniconda3/envs/neovim/bin/isort --quiet -", formatStdin = true}
local black = {formatCommand = "/Users/john/miniconda3/envs/neovim/bin/black --quiet -", formatStdin = true}
-- local yapf = {formatCommand = "/Users/john/miniconda3/envs/neovim/bin/yapf --quiet", formatStdin = true}

-- lua
local luaformat = {
    formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=120 --break-after-table-lb",
    formatStdin = true
}
-- eslint
local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}
-- prettier
local prettier = {
    formatCommand = ([[
        prettier
        ${--config-precedence:configPrecedence}
        ${--tab-width:tabWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
    ]]):gsub(
        "\n",
        ""
    )
}
-- vim
local vint = {lintCommand = "vint -", lintStdin = true, lintFormats = {"%f:%l:%c: %m"}}



require"lspconfig".efm.setup {
    on_attach = require'plugs.lsp.settings'.common_on_attach,
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {'lua', 'python', 'javascriptreact', 'javascript', 'sh', 'html', 'css', 'json', 'yaml', 'markdown'},
    settings = {
        rootMarkers = {'.git/'},
        languages = {
            lua = {luaformat},
            vim = {vint},
            python = {black, isort, flake8},
            typescript = {prettier, eslint},
            javascript = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            javascriptreact = {prettier, eslint},
            yaml = {prettier},
            json = {prettier},
            html = {prettier},
            scss = {prettier},
            css = {prettier},
            markdown = {prettier}
        }
    }
}

