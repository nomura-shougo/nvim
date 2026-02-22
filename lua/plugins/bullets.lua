return {
  -- "dkarter/bullets.vim",
  -- -- ft = { "markdown", "text" }, -- ファイルタイプ制限を削除
  -- init = function()
  --   -- bullets.vimの設定（プラグイン読み込み前に適用）
  --   -- 自動番号付けを無効化
  --   vim.g.bullets_renumber_on_change = 0
  --   -- <cr>押下時の自動インデント（番号入力）を無効化
  --   vim.g.bullets_auto_indent_on_return = 0
  --   -- o または O 押下時の自動インデント（番号入力）を無効化
  --   vim.g.bullets_auto_indent_on_o_O = 0

  --   vim.g.bullets_enabled_file_types = {
  --     'markdown',
  --     'text',
  --     'gitcommit',
  --     'scratch'
  --   }

  --   -- オプション設定（必要に応じてカスタマイズ）
  --   vim.g.bullets_enable_in_empty_buffers = 0  -- 空のバッファでは無効
  --   vim.g.bullets_set_mappings = 0  -- デフォルトのマッピングを無効化（カスタムマッピングを使用）
  --   vim.g.bullets_mapping_leader = ''  -- リーダーキーなし

  --   -- カスタムマッピング定義（'o'を除外）
  --   vim.g.bullets_custom_mappings = {
  --     { 'imap', '<cr>', '<Plug>(bullets-newline)' },
  --     { 'inoremap', '<C-cr>', '<cr>' },
  --     -- { 'nmap', 'o', '<Plug>(bullets-newline)' }, -- ノーマルモードの'o'での自動挿入を無効化
  --     { 'vmap', 'gN', '<Plug>(bullets-renumber)' },
  --     { 'nmap', 'gN', '<Plug>(bullets-renumber)' },
  --     { 'nmap', '<leader>x', '<Plug>(bullets-toggle-checkbox)' },
  --     { 'imap', '<C-t>', '<Plug>(bullets-demote)' },
  --     { 'nmap', '>>', '<Plug>(bullets-demote)' },
  --     { 'vmap', '>', '<Plug>(bullets-demote)' },
  --     { 'imap', '<C-d>', '<Plug>(bullets-promote)' },
  --     { 'nmap', '<<', '<Plug>(bullets-promote)' },
  --     { 'vmap', '<', '<Plug>(bullets-promote)' },
  --   }

  --   -- インデント設定
  --   vim.g.bullets_auto_indent_after_colon = 1

  --   -- ファイルタイプに限らずインデントを2スペースに強制固定
  --   vim.api.nvim_create_autocmd("FileType", {
  --     pattern = "*",
  --     callback = function()
  --       vim.opt_local.shiftwidth = 2
  --       vim.opt_local.tabstop = 2
  --       vim.opt_local.softtabstop = 2
  --       vim.opt_local.expandtab = true
        
  --       -- ノーマルモードの'o'でコメントリーダー（箇条書き記号など）が自動挿入されるのを防ぐ
  --       vim.opt_local.formatoptions:remove('o')
  --     end,
  --   })
  -- end,
}
