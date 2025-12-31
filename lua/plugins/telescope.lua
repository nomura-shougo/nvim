return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",  -- Telescopeコマンド実行時に自動ロード
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    "kkharji/sqlite.lua",
    -- "jvgrootveld/telescope-zoxide", -- 一時的に無効化
  },
  config = function()
    local telescope = require("telescope")
    -- local z_utils = require("telescope._extensions.zoxide.utils") -- 無効化

    -- 境界線を明確に表示するための色設定
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#000000', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#000000', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = '#000000', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg = '#000000', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = '#ffffff', bg = '#0066cc', bold = true })
    vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = '#ffffff', bg = '#333333', bold = true })
    vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = '#ffffff', bg = '#333333', bold = true })
    -- ウィンドウの背景
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#ffffff' })
    vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = '#f5f5f5' })

    telescope.setup({
      defaults = {
        -- Neovide対応: ASCII罫線を使用（かぶりなし）
        borderchars = { "-", "|", "-", "|", "+", "+", "+", "+" },
        -- プレビューを有効化
        previewer = true,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        -- その他のデフォルト設定...
        layout_config = {
          horizontal = {
            prompt_position = "bottom",  -- プロンプトを下に配置
            preview_width = 0.5,         -- 横幅の55%をプレビュー
            preview_cutoff = 120,        -- この幅以下ではプレビューを非表示
          },
          width = 0.9,
          height = 0.9,
        },
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        -- Telescope内でのマッピング
        mappings = {
          i = {
            -- Ctrl-pとCtrl-gでTelescopeを閉じる
            ["<C-p>"] = function(prompt_bufnr)
              require('telescope.actions').close(prompt_bufnr)
            end,
            ["<C-g>"] = function(prompt_bufnr)
              require('telescope.actions').close(prompt_bufnr)
            end,
            ["<C-e>"] = function(prompt_bufnr)
              require('telescope.actions').close(prompt_bufnr)
            end,
          },
          n = {
            -- ノーマルモードでも同様
            ["<C-p>"] = function(prompt_bufnr)
              require('telescope.actions').close(prompt_bufnr)
            end,
            ["<C-g>"] = function(prompt_bufnr)
              require('telescope.actions').close(prompt_bufnr)
            end,
            ["<C-e>"] = function(prompt_bufnr)
              require('telescope.actions').close(prompt_bufnr)
            end,
          },
        },
      },
      extensions = {
        frecency = {
          show_scores = false,
          show_unindexed = true,
          ignore_patterns = {"*.git/*", "*/tmp/*", "*/node_modules/*"},
          disable_devicons = false,
          workspaces = {
            ["nvim"] = "C:/Users/user/AppData/Local/nvim",
          }
        },
      },
      -- extensions = {
      --   zoxide = {
      --     prompt_title = "[ Zoxide List ]",
      --     list_command = "zoxide query -ls",
      --     mappings = {
      --       default = {
      --         -- Enterなどを押した時の動作をカスタマイズできます
      --         action = function(selection)
      --         -- 1. 選択したディレクトリに移動 (cd)
      --         --    (Oilを開くだけなら不要ですが、移動しておいた方が後々便利です)
      --         vim.cmd.cd(selection.path)
      --         -- 2. Oil でそのディレクトリを開く
      --         --    require("oil").open(パス) で指定したフォルダをOilで開けます
      --         require("oil").open(selection.path)
      --       end,
      --       },
      --     },
      --   },
      -- },
    })

    -- 拡張をロードする
    telescope.load_extension("frecency")
    -- telescope.load_extension("zoxide") -- 無効化
  end,
  
  -- キーマッピング
  keys = {
    -- -- 1. Zoxide のトグル機能 (C-e とマウス進むボタン) -- 無効化
    -- {
    --   "<C-e>",
    --   function()
    --     -- Telescopeウィンドウが開いているかチェック
    --     local telescope_open = false
    --     for _, win in ipairs(vim.api.nvim_list_wins()) do
    --       local buf = vim.api.nvim_win_get_buf(win)
    --       local ft = vim.bo[buf].filetype
    --       if ft == 'TelescopePrompt' then
    --         telescope_open = true
    --         -- Telescopeを閉じて、元のバッファに戻る
    --         vim.api.nvim_win_close(win, true)
    --
    --         -- 保存されたバッファがあれば、それに戻る
    --         if vim.g.zoxide_previous_buf and vim.api.nvim_buf_is_valid(vim.g.zoxide_previous_buf) then
    --           vim.api.nvim_set_current_buf(vim.g.zoxide_previous_buf)
    --           vim.g.zoxide_previous_buf = nil
    --         end
    --         break
    --       end
    --     end
    --
    --     if not telescope_open then
    --       -- 現在のバッファを保存（Oilや通常ファイルの場合のみ）
    --       local current_buf = vim.api.nvim_get_current_buf()
    --       local current_ft = vim.bo[current_buf].filetype
    --       if current_ft ~= 'TelescopePrompt' then
    --         vim.g.zoxide_previous_buf = current_buf
    --       end
    --
    --       -- zoxideをプレビューなしで開く
    --       require('telescope').extensions.zoxide.list({
    --         previewer = false,
    --         layout_config = {
    --           width = 0.9,
    --           height = 0.8,
    --         }
    --       })
    --     end
    --   end,
    --   mode = {"n", "i"},
    --   desc = "Zoxide: トグル表示"
    -- },
    --
    -- -- マウスの進むボタンでもトグル
    -- {
    --   "<X2Mouse>",
    --   function()
    --     local telescope_open = false
    --     for _, win in ipairs(vim.api.nvim_list_wins()) do
    --       local buf = vim.api.nvim_win_get_buf(win)
    --       local ft = vim.bo[buf].filetype
    --       if ft == 'TelescopePrompt' then
    --         telescope_open = true
    --         vim.api.nvim_win_close(win, true)
    --
    --         -- 保存されたバッファがあれば、それに戻る
    --         if vim.g.zoxide_previous_buf and vim.api.nvim_buf_is_valid(vim.g.zoxide_previous_buf) then
    --           vim.api.nvim_set_current_buf(vim.g.zoxide_previous_buf)
    --           vim.g.zoxide_previous_buf = nil
    --         end
    --         break
    --       end
    --     end
    --
    --     if not telescope_open then
    --       -- 現在のバッファを保存
    --       local current_buf = vim.api.nvim_get_current_buf()
    --       local current_ft = vim.bo[current_buf].filetype
    --       if current_ft ~= 'TelescopePrompt' then
    --         vim.g.zoxide_previous_buf = current_buf
    --       end
    --
    --       require('telescope').extensions.zoxide.list({
    --         previewer = false,
    --         layout_config = {
    --           width = 0.9,
    --           height = 0.8,
    --         }
    --       })
    --     end
    --   end,
    --   mode = {"n", "i"},
    --   desc = "Zoxide: トグル表示 (マウス)"
    -- },
    --
    -- -- マウスのミドルクリックでもトグル
    -- {
    --   "<MiddleMouse>",
    --   function()
    --     local telescope_open = false
    --     for _, win in ipairs(vim.api.nvim_list_wins()) do
    --       local buf = vim.api.nvim_win_get_buf(win)
    --       local ft = vim.bo[buf].filetype
    --       if ft == 'TelescopePrompt' then
    --         telescope_open = true
    --         vim.api.nvim_win_close(win, true)
    --
    --         -- 保存されたバッファがあれば、それに戻る
    --         if vim.g.zoxide_previous_buf and vim.api.nvim_buf_is_valid(vim.g.zoxide_previous_buf) then
    --           vim.api.nvim_set_current_buf(vim.g.zoxide_previous_buf)
    --           vim.g.zoxide_previous_buf = nil
    --         end
    --         break
    --       end
    --     end
    --
    --     if not telescope_open then
    --       -- 現在のバッファを保存
    --       local current_buf = vim.api.nvim_get_current_buf()
    --       local current_ft = vim.bo[current_buf].filetype
    --       if current_ft ~= 'TelescopePrompt' then
    --         vim.g.zoxide_previous_buf = current_buf
    --       end
    --
    --       require('telescope').extensions.zoxide.list({
    --         previewer = false,
    --         layout_config = {
    --           width = 0.9,
    --           height = 0.8,
    --         }
    --       })
    --     end
    --   end,
    --   mode = {"n", "i"},
    --   desc = "Zoxide: トグル表示 (ミドルクリック)"
    -- },

    -- 2. Frecency - 頻度と最近性でファイルを検索
    { "<C-e>", "<cmd>Telescope frecency<CR>", desc = "Frecency: 頻繁に使うファイル" },

    -- 最近開いたファイル (Oldfiles) トグル
    {
      "<C-o>",
      function()
        -- Telescopeウィンドウが開いているかチェック
        local telescope_open = false
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          if ft == 'TelescopePrompt' then
            telescope_open = true
            vim.api.nvim_win_close(win, true)
            break
          end
        end

        if not telescope_open then
          vim.schedule(function()
            require("telescope.builtin").oldfiles()
          end)
        end
      end,
      mode = {"n", "i"},
      desc = "Recent: 最近のファイル（トグル）"
    },


    -- 3. 現ディレクトリのgrep（トグル）
    {
      "<C-g>",
      function()
        -- Telescopeウィンドウが開いているかチェック
        local telescope_open = false
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          if ft == 'TelescopePrompt' then
            telescope_open = true
            vim.api.nvim_win_close(win, true)
            break
          end
        end

        if not telescope_open then
          vim.schedule(function()
            require("telescope.builtin").live_grep()
          end)
        end
      end,
      mode = {"n", "i"},
      desc = "Grep: 文字列検索（トグル）"
    },

    -- 現在開いているバッファのgrep
    { 
      "<Leader>/", -- (例: Buffer Grep の略)
      function()
        require("telescope.builtin").live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep (Open Buffers)",
        })
      end,
      desc = "Grep: 開いているバッファのみ検索" 
    },
    
    -- 3.ファイル名検索（トグル）
    {
      "<C-p>",
      function()
        -- Telescopeウィンドウが開いているかチェック
        local telescope_open = false
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          if ft == 'TelescopePrompt' then
            telescope_open = true
            vim.api.nvim_win_close(win, true)
            break
          end
        end

        if not telescope_open then
          vim.schedule(function()
            require("telescope.builtin").find_files({ hidden = true })
          end)
        end
      end,
      mode = {"n", "i"},
      desc = "Files: ファイル検索（トグル）",
    },
  },
}
