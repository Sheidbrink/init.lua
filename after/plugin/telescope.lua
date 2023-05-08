local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
--Requires ripgrep https://github.com/BurntSushi/ripgrep
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', '<leader>b', builtin.buffers)
vim.keymap.set('n', '<leader>?', builtin.oldfiles)

--vim.keymap.set('n', "gr", builtin.lsp_references, { desc = '[G]oto [R]eferences' } )
--vim.keymap.set('n', "gds", builtin.lsp_document_symbols, { desc = '[D]ocument [S]ymbols' } )
--vim.keymap.set('n', "gws", builtin.lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' } )
