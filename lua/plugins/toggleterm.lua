return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 12,  -- ターミナルの高さを12行に設定（小さめ）
      open_mapping = [[<C-t>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = '"C:\\Program Files\\Git\\bin\\bash.exe"',
      float_opts = {
        border = "single",
        winblend = 0,
      },
    })

    -- ターミナルモードでのキーマッピング
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      -- ターミナルウィンドウの高さ調整（GUI的な操作）
      vim.keymap.set('t', '<C-Up>', [[<Cmd>resize +2<CR>]], opts)
      vim.keymap.set('t', '<C-Down>', [[<Cmd>resize -2<CR>]], opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    -- ノーマルモードでもターミナルウィンドウのサイズ調整可能に
    vim.keymap.set('n', '<C-Up>', '<Cmd>resize +2<CR>', { noremap = true, silent = true, desc = "Increase window height" })
    vim.keymap.set('n', '<C-Down>', '<Cmd>resize -2<CR>', { noremap = true, silent = true, desc = "Decrease window height" })
  end,
}
