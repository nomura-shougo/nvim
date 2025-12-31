local map=vim.keymap.set
local opts = { noremap = true, silent = true }

map("n","x","\"_x")
map("n","<Leader>d","\"_d")
map("n","<Leader>D","\"_D")
-- map("n","+"," ,")
map("n","<Leader>;","mzA;<ESC>`z")
map("n","<Leader>j","jI")
map("n","<Leader>k","kI")

-- <Leader>w で新しいWindows Terminalを開き、カレントファイルでNeovimを起動
map("n", "<Leader>w", function()
  local current_file = vim.fn.expand("%:p")
  local current_dir = vim.fn.expand("%:p:h")

  if current_file == "" or vim.bo.filetype == "oil" then
    -- ファイルがない場合やOilの場合は、カレントディレクトリで開く
    current_dir = vim.fn.getcwd()
    vim.fn.system(string.format('start wt.exe -d "%s" nvim', current_dir))
  else
    -- ファイルがある場合は、そのファイルをNeovimで開く
    local cmd = string.format('start wt.exe -d "%s" nvim "%s"', current_dir, current_file)
    vim.fn.system(cmd)
  end
end, { desc = "Open current file in new Windows Terminal with Neovim" })

map({"n", "v"}, "y", '"+y')
map("n", "yy", '"+yy')
map("n", "Y", '"+Y')

map("n","<Leader>ay","\"ay")
map("n","<Leader>ap","\"ap")
map("n","<Leader>by","\"by")
map("n","<Leader>bp","\"bp")
map("n","<Leader>cy","\"cy")
map("n","<Leader>cp","\"cp")

-- map("n","<C-o>","mzo<ESC>`z")  -- Telescope oldfilesに変更
-- map("n","<C-i>","mzO<ESC>`z")  -- Oil.nvimトグルに変更
map("n","<Leader><CR>","mza<CR><ESC>`z")

-- <C-i>でOil.nvimをトグル
map("n", "<C-i>", function()
  local oil = require("oil")

  -- より確実にOilウィンドウが開いているかチェック
  local is_oil_open = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:match("^oil://") then
      is_oil_open = true
      break
    end
  end

  if is_oil_open then
    oil.close()
  else
    -- 遅延実行で確実に開く
    vim.schedule(function()
      oil.open()
    end)
  end
end, { desc = "Toggle Oil with Ctrl+i" })

map("n","<Leader>m",":MarkdownPreview<CR>")
map("n","<Leader><Leader>m",":MarkdownPreviewStop<CR>")

map("n","<Leader>c","q:")
map("n","<Leader>q",":qa<CR>")

map("n","<C-y>","\"+yaw")
vim.opt.mouse = 'a'

-- <C-d>はharpoonのトグルに使用（harpoon.luaで設定）
-- map("n","<C-d>","<C-v>")
map("n","<C-u>","U")
map("n","U","<C-r>")
map("n","<C-f>","/")
map("n","<C-z>","u")

map("n","n","nzz")
map("n","N","Nzz")
map("v","y","ygv<Esc>")
map("v","p","\"_dP")
map("v","<","<gv")
map("v",">",">gv")
-- map("v","+"," ,")

map("n","<Tab>",">>")
map("i","<Tab>","<C-t>")
map("n","<S-Tab>","<<")
map("i","<S-Tab>","<C-d>")

map("n","<Leader><Leader>r",":source %<CR>")
map("n","<Leader>h",":noh<CR>")
-- map("n","<Leader>f",":Files<CR>")
-- map("n","<Leader><Leader>f",":Rg<CR>")

-- <C-j> で次のバッファ (bnext)
map('n', '<C-j>', ':bnext<CR>', { noremap = true, silent = true })
-- <C-k> で前のバッファ (bprev)
map('n', '<C-k>', ':bprev<CR>', { noremap = true, silent = true })

