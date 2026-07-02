#  Startup 
# Commands to execute on startup (before the prompt is shown)
# Check if the interactive shell option is set
# if [[ $- == *i* ]]; then
#     # This is a good place to load graphic/ascii art, display system information, etc.
#     if command -v pokego >/dev/null; then
#         pokego --no-title -r 1,3,6
#     elif command -v pokemon-colorscripts >/dev/null; then
#         pokemon-colorscripts --no-title -r 1,3,6
#     elif command -v fastfetch >/dev/null; then
#         if do_render "image"; then
#             fastfetch --logo-type kitty
#         fi
#     fi
# fi

#   Overrides 
# HYDE_ZSH_NO_PLUGINS=1 # Set to 1 to disable loading of oh-my-zsh plugins, useful if you want to use your zsh plugins system 
# unset HYDE_ZSH_PROMPT # Uncomment to unset/disable loading of prompts from HyDE and let you load your own prompts
# HYDE_ZSH_COMPINIT_CHECK=1 # Set 24 (hours) per compinit security check // lessens startup time
# HYDE_ZSH_OMZ_DEFER=1 # Set to 1 to defer loading of oh-my-zsh plugins ONLY if prompt is already loaded

if [[ ${HYDE_ZSH_NO_PLUGINS} != "1" ]]; then
    #  OMZ Plugins 
    # manually add your oh-my-zsh plugins here
    plugins=(
        "sudo"
    )
fi

#  Yazi file manager
# Run `y` (not `yazi`) to browse: when you quit with `q`, your shell cd's into
# the directory you ended up in. `yazi` alone still works but won't move your shell.
function y() {
    local tmp cwd
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# dotfiles — bare git repo tracking configs in-place.
# Usage: dot status | dot add ~/.config/kitty/kitty.conf | dot commit -m "msg" | dot push
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
