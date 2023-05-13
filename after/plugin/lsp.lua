local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        local opts = { buffer = bufnr, desc = desc, remap = false }
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, opts)
    end

    nmap("<leader>f", vim.lsp.buf.format, '')

    nmap("<leader>rn", vim.lsp.buf.rename, '[R]e[n]ame')
    nmap("<leader>ca", vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap("gD", vim.lsp.buf.declaration, '[G]oto [D]efinition')
    nmap("gd", vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap("gi", vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    -- Provided in telescope
    nmap("gr", vim.lsp.buf.references, '[G]oto [R]eferences')
    --nmap("gds", vim.lsp.buf.document_symbols, '[D]ocument [S]ymbols')
    nmap("gws", vim.lsp.buf.workspace_symbol, '[W]orkspace [S]ymbols')
    nmap("<leader>lws", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)

    nmap("<leader>D", vim.lsp.buf.type_definition, 'Type [D]efinition')

    nmap("[d", vim.diagnostic.goto_next, 'Go to next diagnostic message')
    nmap("]d", vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
    nmap("<leader>e", vim.diagnostic.open_float, 'Open diagnostics for float')
    nmap("<leader>q", vim.diagnostic.setloclist, 'Open diagnostics list')

    nmap("K", vim.lsp.buf.hover, 'Hover Documention')
    nmap("<C-k>", vim.lsp.buf.signature_help, 'Signature Documentation')
end

local servers = {
    lua_ls = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        }
    },
    jedi_language_server = {}
}

require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end
}
--for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
--require('lspconfig')[server_name].setup({
--on_attach = on_attach,
--capabilities = capabilities,
--settings = servers[server_name],
--})
--end

vim.diagnostic.config({
    virtual_text = true
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local luasnip = require('luasnip')

luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        --['<C-f>'] = cmp_action.luasnip_jump_forward(),
        --['<C-b>'] = cmp_action.luasnip_jump_backward(),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }
}

local set_sign_icons = function(opts)
    opts = opts or {}

    local sign = function(args)
        if opts[args.name] == nil then
            return
        end

        vim.fn.sign_define(args.hl, {
            texthl = args.hl,
            text = opts[args.name],
            numhl = ''
        })
    end

    sign({ name = 'error', hl = 'DiagnosticSignError' })
    sign({ name = 'warn', hl = 'DiagnosticSignWarn' })
    sign({ name = 'hint', hl = 'DiagnosticSignHint' })
    sign({ name = 'info', hl = 'DiagnosticSignInfo' })
end

set_sign_icons({
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