-- 2. コピー (Ctrl + c)
-- Visualモード（選択時）のみ有効にするのがWindows流です
map("v", "<C-c>", '"+y<Esc>', opts)
-- 2.5. 切り取り (Ctrl + x)
-- Visualモード: 選択範囲を切り取ってシステムクリップボードに保存
map("v", "<C-x>", '"+d', opts)
-- 3. ペースト (Ctrl + v)
-- Insertモード（入力中）: クリップボード(+)の内容を貼り付け
-- map("i", "<C-v>", "<C-r>+", opts)
map('i', '<C-v>', '<C-r><C-p>+', opts)
-- Normalモード: そのまま貼り付け
map("n", "<C-v>", '"+P', opts)
-- Visualモード: 選択範囲を上書きして貼り付け
map("v", "<C-v>", '"_d"+P', opts)
-- Commandモード（検索窓など）: クリップボードの内容を貼り付け
-- Neovide対応: silentを外して描画を有効化
map("c", "<C-v>", "<C-r>+", { noremap = true })
-- ノーマルモードで Ctrl-a を全選択 (ggVG) にマッピング
map('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
-- インサートモードでも Ctrl-a で全選択したい場合（一旦ノーマルに戻って全選択）
map('i', '<C-a>', '<Esc>ggVG', { noremap = true, silent = true })
-- ビジュアルモード中でも Ctrl-a で全選択し直す場合
map('v', '<C-a>', '<Esc>ggVG', { noremap = true, silent = true })

map({"n", "x"}, "J", "5jzz", { desc = "5行下に移動" })
map({"n", "x"}, "K", "5kzz", { desc = "5行上に移動" })
map({"n", "x"}, "H", "<C-u>zz", { desc = "半ページ上へ移動" })
map({"n", "x"}, "L", "<C-d>zz", { desc = "半ページ下へ移動" })

map("n", "<C-q>", function()
  local bufremove = require("mini.bufremove")
  if vim.bo.buftype == "terminal" then
    -- ターミナルは強制削除
    bufremove.delete(0, true)
  else
    -- 通常バッファは mini.bufremove で削除
    bufremove.delete(0, false)
  end
end, { desc = "Close Buffer" })

-- ウィンドウ間の移動
map('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })

-- 右クリックでOilをトグル
map("n", "<RightMouse>", function()
  local oil = require("oil")

  -- より確実にOilウィンドウが開いているかチェック
  local is_oil_open = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:match("^oil://") then
      is_oil_open = true
      break
    end
  end

  if is_oil_open then
    oil.close()
  else
    -- 遅延実行で確実に開く
    vim.schedule(function()
      oil.open()
    end)
  end
end, { desc = "Toggle Oil (Right Click)" })

-- マウスの戻るボタンでOilをトグル（通常ファイル上では開く）
map("n", "<X1Mouse>", function()
  local oil = require("oil")
  if vim.bo.filetype == "oil" then
    -- Oil内では一つ上のフォルダへ（Oil側のkeymapで処理）
    return
  else
    -- 通常ファイル上ではOilを開く
    oil.open()
  end
end, { desc = "Open Oil (Mouse Back)" })

-- ノーマルモード: そのまま保存
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
-- インサートモード: ノーマルモードに戻ってから保存
map("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })
-- + キーでインクリメント
map('n', '+', '<C-a>', { noremap = true })
-- - キーでデクリメント
map('n', '-', '<C-x>', { noremap = true })

-- ターミナルバッファを新規作成（複数作成可能）
map('n', '<C-t>', function()
  -- 新しいターミナルバッファを作成
  vim.cmd('terminal')
  -- ターミナルモードに入る
  vim.cmd('startinsert')
end, { desc = "Create new terminal buffer" })

-- ターミナルモードから通常モードへ
map('t', '<Esc>', '<C-\\><C-n>', { desc = "Exit terminal mode" })

-- ターミナルモードでもウィンドウ移動可能に
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = "Move to left window from terminal" })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = "Move to right window from terminal" })



-- -- =============================
-- --  Move Forward / Backward
-- -- =============================
--
-- local function MoveForward()
--   local pos = vim.fn.getcurpos()
--   vim.cmd("normal! gee")
--   if vim.deep_equal(pos, vim.fn.getcurpos()) then
--     vim.cmd("normal! w")
--   end
-- end
--
-- local function MoveBackward()
--   local pos = vim.fn.getcurpos()
--   vim.cmd("normal! wb")
--   if vim.deep_equal(pos, vim.fn.getcurpos()) then
--     vim.cmd("normal! ge")
--   end
-- end
--
-- map("n","L",function() MoveForward() end)
-- map("n","H",function() MoveBackward() end)

-- =============================
--  パスジャンプ機能
-- =============================

-- Windows形式パスを入力してジャンプ（ファイル/フォルダ自動判定）
map("n", "<Leader>gp", function()
  local path = vim.fn.input("Path: ", "", "file")
  if path == "" then return end

  -- Windowsパスの \ を / に変換
  path = path:gsub("\\", "/")
  path = vim.fn.trim(path)

  if vim.fn.filereadable(path) == 1 then
    -- ファイルの場合: 編集
    vim.cmd("edit " .. vim.fn.fnameescape(path))
  elseif vim.fn.isdirectory(path) == 1 then
    -- フォルダの場合: Oilで開く
    require("oil").open(path)
  else
    print("Path not found: " .. path)
  end
end, { desc = "Jump to path (file or directory)" })

-- クリップボードのパスを開く
map("n", "<Leader>gv", function()
  local path = vim.fn.getreg("+")
  path = path:gsub("\\", "/")
  path = vim.fn.trim(path)

  if vim.fn.filereadable(path) == 1 then
    vim.cmd("edit " .. vim.fn.fnameescape(path))
  elseif vim.fn.isdirectory(path) == 1 then
    require("oil").open(path)
  else
    print("Path not found: " .. path)
  end
end, { desc = "Open path from clipboard" })
