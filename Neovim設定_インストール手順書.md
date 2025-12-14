# Neovim設定 インストール手順書
2025/12/7 snomu

1. Git Bash をインストールする
※WIP※

1. NeoVim をインストールする
https://neovim.io/doc2/install/
「Windows」を選択するとmsi ファイルがダウンロードされる 実行してインストールする

1. nvim-qt のインストールと利用
GUI版ツールである、nvim-qtを利用する
下記のコマンドを実行する
winget install equalsraf.neovim-qt

1. Nerd Font（ナードフォント）をインストールする
https://github.com/yuru7/HackGen/releases
zip ファイルを展開して ttf ファイルをインストールする

1. Windows Terminalのフォント設定をする
Windows Terminal を開く
Windows Terminal ▽設定 > プロファイル (Git Bashなど) > 外観 > フォントフェイス
HackGen Console NF
に設定する
※oil.nvim や mini.tabline の動作のために必要

1. nvim 設定を git cloneする
~/AppData/Local/
配下に 「nvim」 フォルダを作成し、 git clone によりnvimフォルダを取得する
以下は Git Bashを利用する場合の例
```bash
mkdir ~/AppData/Local/nvim
git clone https://github.com/nomura-shougo/nvim.git ~/AppData/Local/nvim
```

7. zoxide をインストールして、bashrc に設定を追加する
```bash
winget install ajeetdsouza.zoxide
```

.bashrcに以下を追記
```.bashrc
eval "$(zoxide init bash)"
```

8. ripgrep をインストールする
ターミナルから以下のコマンドを実行する
```bash
winget install BurntSushi.ripgrep.MSVC
```

9. ショートカットをタスクバーにピン止めする
shortcut フォルダの Neovimショートカットをタスクバーにピン止めする
