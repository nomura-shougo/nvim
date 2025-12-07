return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    -- デフォルト設定のままで十分使えます
  },
  keys = {
    -- 's' で検索モードを起動
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash: ジャンプ",
    },
    -- 'S' でTreesitterベースの選択
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash: Treesitter選択",
    },
  },
}
