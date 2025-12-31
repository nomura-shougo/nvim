return {
  "dkarter/bullets.vim",
  ft = { "markdown", "text" },  -- .md と .txt でのみ有効化
  config = function()
    -- bullets.vimの設定
    vim.g.bullets_enabled_file_types = {
      'markdown',
      'text',
    }

    -- オプション設定（必要に応じてカスタマイズ）
    vim.g.bullets_enable_in_empty_buffers = 0  -- 空のバッファでは無効
    vim.g.bullets_set_mappings = 1  -- デフォルトのマッピングを有効化
    vim.g.bullets_mapping_leader = ''  -- リーダーキーなし

    -- 箇条書きのマーカー設定
    -- vim.g.bullets_outline_levels = { 'ROM', 'ABC', 'num', 'abc', 'rom', 'std-' }

    -- インデント設定
    vim.g.bullets_auto_indent_after_colon = 1
  end,
}
