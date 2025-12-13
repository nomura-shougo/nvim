return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    local harpoon = require('harpoon')
    harpoon:setup({
      settings = {
        save_on_toggle = true,
      },
    })

    -- c-d でharpoonをトグル（グローバル、どのバッファからでも使用可能）
    vim.keymap.set('n', '<C-d>', function()
      local list = harpoon:list()
      harpoon.ui:toggle_quick_menu(list)
    end, { desc = "Toggle harpoon list" })

    -- harpoonウィンドウが開いたときの設定
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "harpoon",
      callback = function()
        -- harpoonウィンドウ内でEnterキーを押したときの動作をカスタマイズ
        vim.keymap.set('n', '<CR>', function()
          local line_num = vim.fn.line('.')
          local list = harpoon:list()
          local item = list:get(line_num)

          if item and item.value then
            -- harpoonウィンドウを閉じる
            vim.cmd('close')

            -- Oil.nvimでディレクトリを開く
            vim.schedule(function()
              require('oil').open(item.value)
            end)
          end
        end, { buffer = true, desc = "Open directory in Oil" })

        -- c-dでharpoonを閉じる
        vim.keymap.set('n', '<C-d>', function()
          vim.cmd('close')
        end, { buffer = true, desc = "Close harpoon list" })
      end,
    })
  end,
}
