# Neovim設定 インストール手順書
2025/12/7  snomu
2025/12/29 snomu

## 環境
Windows11

## 手順
1. Git Bash をインストールする
※WIP※

1. nvim 設定を git cloneする
~/AppData/Local/
配下に git clone によりnvimフォルダを取得する
以下は Git Bashを利用する場合の例
    ```bash
    git clone https://github.com/nomura-shougo/nvim.git ~/AppData/Local/
    ```

1. Neovim をインストールする
https://neovim.io/doc2/install/
「Windows」を選択するとmsi ファイルがダウンロードされる 実行してインストールする
※nvim実行時、下記のエラーが出た場合は、Visual C++ 再頒布可能パッケージを追加でインストールする
    ```
    C:/Program Files/Neovim/bin/nvim.exe: error while loading shared libraries: api-ms-win-crt-locale-l1-1-0.dll: cannot open shared object file: No such file or directory
    ```
    https://learn.microsoft.com/ja-jp/cpp/windows/latest-supported-vc-redist?view=msvc-170#latest-supported-redistributable-version

    ダウンロードした vc_redist.x64.exe をダブルクリックして実行

1. Neovide をインストールする
https://github.com/neovide/neovide/releases
.msi ファイルをダウンロードしてインストール

<!--
ここにコメントを書く 
1. nvim-qt のインストールと利用
GUI版ツールである、nvim-qtを利用する
下記のコマンドを実行する
winget install equalsraf.neovim-qt

1. Nerd Font（ナードフォント）をインストールする
https://github.com/yuru7/HackGen/releases
HackGen_NF zip ファイルを展開して ttf ファイルをインストールする

1. Windows Terminalのフォント設定をする
Windows Terminal を開く
Windows Terminal ▽設定 > プロファイル (Git Bashなど) > 外観 > フォントフェイス
HackGen Console NF
に設定する
※oil.nvim や mini.tabline の動作のために必要
-->

1. zoxide をインストールして、bashrc に設定を追加する
    ```bash
    winget install ajeetdsouza.zoxide
    ```

    .bashrcに以下を追記
    ```.bashrc
    eval "$(zoxide init bash)"
    ```

1. ripgrep をインストールする
ターミナルから以下のコマンドを実行する
    ```bash
    winget install BurntSushi.ripgrep.MSVC
    ```

<!--
1. ショートカットをタスクバーにピン止めする
shortcut フォルダの Neovimショートカットをタスクバーにピン止めする
-->
