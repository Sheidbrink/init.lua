require("nvim-web-devicons").setup()
require("nvim-tree").setup({
    actions = {
        open_file = {
            resize_window = false,
            --window_picker = { enable = false}
        }
    },
    git = {
        ignore = false
    }
})

vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle)
