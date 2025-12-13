vim.opt.encoding = "utf-8"
vim.opt.runtimepath:append("~/.vim")
vim.opt.clipboard = ""
vim.g.mapleader = " "
vim.opt.autochdir = true
vim.opt.ignorecase = true
vim.opt.whichwrap = "b"
vim.opt.autoindent = true
vim.opt.cursorline = false
vim.opt.cursorcolumn = false
vim.opt.laststatus = 2
vim.opt.ambiwidth = 'double'
vim.opt.number = true
-- TABキーを押した時に、2文字分の幅を持ったTABが表示されます。
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
-- tabstop で設定した数の分の半角スペースが入力されます。
vim.opt.expandtab = true

vim.opt.mouse = 'a'

-- true color 有効化
vim.opt.termguicolors = true
vim.opt.number = true

-- カラースキーム設定
vim.cmd("colorscheme shirotelin")
-- 文字色をかなり明るく（白に近づける）
vim.api.nvim_set_hl(0, "LineNr", { fg = "#AAAAAA" }) 
-- カーソル行は少しだけ濃くして視認性を確保
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#888888" })
-- -- 背景に溶け込むギリギリの薄さ
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#D0D0D0" })
-- -- カーソル行だけは今の位置を知るために少し濃く
-- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#A0A0A0" })

-- =============================
-- STATUSLINE
-- =============================
vim.o.statusline = table.concat({
    "%f",            -- ファイル名
    "%m%r%h%w",      -- 修正フラグ、ReadOnlyフラグ、ヘルプフラグ、プレビューウィンドウフラグ
    "[%{&fileencoding}/%{&fileformat}]", -- エンコード/改行コード
    "%y",            -- ファイルタイプ
    "%=",            -- 右寄せ
    "行:%l/%L",      -- 現在行/総行数
    "列:%c",         -- 現在列（col('.')相当）
    "(%p%%)"         -- ファイル位置 %
}, " ")


vim.cmd("highlight StatusLine guifg=#7f8c8d guibg=#ffffff gui=bold")
vim.cmd("highlight StatusLineNC guifg=#bdc3c7 guibg=#ffffff")
vim.cmd("highlight StatusLineSeparator guifg=#2c3e50 guibg=#ffffff")
-- vim.cmd([[ cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%' ]])
