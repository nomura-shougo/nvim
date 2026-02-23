vim.opt.shell = '"C:/Program Files/Git/bin/bash.exe"'
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
vim.opt.ambiwidth = 'single'
vim.opt.number = true
-- TABキーを押した時に、2文字分の幅を持ったTABが表示されます。
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
-- tabstop で設定した数の分の半角スペースが入力されます。
vim.opt.expandtab = true

vim.opt.mouse = 'a'

-- ファイル履歴の保存設定（oldfiles用）
vim.opt.shada = "'100,<50,s10,h"
-- '100 = 最近開いた100個のファイルを記録
-- <50  = 各レジスタに最大50行を保存
-- s10  = 10KBを超えるアイテムはスキップ
-- h    = 起動時にhlsearchを無効化

-- Neovide の設定
-- if vim.g.neovide then
--   -- フォント設定（Neovide では必須）
--   vim.o.guifont = "Consolas:h11" -- Windows標準フォント、サイズ11
--   -- アニメーション速度（お好みで調整）
--   -- vim.g.neovide_cursor_animation_length = 0.05
--   -- vim.g.neovide_scroll_animation_length = 0.1
-- end

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
-- 境界線の色を「蛍光色」などにして、マウスの的（マト）として認識しやすくする
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#00ff00", bold = true }) -- 緑色で強調

-- =============================
-- 不可視文字の可視化
-- =============================
vim.opt.list = true  -- 不可視文字を表示
vim.opt.listchars = {
  space = '⋅',       -- 半角スペース
  tab = '>-',        -- タブ文字（2文字で表示）
  eol = '↲',         -- 改行
  trail = '-',       -- 行末のスペース
  extends = '»',     -- 画面右端で折り返す文字
  precedes = '«',    -- 画面左端で折り返す文字
  nbsp = '␣',        -- ノーブレークスペース
}

-- 不可視文字の色をうっすら表示（白テーマ用：白に近い薄いグレー）
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#e0e0e0" })      -- スペースなど
vim.api.nvim_set_hl(0, "NonText", { fg = "#e0e0e0" })         -- 改行など
vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#e0e0e0" })      -- タブなど

-- ターミナルモードのカーソルを縦棒に設定
vim.opt.guicursor:append("t:ver25")  -- ターミナルモードは縦棒（幅25%）

-- ライトテーマ用にターミナルカラーを上書きする設定
-- これにより、「明るい文字」を「暗い文字」に変換して表示します
if vim.o.background == 'light' then
    -- 黒 (文字色として使われることが多い)
    vim.g.terminal_color_0  = '#000000'
    vim.g.terminal_color_8  = '#555555'

    -- 赤
    vim.g.terminal_color_1  = '#cc0000'
    vim.g.terminal_color_9  = '#ff0000'

    -- 緑
    vim.g.terminal_color_2  = '#008700'
    vim.g.terminal_color_10 = '#00d700'

    -- 黄 (白背景だと最も見にくい色) -> 茶色/オレンジ系に変更
    vim.g.terminal_color_3  = '#af8700' 
    vim.g.terminal_color_11 = '#d7af00'

    -- 青
    vim.g.terminal_color_4  = '#0000d7'
    vim.g.terminal_color_12 = '#005fff'

    -- マゼンタ
    vim.g.terminal_color_5  = '#af00af'
    vim.g.terminal_color_13 = '#d700d7'

    -- シアン (これも見にくい) -> 暗い青緑に変更
    vim.g.terminal_color_6  = '#008787'
    vim.g.terminal_color_14 = '#00afaf'

    -- 白 (背景色に近い場合がある) -> グレーに変更
    vim.g.terminal_color_7  = '#bcbcbc'
    vim.g.terminal_color_15 = '#eeeeee'
end

-- Markdownファイル等を開いたときに、半角スペース2つのインデントにする設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.expandtab = true   -- Tabキー入力をスペースに変換
    vim.opt_local.shiftwidth = 2     -- インデントの幅をスペース2つ分に
    vim.opt_local.tabstop = 2        -- Tab文字の表示幅をスペース2つ分に
    vim.opt_local.softtabstop = 2    -- Tabキーを押したときの移動幅をスペース2つ分に
  end,
})

-- コマンドの名前を "RenumberList" と定義します
vim.api.nvim_create_user_command('RenumberList', function(opts)
  -- 選択された範囲の開始行と終了行を取得 (0オリジンにするため -1 しています)
  local start_row = opts.line1 - 1
  local end_row = opts.line2

  -- 選択範囲のテキストを配列として取得
  local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row, false)
  
  local counter = 1

  -- 各行に対して処理を行う
  for i, line in ipairs(lines) do
    -- "^%s*%d+%." : 行頭(^) + 任意の空白(%s*) + 数字(%d+) + ドット(%.)
    local new_line = string.gsub(line, "^%s*%d+%.", function(match)
      -- matchには「  1.」のようにインデントを含んだ文字列が入ってきます
      -- そこから元のインデント（空白部分）だけを抽出します
      local indent = string.match(match, "^%s*")
      
      -- 元のインデント + 新しい連番 + ドット を結合して返します
      local replacement = indent .. counter .. "."
      counter = counter + 1
      return replacement
    end)
    
    -- 置換後の行を配列に保存
    lines[i] = new_line
  end

  -- 置換されたテキストをバッファに書き戻す
  vim.api.nvim_buf_set_lines(0, start_row, end_row, false, lines)

end, { range = true }) -- range = true で範囲選択（Visualモード）からの実行を許可する

-- (おまけ) Visualモードで選択中、<leader>rn でこのコマンドを実行するショートカット
vim.keymap.set('v', '<leader>rn', ':RenumberList<CR>', { noremap = true, silent = true })
