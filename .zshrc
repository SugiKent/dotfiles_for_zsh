function chpwd() {echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"}
export LANG=ja_JP.UTF-8

# neovimのためのパス
export XDG_CONFIG_HOME=~/.config

# 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

# 色を使う
#setopt prompt_subst
#色の設定
#export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
#export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
#zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

# 色
#
autoload colors
colors

# プロンプト
PROMPT="%{${fg[green]}%}%~%{${reset_color}%}
[%n]$ "
PROMPT2="%{${fg[yellow]}%} %_ > %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r ? [n,y,a,e] %{${reset_color}%}"

# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# lsがカラー表示になるようエイリアスを設定
case "${OSTYPE}" in
darwin*)
  # Mac
  alias ls="ls -GF"
  ;;
linux*)
  # Linux
  alias ls='ls -F --color'
  ;;
esac

# 自動補完を有効にする
autoload -U compinit; compinit
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

# # ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd

# cd後にll
function chpwd() { ls -lha }

# iTerm2のタブ名を変更する
function title {
     echo -ne "\033]0;"$*"\007"
     }

#カレントディレクトリを表示
#PS1="${HOST%%.*} %1~%(!.#.$) "

#コマンドの候補を表示
setopt correct

#エイリアス
alias ll='ls -lah'
alias status='git status'
alias add='git add'
alias commit='git commit -m'
alias fetch='git fetch'
alias co='git checkout'
alias gpull='git pull'
alias diff='git diff'
alias b='bundle exec'
alias v='vagrant'
merge_master()
{
  git fetch && git checkout master && git pull origin master && git checkout "$1" && git merge master
}
alias merge_master_this_branch='merge_master `git rev-parse --abbrev-ref HEAD`'
alias new_branch='fetch && co master && gpull master && co -b'
alias gpull='git pull origin `git rev-parse --abbrev-ref HEAD`'
alias gpush='git push origin `git rev-parse --abbrev-ref HEAD`'
alias mysql_to_hikakaku_wp_production="mysql -uhikakaku -hhikakaku.com -p hikakaku_wp"
# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

alias b='bundle exec'
alias brs='bundle exec rails s'
alias brc='bundle exec rails c'

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
#Show the status of git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

#export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
export RBENV_ROOT=/usr/local/var/rbenv
eval "$(rbenv init -)"
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.yarn/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Anaconda
export PATH="$PYENV_ROOT/versions/anaconda2-4.4.0/bin/:$PATH"

# VSCodeをターミナルから開けるように
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* }

# PDF解析のpoppler用
export DYLD_LIBRARY_PATH=/usr/local/opt/cairo/lib

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
