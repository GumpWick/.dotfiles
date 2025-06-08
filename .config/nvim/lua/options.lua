vim.cmd("let g:netrw_liststyle = 3")

-- -- Désactiver la couleur de fond pour obtenir celle du terminal
-- vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
-- vim.cmd("hi LineNr guibg=NONE ctermbg=NONE")
-- vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")

local opt = vim.opt


-- langues pour le correcteur
opt.spelllang = { "en_us", "fr" }

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true  -- Indentation intelligente
opt.scrolloff = 3



opt.wrap = false
-- opt.linebreak = true          -- couper proprement sans casser les mots
-- opt.breakindent = true        -- garder indentation pour lignes coupées
-- -- opt.showbreak = "↳"          -- symbole pour indiquer le début d'une ligne coupée
--
--
-- -- Navigation ligne visuelle en mode normal et visuel
-- for _, mode in ipairs({ "n", "v" }) do
--     vim.keymap.set(mode, "j", "gj", { noremap = true, silent = true })
--     vim.keymap.set(mode, "k", "gk", { noremap = true, silent = true })
--     vim.keymap.set(mode, "<Down>", "gj", { noremap = true, silent = true })
--     vim.keymap.set(mode, "<Up>", "gk", { noremap = true, silent = true })
--     vim.keymap.set(mode, "$", "g$", { noremap = true, silent = true })
--     vim.keymap.set(mode, "0", "g0", { noremap = true, silent = true })
-- end




-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- appearance

-- turn on termguicolors for (nightfly) colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- avoir des modif même si on ferme le fichier
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Désactiver la barre du bas
vim.opt.laststatus = 0

-- desactiver indication insert mode, visual mode etc
vim.opt.showmode = false

-- Afficher les numéros de ligne et de colonne dans la ligne de commande
vim.opt.ruler = true

-- Afficher la position relative dans le fichier (top, bottom, etc.)
vim.opt.showcmd = true

-- opt.colorcolumn = "80"

vim.api.nvim_set_keymap('n', '<CR>', ':nohlsearch<CR>', { noremap = true, silent = true })

--désaction l'autocomplétion des commentaires
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})


-- ~~~~~~~ sert à comber le vide dans nvim car, parfois il y a des gaps noirs
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    -- Change explicitement la couleur de fond au moment de quitter
    io.write("\027]11;#101010\027\\")  -- Remplace #000000 par la couleur par défaut de ton terminal `st`
  end,
})


vim.api.nvim_create_autocmd('BufReadPost', {
    desc = 'Open file at the last position it was edited earlier',
    group = misc_augroup,
    pattern = '*',
    command = 'silent! normal! g`"zv'
})

-- -- ~~~~~~~ Le code en dessous permet d'éviter le recul du curseur quand on passe en mode normal

-- vim.api.nvim_create_autocmd("InsertLeave", {
--   callback = function()
--     if vim.fn.col('.') < vim.fn.col('$') then
--       vim.cmd("normal! l")
--     end
--   end,
-- })



-- local function update_bufferline()
--     local buffer_count = #vim.api.nvim_list_bufs()
--     if buffer_count == 1 then
--         vim.opt_local.showtabline = 0  -- Cacher la ligne des onglets (bufferline)
--     else
--         vim.opt_local.showtabline = 2  -- Toujours afficher la ligne des onglets
--     end
-- end


