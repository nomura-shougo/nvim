return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    show_hidden = true,
    
    keymaps = {
      -- マウス操作: ダブルクリックでファイル/フォルダを開く
      ["<2-LeftMouse>"] = {
        desc = "ダブルクリックでファイル/フォルダを開く",
        callback = function()
          local oil = require("oil")
          local entry = oil.get_cursor_entry()

          if not entry then return end

          -- フォルダの場合は<CR>の動作（フォルダに入る）
          if entry.type == "directory" then
            require("oil.actions").select.callback()
          -- ファイルの場合も<CR>の動作（ファイルを開く）
          elseif entry.type == "file" then
            require("oil.actions").select.callback()
          end
        end,
      },
      -- マウス操作: 右クリックでOilを閉じる
      ["<RightMouse>"] = {
        desc = "右クリックでOilを閉じる",
        callback = function()
          -- 遅延実行でより確実に閉じる
          vim.schedule(function()
            require("oil").close()
          end)
        end,
      },
      -- マウス操作: 戻るボタンで一つ上のフォルダに移動
      ["<X1Mouse>"] = {
        desc = "マウス戻るボタンで上のフォルダへ",
        callback = function()
          require("oil.actions").parent.callback()
        end,
      },
      ["t"] = {
        desc = "バッファに即時追加（裏で開く）",
        callback = function()
          local oil = require("oil")
          local entry = oil.get_cursor_entry()

          if not entry or entry.type ~= "file" then
            return
          end

          local dir = oil.get_current_dir()
          local fullpath = dir .. entry.name

          local bufnr = vim.fn.bufadd(fullpath)
          vim.fn.bufload(bufnr)
          vim.bo[bufnr].buflisted = true
        end,
      },
      ["gx"] = {
        desc = "システムデフォルトプログラムで開く",
        callback = function()
          local oil = require("oil")
          local entry = oil.get_cursor_entry()

          if not entry then return end

          local dir = oil.get_current_dir()
          local fullpath = dir .. entry.name

          -- Windows の start コマンドで開く
          vim.fn.system(string.format('start "" "%s"', fullpath))
        end,
      },
      ["ge"] = {
        desc = "エクスプローラーで選択",
        callback = function()
          local oil = require("oil")
          local entry = oil.get_cursor_entry()

          if not entry then return end

          local dir = oil.get_current_dir()
          local fullpath = dir .. entry.name

          -- ファイルでもフォルダでもエクスプローラーで選択状態にする
          vim.fn.system(string.format('explorer /select,"%s"', fullpath))
        end,
      },
      ["yp"] = {
        desc = "Windows形式でパスをコピー",
        callback = function()
          local oil = require("oil")
          local entry = oil.get_cursor_entry()

          if not entry then return end

          local dir = oil.get_current_dir()
          local fullpath = dir .. entry.name

          -- Windows形式に変換（/ を \ に置換）
          local windows_path = fullpath:gsub("/", "\\")

          -- クリップボードにコピー
          vim.fn.setreg("+", windows_path)
          print("Copied: " .. windows_path)
        end,
      },
      ["m"] = {
        desc = "harpoonにディレクトリを登録",
        callback = function()
          local oil = require("oil")
          local entry = oil.get_cursor_entry()
          local dir = oil.get_current_dir()
          local target_dir

          if not entry then
            -- エントリがない場合は現在のディレクトリを登録
            target_dir = dir
          elseif entry.type == "directory" then
            -- カーソル直下がフォルダの場合、そのフォルダを登録
            target_dir = dir .. entry.name
          elseif entry.type == "file" then
            -- カーソル直下がファイルの場合、親ディレクトリを登録
            target_dir = dir
          else
            target_dir = dir
          end

          -- 末尾のスラッシュを削除（統一のため）
          target_dir = target_dir:gsub("/$", "")

          -- harpoonに登録
          local harpoon = require("harpoon")
          harpoon:list():add({
            value = target_dir,
            context = { row = 1, col = 0 }
          })

          print("Added to harpoon: " .. target_dir)
        end,
      },
    },
  },
    config = function(_, opts)
      -- 1. opts テーブルに show_hidden の設定を確実に追加する
    opts.view_options = opts.view_options or {}
    opts.view_options.show_hidden = true

    -- 1. まず opts を使って oil を通常通りセットアップ
    require("oil").setup(opts)

    -- 2. その後にカスタムの autocmd を設定
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        local set = vim.keymap.set
        local key_opts = { buffer = true, desc = "Save without confirm" }

        -- ノーマルモード <C-s>
        set("n", "<C-s>", function()
          require("oil").save({ confirm = false })
        end, key_opts)

        -- 挿入モード <C-s>
        set("i", "<C-s>", function()
          vim.cmd("stopinsert")
          require("oil").save({ confirm = false })
        end, key_opts)
      end,
    })

    -- 3. oil.nvimでディレクトリを開いたときにzoxideに記録
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "oil://*",
      callback = function()
        local oil = require("oil")
        local dir = oil.get_current_dir()
        if dir then
          -- zoxideにディレクトリを追加
          vim.fn.system({"zoxide", "add", dir})
        end
      end,
    })
  end,
}
