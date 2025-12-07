return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    show_hidden = true,
    
    keymaps = {
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
