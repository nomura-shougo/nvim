return {
  "gaoDean/autolist.nvim",
  ft = { "markdown", "text" },
  config = function()
    require("autolist").setup({
      -- 箇条書きリストのみ有効化（順序付きリストは除外）
      lists = {
        markdown = {
          "[-+*]", -- 箇条書きリスト (-, +, *) のみ有効化
          -- 順序付きリストのパターンは含めない:
          -- "%d+[.)]"  -- 数字リスト (1., 2.)
          -- "%a[.)]"   -- アルファベットリスト (a., b.)
          -- "%u*[.)]"  -- ローマ数字リスト (I., II.)
        },
        text = {
          "[-+*]",
        },
      },
    })

    -- FileType autocmd でキーマッピングを設定
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "text" },
      callback = function()
        -- 空行でタブを押したときにスペースを挿入、それ以外はインデント増加
        local function smart_tab()
          local line = vim.api.nvim_get_current_line()
          local row = vim.api.nvim_win_get_cursor(0)[1]

          -- 空行または空白のみの行の場合
          if line:match("^%s*$") then
            -- 通常のタブを挿入
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
          else
            -- 行頭のスペース数を取得
            local indent = line:match("^%s*")
            local shiftwidth = vim.bo.shiftwidth
            local rest = line:sub(#indent + 1) -- インデント以降の内容

            -- 新しいインデントを作成（shiftwidth 分増加）
            local new_indent = string.rep(" ", #indent + shiftwidth)
            local new_line = new_indent .. rest

            -- 行を置き換え
            vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })

            -- カーソル位置を行末に移動
            vim.api.nvim_win_set_cursor(0, { row, #new_line })
          end
        end

        -- Shift+Tab: スペースのみの行なら2つ削除、それ以外はインデント減少
        local function smart_shift_tab()
          local line = vim.api.nvim_get_current_line()
          local row = vim.api.nvim_win_get_cursor(0)[1]
          local shiftwidth = vim.bo.shiftwidth

          -- スペースのみの行の場合
          if line:match("^%s+$") then
            local current_indent = #line
            local new_indent_size = math.max(0, current_indent - shiftwidth)
            local new_line = string.rep(" ", new_indent_size)

            vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
            vim.api.nvim_win_set_cursor(0, { row, #new_line })
          elseif line:match("^%s*$") then
            -- 完全な空行の場合は何もしない
            return
          else
            -- 通常の行: 行頭のスペース数を取得
            local indent = line:match("^%s*")
            local rest = line:sub(#indent + 1) -- インデント以降の内容

            -- 新しいインデントを作成（shiftwidth 分減少、最小0）
            local new_indent_size = math.max(0, #indent - shiftwidth)
            local new_indent = string.rep(" ", new_indent_size)
            local new_line = new_indent .. rest

            -- 行を置き換え
            vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })

            -- カーソル位置を行末に移動
            vim.api.nvim_win_set_cursor(0, { row, #new_line })
          end
        end

        vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", { buffer = true })
        vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>", { buffer = true })
        vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", { buffer = true })

        -- Tab: 空行ならスペース、それ以外はインデント
        vim.keymap.set("i", "<Tab>", smart_tab, { buffer = true })
        -- Shift+Tab: スマートインデント
        vim.keymap.set("i", "<S-Tab>", smart_shift_tab, { buffer = true })
        vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>", { buffer = true })
        vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>", { buffer = true })

        vim.keymap.set("n", "<leader>x", "<cmd>AutolistToggleCheckbox<cr>", { buffer = true })
        vim.keymap.set("n", "<leader>r", "<cmd>AutolistRecalculate<cr>", { buffer = true })
      end,
    })
  end,
}
