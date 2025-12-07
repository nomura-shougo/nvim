return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",  -- Telescopeコマンド実行時に自動ロード
  dependencies = {
    "nvim-lua/plenary.nvim",
    "jvgrootveld/telescope-zoxide", -- これを追加
  },
  config = function()
    local telescope = require("telescope")
    local z_utils = require("telescope._extensions.zoxide.utils")

    -- ライトテーマ用の色設定
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#666666' })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#0066cc' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = '#666666' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg = '#666666' })
    vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = '#ffffff', bg = '#0066cc', bold = true })
    vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = '#ffffff', bg = '#666666', bold = true })
    vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = '#ffffff', bg = '#666666', bold = true })

    telescope.setup({
      defaults = {
        -- シンプルで視認性の高い罫線
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        -- プレビューを有効化
        previewer = true,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        -- その他のデフォルト設定...
        layout_config = {
          horizontal = {
            preview_width = 0.5,   -- 横幅の55%をプレビュー
            preview_cutoff = 120,   -- この幅以下ではプレビューを非表示
          },
        },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
      },
      extensions = {
        zoxide = {
          prompt_title = "[ Zoxide List ]",
          mappings = {
            default = {
              -- Enterなどを押した時の動作をカスタマイズできます
              action = function(selection)
              -- 1. 選択したディレクトリに移動 (cd)
              --    (Oilを開くだけなら不要ですが、移動しておいた方が後々便利です)
              vim.cmd.cd(selection.path)
              -- 2. Oil でそのディレクトリを開く
              --    require("oil").open(パス) で指定したフォルダをOilで開けます
              require("oil").open(selection.path)
            end,            
            },
          },
        },
      },
    })

    -- 拡張をロードする
    telescope.load_extension("zoxide")
  end,
  
  -- キーマッピング
  keys = {
    -- 1. Zoxide でディレクトリ一覧 → 選択してファイル検索
    { "<C-z>", "<cmd>Telescope zoxide list<CR>", desc = "Zoxide: ディレクトリ移動" },
    
    -- 2. 最近開いたファイル (Oldfiles) を開く
    { "<C-h>", "<cmd>Telescope oldfiles<CR>", desc = "Recent: 最近のファイル" },


    -- 3. 現ディレクトリのgrep
    { 
      "<C-g>", 
      "<cmd>Telescope live_grep<CR>", 
      desc = "Grep: 文字列検索" 
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
    
    -- 3.ファイル名検索
    {
      "<C-p>",
      function()
        -- ここで { hidden = true } を渡すのがポイントです
        require("telescope.builtin").find_files({ hidden = true })
      end,
      desc = "Files: ファイル検索 (隠しファイル含む)",
    },
  },
}
