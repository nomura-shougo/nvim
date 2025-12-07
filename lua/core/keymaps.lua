local map=vim.keymap.set
local opts = { noremap = true, silent = true }

map("n","x","\"_x")
map("n","<Leader>d","\"_d")
map("n","<Leader>D","\"_D")
-- map("n","+"," ,")
map("n","<Leader>;","mzA;<ESC>`z")
map("n","<Leader>j","jI")
map("n","<Leader>k","kI")
map("n","<Leader>w","w")

map({"n", "v"}, "y", '"+y')
map("n", "yy", '"+yy')
map("n", "Y", '"+Y')

map("n","<Leader>ay","\"ay")
map("n","<Leader>ap","\"ap")
map("n","<Leader>by","\"by")
map("n","<Leader>bp","\"bp")
map("n","<Leader>cy","\"cy")
map("n","<Leader>cp","\"cp")

map("n","<C-o>","mzo<ESC>`z")
map("n","<C-i>","mzO<ESC>`z")
map("n","<Leader><CR>","mza<CR><ESC>`z")

map("n","<Leader>m",":MarkdownPreview<CR>")
map("n","<Leader><Leader>m",":MarkdownPreviewStop<CR>")

map("n","<Leader>c","q:")
map("n","<Leader>q",":qa<CR>")
map("n","<C-q>",":q<CR>")

map("n","<C-y>","\"+yaw")

map("n","<C-d>","<C-v>")
map("n","<C-u>","U")
map("n","U","<C-r>")

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
map("i", "<C-v>", "<C-r>+", opts)
-- Normalモード: そのまま貼り付け
--map("n", "<C-v>", '"+P', opts)
-- Visualモード: 選択範囲を上書きして貼り付け
map("v", "<C-v>", '"_d"+P', opts)
-- Commandモード（検索窓など）: クリップボードの内容を貼り付け
map("c", "<C-v>", "<C-r>+", opts)
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

map("n", "<C-q>", "<cmd>bd<CR>", { desc = "Close Buffer" })
map("n", "<C-b>", function()
  local oil = require("oil")
  if vim.bo.filetype == "oil" then
    oil.close()
  else
    oil.open()
  end
end, { desc = "Toggle Oil" })

-- ノーマルモード: そのまま保存
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
-- インサートモード: ノーマルモードに戻ってから保存
map("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })
-- + キーでインクリメント
map('n', '+', '<C-a>', { noremap = true })
-- - キーでデクリメント
map('n', '-', '<C-x>', { noremap = true })



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
