-- 基本設定やプラグインマネージャーの読み込み
require("core.options")
require("core.keymaps")
require("core.lazy")
require("utils.signs").setup()
require("utils.memo").setup()

-- init.lua への追記用
-- Neovim-Qt (GUI) 用の設定

-- local function setup_gui()
--   -- GUI環境でない場合は何もしない（より柔軟な判定）
--   if not (vim.g.neovim_qt_gui or vim.g.GuiLoaded or vim.fn.exists('g:GuiLoaded') == 1) then
--     return
--   end
--
--   -- フォント設定
--   local font_name = "HackGen Console NF"
--   local current_size = 24
--   local min_size = 6
--   local max_size = 24 -- ★ご希望の上限サイズ設定
--
--   -- フォント適用関数
--   local function set_font()
--     -- フォント名にスペースがある場合のエスケープ処理
--     local font_cmd = string.format("GuiFont! %s:h%d", font_name, current_size)
--     vim.cmd(font_cmd)
--     -- 現在のサイズをコマンドラインに表示
--     print("Font size: " .. current_size) 
--   end
--
--   -- サイズ変更関数
--   local function adjust_font_size(delta)
--     local new_size = current_size + delta
--     if new_size >= min_size and new_size <= max_size then
--       current_size = new_size
--       set_font()
--     else
--       print("Font size limit reached (" .. current_size .. ")")
--     end
--   end
--
--   -- UIの準備が完了したタイミングで実行 (これが重要！)
--   vim.api.nvim_create_autocmd("UIEnter", {
--     callback = function()
--       -- 起動時に一度フォントを適用
--       set_font()
--
--       -- キーマッピングの設定
--       -- Ctrl + ; (環境によっては認識しづらいため、Ctrl+Up/Down推奨)
--       vim.keymap.set('n', '<C-Up>', function() adjust_font_size(1) end, { noremap = true, silent = true })
--       vim.keymap.set('n', '<C-Down>', function() adjust_font_size(-1) end, { noremap = true, silent = true })
--
--       -- マウスホイール (Ctrl + ホイール)
--       vim.keymap.set('n', '<C-ScrollWheelUp>', function() adjust_font_size(1) end, { noremap = true, silent = true })
--       vim.keymap.set('n', '<C-ScrollWheelDown>', function() adjust_font_size(-1) end, { noremap = true, silent = true })
--
--       -- 念のため Ctrl + ; と - も設定（効かない環境が多いですが一応）
--       vim.keymap.set('n', '<C-;>', function() adjust_font_size(1) end, { noremap = true, silent = true })
--       vim.keymap.set('n', '<C-->', function() adjust_font_size(-1) end, { noremap = true, silent = true })
--
--       -- マウスを有効化
--       vim.opt.mouse = 'a'
--
--       -- UIオプション（nvim-qt用のGUI設定）
--       -- pcall を使って安全にコマンドを実行
--       pcall(vim.cmd, 'GuiTabline 1')      -- タブバーを表示
--       pcall(vim.cmd, 'GuiPopupmenu 0')    -- ポップアップメニューは無効
--       pcall(vim.cmd, 'GuiScrollBar 1')    -- スクロールバーを表示
--
--       -- 確認用メッセージ（起動時に表示される）
--       print("nvim-qt GUI設定を適用しました")
--     end,
--   })
-- end
-- setup_gui()


-- ============================
-- Neovide 専用設定
-- ============================
if vim.g.neovide then
    -- 1. フォント設定 (必須: お好みのフォント名に変更してください)
    -- 書式: フォント名:hサイズ
    local font_name = "HackGen Console NF"
    local current_size = 14
    local min_size = 8
    local max_size = 32

    vim.o.guifont = font_name .. ":h" .. current_size

    -- フォントサイズ変更関数
    local function change_font_size(delta)
        current_size = current_size + delta
        if current_size < min_size then
            current_size = min_size
        elseif current_size > max_size then
            current_size = max_size
        end
        vim.o.guifont = font_name .. ":h" .. current_size
        vim.notify("Font size: " .. current_size, vim.log.levels.INFO)
    end

    -- キーマッピング
    vim.keymap.set('n', '<C-;>', function() change_font_size(1) end, { desc = "Increase font size" })
    vim.keymap.set('n', '<C-->', function() change_font_size(-1) end, { desc = "Decrease font size" })

    -- 2. アニメーションの調整
    -- カーソルの動きを滑らかにする（0に近いほど速い。デフォルトは0.13くらい）
    vim.g.neovide_cursor_animation_length = 0.08
    -- カーソルの軌跡（トレイル）の長さ（0.8くらいも人気）
    vim.g.neovide_cursor_trail_size = 0.8
    
    -- 4. ウィンドウの透明度
    -- 背景を少し透過させる（0.0 〜 1.0）
    -- vim.g.neovide_transparency = 0.95
    
    -- 5. 日本語入力(IME)設定
    -- 入力中に変換候補ウィンドウがカーソルに追従するようにする
    vim.g.neovide_input_ime = true
    
    -- 6. リフレッシュレート
    -- モニターに合わせて設定（60, 120, 144など）
    vim.g.neovide_refresh_rate = 60
end

-- -- =========================================
-- -- Goneovim (GUI) 用の設定
-- -- =========================================
-- local function setup_goneovim()
--   -- goneovimでない場合は何もしない
--   if vim.g.goneovim == nil then return end
--
--   -- フォント設定
--   local font_name = "HackGen Console NF"
--   local current_size = 14
--   local min_size = 8
--   local max_size = 24
--
--   -- ウィンドウサイズ設定
--   vim.opt.lines = 40      -- 行数
--   vim.opt.columns = 140   -- 列数
--
--   -- フォント適用関数
--   local function set_font()
--     local font_cmd = string.format("Guifont %s:h%d", font_name, current_size)
--     vim.cmd(font_cmd)
--     print("Goneovim Font size: " .. current_size)
--   end
--
--   -- サイズ変更関数
--   local function adjust_font_size(delta)
--     local new_size = current_size + delta
--     if new_size >= min_size and new_size <= max_size then
--       current_size = new_size
--       set_font()
--     else
--       print("Font size limit reached (" .. current_size .. ")")
--     end
--   end
--
--   -- 起動時に設定を適用
--   vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--       -- フォント設定
--       set_font()
--
--       -- キーマッピング（フォントサイズ調整）
--       vim.keymap.set('n', '<C-Up>', function() adjust_font_size(1) end, { noremap = true, silent = true })
--       vim.keymap.set('n', '<C-Down>', function() adjust_font_size(-1) end, { noremap = true, silent = true })
--       vim.keymap.set('n', '<C-ScrollWheelUp>', function() adjust_font_size(1) end, { noremap = true, silent = true })
--       vim.keymap.set('n', '<C-ScrollWheelDown>', function() adjust_font_size(-1) end, { noremap = true, silent = true })
--
--       -- マウスを有効化
--       vim.opt.mouse = 'a'
--
--       print("Goneovim GUI設定を適用しました")
--     end,
--   })
-- end
-- setup_goneovim()

-- -- nvim-qt用のスクロールバー表示設定
-- vim.api.nvim_create_autocmd("UIEnter", {
--   callback = function()
--     if vim.g.GuiLoaded then
--       vim.cmd([[GuiScrollBar 1]])
--       -- スクロールバーを機能させるためのマウス設定
--       vim.opt.mouse = 'a'
--     end
--   end,
-- })
