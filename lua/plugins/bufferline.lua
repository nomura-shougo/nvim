return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- event = "VeryLazy",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- "buffers" または "tabs"
        themable = true,
        numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both"
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,

        -- 表示設定
        indicator = {
          icon = "▎", -- アクティブなバッファのインジケーター
          style = "icon", -- "icon" | "underline" | "none"
        },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",

        -- タブの長さ設定
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,

        -- 診断情報の表示
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,

        -- 特定のファイルタイプを除外
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },

        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin", -- "slant" | "thick" | "thin" | {"any", "any"}
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = "insert_after_current",
      },
    })

    -- キーマッピング
    vim.keymap.set("n", "<C-j>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
    vim.keymap.set("n", "<C-k>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
    vim.keymap.set("n", "<leader>bp", ":BufferLineTogglePin<CR>", { noremap = true, silent = true, desc = "Toggle pin buffer" })
    vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { noremap = true, silent = true, desc = "Delete buffer" })
    vim.keymap.set("n", "<leader>bc", ":BufferLinePickClose<CR>", { noremap = true, silent = true, desc = "Pick close buffer" })
    vim.keymap.set("n", "<leader>bl", ":BufferLineCloseLeft<CR>", { noremap = true, silent = true, desc = "Close left buffers" })
    vim.keymap.set("n", "<leader>br", ":BufferLineCloseRight<CR>", { noremap = true, silent = true, desc = "Close right buffers" })
  end,
}
