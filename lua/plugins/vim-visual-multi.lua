return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    -- キーマッピングの上書き設定
    -- 左側が「機能名」、右側が「割り当てたいキー」です
    vim.g.VM_maps = {
      -- 【上下】Alt-j/k でカーソルを追加
      ["Add Cursor Down"] = "<A-j>",
      ["Add Cursor Up"] = "<A-k>",
      
      -- 【マウス】Alt + クリックでカーソル追加
      ["Mouse Cursor"] = "<A-LeftMouse>",
      ["Mouse Word"] = "<A-RightMouse>", -- (おまけ) 右クリックで単語選択
    }

    -- 以下の設定を入れておくと、日本語入力時などの不具合が減ります
    vim.g.VM_mouse_mappings = 1
  end,
}
