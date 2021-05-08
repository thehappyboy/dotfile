# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# ======= homebrew settings begin
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
# ======= homebrew settings end

# ======= fzf settings begin 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS="\
  --ansi \
  --cycle \
  --layout='reverse' \
  --height='20' \
  --preview='(highlight -O ansi -l {} 2> /dev/null || bat --style=numbers --color=always {} || cat {} || tree -L 2 -C {}) 2> /dev/null | head -200' \
  --preview-window='right:70%:noborder' \
  --bind='?:toggle-preview' \
  --bind='tab:down' \
"
export FZF_DEFAULT_COMMAND_OPTS="
  --hidden \
  --follow \
  --type='f' \
  --exclude='.git' \
"
export FZF_DEFAULT_COMMAND="fd ${FZF_DEFAULT_COMMAND_OPTS}"
# ======== fzf settings end 

# ======== Alias
# ls
alias ls='exa -bh --color=auto --time-style=long-iso'
alias l='ls'
alias ll='ls -lFh '
alias la='ls -lFha'
alias ld='ls -lFha -t=modified'
alias tree='ls -T'
# delta
alias delta='delta --line-numbers --navigate --side-by-side --syntax-theme="Dracula"'

# du
alias df='df -h'
alias du='du -h'

# vim
alias vim='nvim'
alias vi='nvim'

# commands
alias grep='grep --color=auto --binary-files=without-match --directories=skip'
alias t='tail -f'
alias rm='rm -i'
alias rmr='rm -r'
alias cp='cp -i'
alias cpr='cp -r'
alias mv='mv -i'

# Homebrew
alias bws='brew search'
alias bwi='brew install'
alias bwinf='brew info'
alias bwup='brew upgrade'
alias bwh='brew home'

#Ranger
alias ra='ranger'


# ========== Zinit
[[ ! -f ~/.zinit/bin/zinit.zsh ]] && {
    command mkdir -p ~/.zinit
    command git clone https://github.com/zdharma/zinit ~/.zinit/bin
}

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# 加载插件=============


# Fast-syntax-highlighting & autosuggestions

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_COMPLETION_IGNORE='( |man |pikaur -S )*'


zinit light Aloxaf/fzf-tab

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 blockf \
    zsh-users/zsh-completions


zinit wait="1" lucid light-mode for \
	hlissner/zsh-autopair \
	Aloxaf/gencomp \
	skywind3000/z.lua

zinit svn for \
	OMZ::plugins/extract \
	OMZ::plugins/pip

zinit wait="1" lucid for \
    OMZ::lib/clipboard.zsh \
    OMZ::lib/git.zsh \
    OMZ::plugins/systemd/systemd.plugin.zsh \
    OMZ::plugins/sudo/sudo.plugin.zsh \
    OMZ::plugins/git/git.plugin.zsh


# zsh 主题
zinit ice depth=1
zinit light romkatv/powerlevel10k


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh




# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/john/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/john/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/john/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/john/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

