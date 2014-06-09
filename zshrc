# -----------------------
# OH MY ZSH configuration
# -----------------------

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew osx vi-mode)

source $ZSH/oh-my-zsh.sh

# -----------------------
# ZSH configuration
# -----------------------

# history: drop lines with a space
setopt HIST_IGNORE_SPACE

# pass bad matches on to the command
# fixes git ... HEAD^
unsetopt nomatch

# git prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗%{$reset_color%}"

# -----------------------
# Environment
# -----------------------
#
# set language
export LANG=en_US.UTF-8

# path
export PATH="/usr/sbin:/sbin:${PATH}"

# homebrew
export PATH="/usr/local/bin:/usr/local/sbin:${PATH}"
export DYLD_FALLBACK_LIBRARY_PATH="/usr/local/lib:${DYLD_FALLBACK_LIBRARY_PATH}"
export HOMEBREW_GITHUB_API_TOKEN="b44448fa1fd3466977414b263fb5c7992b12138c"

# cuda
export PATH="/usr/local/cuda/bin:${PATH}"
export DYLD_FALLBACK_LIBRARY_PATH="/usr/local/cuda/lib:${DYLD_FALLBACK_LIBRARY_PATH}"

# python
export PATH="${HOME}/anaconda/bin:${PATH}"
export DYLD_FALLBACK_LIBRARY_PATH="${HOME}/anaconda/lib:${DYLD_FALLBACK_LIBRARY_PATH}"
export PYTHONPATH="${HOME}/anaconda/lib/python2.7/site-packages:$PYTHONPATH"
export PYTHONSTARTUP="${HOME}/.pythonrc.py"

# tex
export PATH="/usr/texbin:${PATH}"

# home collection
export PATH="${HOME}/bin:${PATH}"
export DYLD_FALLBACK_LIBRARY_PATH="${HOME}/lib:${DYLD_FALLBACK_LIBRARY_PATH}"
export PYTHONPATH="${HOME}/python:$PYTHONPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim-term' # see bin/mvim-term
fi
#export GIT_EDITOR=$EDITOR

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# ruby via rvm
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm"

# -----------------------
# Aliases
# -----------------------

## basics

# pass aliases through sudo
alias sudo="sudo "  # space triggers alias substitution

# default args
alias cp="cp -r"
alias mv="mv -i"
alias rm="rm -i"
alias md="mkdir -p"
alias scp="scp -r"
alias sedi="sed -i ''" # skip in-place backups, I never make mistakes

# ls
alias ls="ls -F -G"
alias ll="ls -lh"
alias la="ls -a"
alias lr="ls -t | head -8" # recent activity

# sloppy typing
alias sl="ls"
alias pc="cp"
alias vm="mv"
alias mr="rm"

## search

alias grep="grep --color=auto"
alias grepall="grep -RIn"  # recursive grep on non-binary files

# highlighter
function hl() {
  grep -E $1'|$'
}

# grep paragraphs
function grepp() {
  pattern=$1
  file=$2
  awk 'BEGIN{RS="";ORS="\n\n";FS="\n"}/'$pattern'/' $file | hl $pattern
}

## navigation

# .. = cd ..
# .. n = cd .. n times
function ..() {
  depth=${1:-1}
  for ((i=1; i<depth; i++))
  do
    builtin cd ..
  done
  cd ..
}

# the transition probability of `ls` after `cd` approaches 1,
# so just do the `ls` automatically
function cd() {
  builtin cd "$@"
  ls
}

# quick access to common dirs
function h { cd ~/h/"$*"; }
function c { cd ~/h/context/"$*"; }
function k { cd ~/h/desk/"$*"; }
function n { cd ~/h/notebook/$*; }
function p { cd ~/h/projects/"$*"; }
function w { cd ~/h/work/"$*"; }

## development

alias v="mvim"
alias vv="mvim -v"

alias marked="open -a Marked.app"

# git
alias git="hub" # see http://defunkt.io/hub
alias g="hub"
alias gci="git ci"
alias ga="git a"
alias gap="git add --patch"
alias gs="git st" # I'll worry about shadowing ghostscript if I use it
alias gd="git diff"
alias gds="git diff --stat"
alias gdi="git diff --cached"
alias gl="git lg"
alias gre="git remote"
alias gpu="git push upstream"
alias gpo="git push origin"
alias gps="git push shelhamer"

# tmux
alias tml="tmux ls"
alias tmn="tmux new -s"
alias tma="tmux a -t"
alias tmk="tmux kill-session -t"

# python
alias ipnb='ipython notebook --ip=0.0.0.0 --pylab=inline --notebook-dir'
alias mkve='mkvirtualenv --no-site-packages --python=/usr/local/Cellar/python/2.7.2/bin/python'
alias mkve3='mkvirtualenv --no-site-packages --python=/usr/local/Cellar/python3/3.2/bin/python3'

# matlab
alias matlab="matlab -nosplash -nodesktop"

alias make8='make -j8' # parallelize

## misc.

alias reload="source ~/.zshrc"

# command history inspection
alias count="sort | uniq -c | sort -rn"
alias hist="history | cut -c8- | cut -d' ' -f1 | count"
alias histf="history | cut -c8- | count"

# osx specific: file opening + clipboard
alias o="open"
alias or="open -R"
alias pb="pbcopy"
alias pv="pbpaste"

# disk usage
alias duh="du -h -d=1"

# ----------
# Booksmarks
# ----------

h=/$HOME/h
c=/$HOME/h/context
k=/$HOME/h/desk
n=/$HOME/h/notebook
p=/$HOME/h/projects
ref=/$HOME/h/reference
