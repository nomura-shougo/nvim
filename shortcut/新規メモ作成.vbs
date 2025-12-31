Set ws = CreateObject("WScript.Shell")

' 実行ファイルのパス
exePath = """C:\Program Files\Neovide\neovide.exe"""

' 引数の設定
' VBScript内でダブルクォーテーションを含めるには、2つ重ねて表示します ("" -> ")
args = "-- -c ""lua vim.defer_fn(function() vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true)) end, 50)"""

' コマンドの組み立て
command = exePath & " " & args

' 0 はウィンドウ非表示、False は終了を待たない設定
ws.Run command, 0, False
