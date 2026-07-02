#
# ~/.bash_profile
#
if [ -x /bin/zsh ]; then
  export SHELL=/bin/zsh
  case $- in (*i*)
    exec -a -zsh "$SHELL"
  esac
fi

# [[ -f ~/.bashrc ]] && . ~/.bashrc
