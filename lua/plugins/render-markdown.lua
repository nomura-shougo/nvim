return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown" },
  opts = {
    heading = {
      -- true にすると `#` を隠してアイコンのみにします。
      -- 編集時はカーソルを合わせると `#` が現れます。
      sign = false, 
      
      -- 見出しレベルごとのアイコン
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      
      -- 見出しの背景色を有効にするか（"block" は行全体、"inline" は文字部分のみ）
      width = "block",
      
      -- 見出しの左側のパディング（インデント）
      left_pad = 0,
      
      -- 見出しの右側のパディング
      right_pad = 0,
    },
    code = {
      style = 'full',
      width = "block",
      right_pad = 2,
    },
  },
  -- ▼ ここが追加・変更点です ▼
  config = function(_, opts)
    -- プラグインの読み込み
    require('render-markdown').setup(opts)
    -- === ライトテーマ向け：見やすいカラーパレット設定 === --
    -- fg: 文字色（濃い色にして読みやすく）
    -- bg: 背景色（薄いパステルカラーにして優しく）

    -- H1: 青系 (メインタイトル)
    vim.api.nvim_set_hl(0, 'RenderMarkdownH1',   { fg = '#003366' }) -- 濃いネイビー
    vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = '#e6f2ff' }) -- 薄い青

    -- H2: 緑・ティール系 (セクション)
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2',   { fg = '#004d40' }) -- 濃い緑
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = '#e0f2f1' }) -- 薄いミントグリーン

    -- H3: 紫系 (サブセクション)
    vim.api.nvim_set_hl(0, 'RenderMarkdownH3',   { fg = '#4a148c' }) -- 濃い紫
    vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = '#f3e5f5' }) -- 薄いラベンダー

    -- H4: オレンジ・茶系 (詳細) - 前回見づらかった箇所
    vim.api.nvim_set_hl(0, 'RenderMarkdownH4',   { fg = '#bf360c' }) -- 濃い赤茶色
    vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = '#fbe9e7' }) -- 薄いオレンジ

    -- H5: 黄土色・アンバー系 (さらに詳細)
    vim.api.nvim_set_hl(0, 'RenderMarkdownH5',   { fg = '#827717' }) -- 濃いオリーブ
    vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = '#fffde7' }) -- 薄いクリーム色

    -- H6: グレー系 (最小見出し)
    vim.api.nvim_set_hl(0, 'RenderMarkdownH6',   { fg = '#3e2723' }) -- 濃いセピア
    vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = '#efebe9' }) -- 薄いグレーベージュ

    -- コードブロック (グレー背景)
    vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = '#f5f5f5' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { bg = '#eeeeee', fg = '#222222' })
  end,
}
