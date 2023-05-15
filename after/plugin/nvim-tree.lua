require("nvim-web-devicons").setup()
require("nvim-tree").setup()

vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle)
