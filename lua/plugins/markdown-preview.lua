return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = "cd app && npx --yes yarn install",
  config = function()
    -- ブラウザ設定（Windowsのデフォルトブラウザを使用）
    vim.g.mkdp_auto_start = 0  -- ファイルを開いたときに自動でプレビューを開かない
    vim.g.mkdp_auto_close = 1  -- バッファを閉じたときにプレビューも閉じる
    vim.g.mkdp_refresh_slow = 0  -- リアルタイムでプレビュー更新
    vim.g.mkdp_command_for_global = 0  -- markdownファイルのみで有効
    vim.g.mkdp_open_to_the_world = 0  -- ローカルホストのみ
    vim.g.mkdp_open_ip = '127.0.0.1'
    vim.g.mkdp_port = ''  -- 自動でポートを選択
    vim.g.mkdp_browser = ''  -- デフォルトブラウザを使用
    vim.g.mkdp_echo_preview_url = 1  -- プレビューURLをコマンドラインに表示
    vim.g.mkdp_page_title = '${name}'  -- ページタイトル

    -- プレビューのテーマ設定
    vim.g.mkdp_theme = 'light'  -- 'dark' or 'light'

    -- Markdown設定
    vim.g.mkdp_markdown_css = ''  -- カスタムCSSパス（空の場合はデフォルト）
    vim.g.mkdp_highlight_css = ''  -- コードハイライト用CSS
    vim.g.mkdp_preview_options = {
      mkit = {},
      katex = {},
      uml = {},
      maid = {},
      disable_sync_scroll = 0,
      sync_scroll_type = 'middle',
      hide_yaml_meta = 1,
      sequence_diagrams = {},
      flowchart_diagrams = {},
      content_editable = false,
      disable_filename = 0,
      toc = {}
    }
  end,
}
