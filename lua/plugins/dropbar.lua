return {
  "Bekaboo/dropbar.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  opts = {
    bar = {
      enable = function(buf, win, _)
        return vim.fn.win_gettype(win) == ""
          and vim.wo[win].winbar == ""
          and vim.bo[buf].buftype == ""
          and (vim.bo[buf].filetype == "" or vim.bo[buf].filetype ~= "neo-tree")
      end,
    },
  },
}
