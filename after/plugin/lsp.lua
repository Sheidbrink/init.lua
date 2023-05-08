local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "jedi_language_server",
    "lua_ls",
})

-- Fix Undefined global 'vim'
--Will be deprectated in v3.x
lsp.nvim_workspace()

local luasnip = require("luasnip")
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    --['<CR>'] = cmp.mapping.confirm {
    --behavior = cmp.ConfirmBehavior.Replace,
    --select = true,
    --},
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
})

--cmp_mappings['<Tab>'] = nil
--cmp_mappings['<S-Tab>'] = nil

--Deprecated in v3.x
lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_sign_icons({
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
})

lsp.on_attach(function(client, bufnr)
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

    nmap("gd", vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap("gi", vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    -- Provided in telescope
    nmap("gr", vim.lsp.buf.references, '[G]oto [R]eferences')
    --nmap("gds", vim.lsp.buf.document_symbols, '[D]ocument [S]ymbols')
    nmap("gws", vim.lsp.buf.workspace_symbol, '[W]orkspace [S]ymbols')

    nmap("<leader>D", vim.lsp.buf.type_definition, 'Type [D]efinition')

    nmap("[d", vim.diagnostic.goto_next, 'Go to next diagnostic message')
    nmap("]d", vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
    nmap("<leader>vd", vim.diagnostic.open_float, 'Open diagnostics for float')
    nmap("<leader>vl", vim.diagnostic.setloclist, 'Open diagnostics list')

    nmap("K", vim.lsp.buf.hover, 'Hover Documention')
    nmap("<C-k>", vim.lsp.buf.signature_help, 'Signature Documentation')
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})


local cmp_action = require('lsp-zero').cmp_action()

require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    mapping = {
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})
