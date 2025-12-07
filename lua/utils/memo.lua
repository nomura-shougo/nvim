local M = {}

-- 内部ロジック: メモを作成して開く
local function open_timestamp_memo()
  local memo_root = vim.fn.expand("~/memo")
  local extension = "" 
  local date_dir = os.date("%Y%m%d")
  local time_file = os.date("%H%M%S") .. extension
  
  local full_dir_path = memo_root .. "/" .. date_dir
  local full_file_path = full_dir_path .. "/" .. time_file

  if vim.fn.isdirectory(full_dir_path) == 0 then
    vim.fn.mkdir(full_dir_path, "p")
  end

  vim.cmd.edit(full_file_path)
  vim.notify("New memo: " .. full_file_path, vim.log.levels.INFO)
end

-- 公開するセットアップ関数
-- ここでキーマップを登録します
function M.setup()
  vim.keymap.set("n", "<C-n>", open_timestamp_memo, { desc = "Memo: Create new timestamped note" })
end

return M
