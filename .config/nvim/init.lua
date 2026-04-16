require("config.lazy")
vim.g.mapleader = " "

require("mini.files").setup()
vim.keymap.set("n", "<leader>e", function()
	require("mini.files").open()
end, { noremap = true, silent = true })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.keymap.set("n", "<leader>yf", function()
    vim.fn.setreg("+", vim.fn.expand("%:."))
end, { desc = "Yank relative path" })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Basic Settings
vim.opt.number = true -- Show line numbers
vim.opt.tabstop = 4 -- Number of spaces tabs count for
vim.opt.softtabstop = 4 -- Number of spaces in tab when editing
vim.opt.shiftwidth = 4 -- Number of spaces to use for autoindent
vim.opt.expandtab = true -- Tabs are spaces
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.autoindent = true -- Good auto indent
vim.opt.wrap = true -- Wrap lines
vim.opt.linebreak = true -- Break lines at word (not in the middle of a word)
vim.opt.clipboard = "unnamedplus"

-- Search settings
vim.opt.incsearch = true -- Search as characters are entered
vim.opt.hlsearch = true -- Highlight matches

-- UI Config
vim.opt.showmatch = true -- Highlight matching [{()}]
vim.opt.cursorline = true -- Highlight current line
vim.opt.wildmenu = true -- Visual autocomplete for command menu

-- Functionality
vim.opt.history = 1000 -- Store lots of command history
vim.opt.undolevels = 1000 -- Lots of undo history
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 3

-- Disable arrow keys to encourage using hjkl
vim.keymap.set("n", "<Up>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<Down>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<Left>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<Right>", "<Nop>", { noremap = true })

-- Color scheme
vim.cmd("syntax enable") -- Enable syntax highlighting
vim.o.background = "dark"
vim.cmd([[colorscheme kanagawa]])
