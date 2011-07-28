setopt correct        # Correct commands.
setopt correct_all    # Correct all arguments.

# The 'ls' Family
# ------------------------------------------------------------------------------
if [[ "$DISABLE_COLOR" != 'true' ]]; then
  if (( ${+commands[dircolors]} )); then
    dircolors="${commands[dircolors]}"
  fi
  if (( ${+commands[gdircolors]} )); then
    dircolors="${commands[gdircolors]}"
  fi
  if [[ -x "$dircolors" ]] && [[ -e "$HOME/.dir_colors" ]]; then
    eval $("$dircolors" "$HOME/.dir_colors")
    alias ls='ls -hF --group-directories-first --color=auto'
  else
    export CLICOLOR=1
    export LSCOLORS="exfxcxdxbxegedabagacad"
    alias ls='ls -G -F'
  fi
fi

alias ll='ls -lh'            # Show human readable.
alias la='ls -lhA'           # Show hidden files.
alias lx='ls -lhXB'          # Sort by extension.
alias lk='ls -lhSr'          # Sort by size, biggest last.
alias lc='ls -lhtcr'         # Sort by and show change time, most recent last.
alias lu='ls -lhtur'         # Sort by and show access time, most recent last.
alias lt='ls -lhtr'          # Sort by date, most recent last.
alias lm='ls -lha | more'    # Pipe through 'more'.
alias lr='ls -lhR'           # Recursive ls.
alias sl='ls'                # I often screw this up.

# General
# ------------------------------------------------------------------------------
alias cd='nocorrect cd'
alias cp='nocorrect cp -i'
alias find='noglob find'
alias gcc='nocorrect gcc'
alias ln='nocorrect ln -i'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir -p'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i'
alias scp='nocorrect scp'
alias du='du -kh'
alias df='df -kh'
alias pu='pushd'
alias po='popd'
alias _='sudo'
alias o='open'
alias e="$EDITOR"
alias v="$PAGER"
alias b="$BROWSER"
alias history='fc -l 1'
alias get='curl -C - -O'
alias afind='ack -il'
alias type='type -a'
alias ssh='ssh -X'
alias pbc='pbcopy'
alias pbp='pbpaste'
alias print-path='echo -e ${PATH//:/\\n}'
alias t="t --task-dir ~/.tasks --list todo.txt --delete-if-empty"

(( $+commands[ebuild] )) && alias ebuild='nocorrect ebuild'
(( $+commands[gist] )) && alias gist='nocorrect gist'
(( $+commands[heroku] )) && alias heroku='nocorrect heroku'
(( $+commands[hpodder] )) && alias hpodder='nocorrect hpodder'
(( $+commands[mysql] )) && alias mysql='nocorrect mysql'

if [[ -x "${commands[htop]}" ]]; then
  alias top=htop
else
  alias topm='top -o vsize'
  alias topc='top -o cpu'
fi

if [[ "$DISABLE_COLOR" != 'true' ]]; then
  if [[ -x "${commands[colordiff]}" ]]; then
    alias diff='colordiff -u'
    compdef colordiff=diff
  elif [[ -x "${commands[git]}" ]]; then
    function diff() {
      git --no-pager diff --color=always --no-ext-diff --no-index "$@";
    }
    compdef _git diff=git-diff
  else
    alias diff='diff -u'
  fi

  if [[ -x "${commands[colormake]}" ]]; then
    alias make='colormake'
    compdef colormake=make
  fi
fi

# Terminal Multiplexer
alias sl="screen -list"
alias sr="screen -a -A -U -D -R"
alias sn="screen -U -S"
alias tl="tmux list-sessions"
