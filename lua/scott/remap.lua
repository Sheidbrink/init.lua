local options = { noremap = true }
vim.g.mapleader = ","
vim.keymap.set("n", "<leader>ev", ":cd ~/.config/nvim<CR>:split ./lua/scott/packer.lua<CR>")
vim.keymap.set("n", "<leader>sv", ":source ~/.config/nvim/lua/scott/packer.lua<CR>:cd -<CR>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("w")
    vim.cmd("so")
end)

--Save and load sessions
vim.keymap.set("n", "<leader>ss", ":mksession! " .. os.getenv("HOME") .. "/.vim/sessions/", options)
vim.keymap.set("n", "<leader>sl", ":source " .. os.getenv("HOME") .. "/.vim/sessions/", options)

--vim.keymap.set("n", "<leader>i", "i <ESC>r", options)

--Use jk to escape in i, v, and s mode
vim.keymap.set({ "i", "v", "s" }, "jk", "<Esc>", {})

--Allows you to move around selected line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-1<CR>gv=gv")

--Keep cursor in the center while scrolling or searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzj")
vim.keymap.set("n", "N", "Nzzzv")

--When pasting something that deletes it, it won't replace in the buffer
vim.keymap.set("x", "<leader>p", [["_dP]])
--Deletes into void register
vim.keymap.set("n", "<leader>d", [["_d]])
vim.keymap.set("v", "<leader>d", [["_d]])

--Copy into clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--vim.keymap.set("<leader>ev", ":split $MYVIMRC<CR>", options)
--vim.keymap.set("<leader>sv", ":source $MYVIMRC<CR>:AirlineRefresh<CR>", options)
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>:cclose<CR>", options)
vim.keymap.set("n", "<leader>ws", [[:%s/\s\+$//g<CR>]], options)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--Easier splits
vim.keymap.set("n", "<leader>\"", ":split<CR>", options)
vim.keymap.set("n", "<leader>%", ":vsplit<CR>", options)

--vim.keymap.set("n", "<silent> <leader>t", ":NERDTreeTabsToggle<CR>", options)
--vim.keymap.set("n", "<leader>sr", ":SyntasticReset<CR>", options)

vim.api.nvim_create_user_command("WQ", function()
    vim.cmd("wq")
end, {})
vim.api.nvim_create_user_command("Wq", function()
    vim.cmd("wq")
end, {})
vim.api.nvim_create_user_command("W", function()
    vim.cmd("w")
end, {})
vim.api.nvim_create_user_command("Q", function()
    vim.cmd("q")
end, {})

--currently doesn't work
--vim.api.nvim_create_user_command("WS", function()
--vim.cmd("w !sudo tee %")
--end, {})

--gk will actually move a line on wrap so thikn this does nicer
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
