# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000000
setopt appendhistory extendedglob
bindkey -v
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^r' history-incremental-search-backward

setopt no_beep

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Path
function add_to_path ()
{
    if [[ "$PATH" =~ (^|:)"${1}"(:|$) ]]
    then
        return 0
    fi
    export PATH=${1}:$PATH
}
add_to_path "/usr/local/bin";
add_to_path "${HOME}/bin";

# Aliases
alias g="git"
alias cbr="git rev-parse --abbrev-ref HEAD"
alias grep='grep -E --color=auto'
alias ls="ls -altr";

export GREP_COLOR='1;37;41'

### Ls Color ###
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
autoload -U colors; colors
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt
PROMPT2=$tmp_prompt2
RPROMPT=$tmp_rprompt
SPROMPT=$tmp_sprompt
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

[ -f ~/.zshrc.include ] && source ~/.zshrc.include
