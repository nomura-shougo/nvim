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

      -- 【Find Under】カーソル下の単語を選択（デフォルト<C-n>から変更）
      ["Find Under"] = "<Leader>n",
    }

    -- 以下の設定を入れておくと、日本語入力時などの不具合が減ります
    vim.g.VM_mouse_mappings = 1

    -- VMモード開始時に <C-v> でクリップボード貼り付けを有効化
    local au = vim.api.nvim_create_augroup("VM_custom_maps", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = "visual_multi_start",
      group = au,
      callback = function()
        -- Buffer-local mappings to override VM default or ensure precedence
        -- 遅延実行でVMの初期化後にマッピングを適用（インサートモード対策）
        vim.schedule(function()
          vim.keymap.set("n", "<C-v>", '"+P', { buffer = true, silent = true, desc = "VM Paste from clipboard" })
          vim.keymap.set("v", "<C-v>", '"+p', { buffer = true, silent = true, desc = "VM Paste from clipboard" })
          vim.keymap.set("i", "<C-v>", '<C-r>+', { buffer = true, silent = true, desc = "VM Paste from clipboard" })
        end)
      end,
    })

    -- VMモード終了時にマッピングを削除（元の挙動に戻す）
    vim.api.nvim_create_autocmd("User", {
      pattern = "visual_multi_exit",
      group = au,
      callback = function()
        pcall(vim.keymap.del, "n", "<C-v>", { buffer = true })
        pcall(vim.keymap.del, "v", "<C-v>", { buffer = true })
        pcall(vim.keymap.del, "i", "<C-v>", { buffer = true })
      end,
    })
  end,
}
