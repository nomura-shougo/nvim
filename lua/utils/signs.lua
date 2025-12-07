local M = {}

local function DefineCustomHighlights()
  -- fg = 文字色, bg = 背景色
  vim.api.nvim_set_hl(0, "MySignYellow", { bg = "#5f5f00", fg = "#ffff00" }) 
  vim.api.nvim_set_hl(0, "MySignGreen",  { bg = "#005f00", fg = "#00ff00" }) 
  vim.api.nvim_set_hl(0, "MySignBlue",   { bg = "#00005f", fg = "#00ffff" }) 
  vim.api.nvim_set_hl(0, "MySignGray",   { bg = "#303030", fg = "#808080" }) 
  vim.api.nvim_set_hl(0, "MySignRed",    { bg = "#5f0000", fg = "#ff0000" }) 
end

local function SignSettings()
  vim.fn.sign_define({
    { name = "Yellow", text = "->", linehl = "MySignYellow", texthl = "MySignYellow" },
    { name = "Green", text = "○", linehl = "MySignGreen",  texthl = "MySignGreen" },
    { name = "Blue", text = "I", linehl = "MySignBlue",   texthl = "MySignBlue" },
    { name = "GrayNoAttention", text = "＼", linehl = "MySignGray", texthl = "MySignGray" },
    { name = "Red", text = "!", linehl = "MySignRed",    texthl = "MySignRed" },
  })
end

local function PlaceSign(signname, lnum)
  -- グループ名（第2引数）を "MySigns" など指定しておくと、後で一括削除しやすいですが、
  -- ここでは簡単のため "" (デフォルトグループ) のままにします。
  vim.fn.sign_place(0, "", signname, "%", { lnum = lnum })
end

local function UnplaceSign(lnum)
  -- シンプルに「その行にある全サインを消す」挙動
  vim.fn.cursor(lnum, 1)
  vim.cmd("sign unplace")
end

local function PlaceSignCurrentLine(signname)
  PlaceSign(signname, vim.fn.line("."))
end

local function PlaceSignVisualLines(signname)
  -- 一度 Visual Mode を抜けて、'< と '> を確定させる
  vim.cmd("normal! \27") 
  
  local lstart = vim.fn.line("'<")
  local lend   = vim.fn.line("'>")
  
  -- 万が一逆順選択された場合の対策
  if lstart > lend then lstart, lend = lend, lstart end

  for lnum = lstart, lend do
    PlaceSign(signname, lnum)
  end
end

local function UnplaceSignVisualLines()
  -- ここも Visual Mode を抜ける
  vim.cmd("normal! \27")

  local lstart = vim.fn.line("'<")
  local lend   = vim.fn.line("'>")
  
  if lstart > lend then lstart, lend = lend, lstart end

  for lnum = lstart, lend do
    UnplaceSign(lnum)
  end
end

local function SetSignMaps()
  local keys = {
    { "mg", "Green" }, { "mr", "Red" }, { "my", "Yellow" },
    { "mb", "Blue" }, { "mn", "GrayNoAttention" }
  }
  for _, key in ipairs(keys) do
    vim.keymap.set("n", key[1], function() PlaceSignCurrentLine(key[2]) end)
    vim.keymap.set("v", key[1], function() PlaceSignVisualLines(key[2]) end)
  end
end

function M.setup()
  -- ハイライト定義関数を呼び出す
  DefineCustomHighlights()
  
  SignSettings()
  SetSignMaps()

  vim.keymap.set("n", "mm", "<Cmd>sign unplace<CR>")
  vim.keymap.set("v", "mm", function() UnplaceSignVisualLines() end)
end

return M
