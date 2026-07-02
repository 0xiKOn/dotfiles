# dotfiles

Personal Hyprland / HyDE (Athena OS) configs + package lists, tracked with a **bare git repo**.

## Daily use (on this machine)
    dot status                         # what changed
    dot add ~/.config/kitty/kitty.conf # stage a changed config
    dot commit -m "tweak kitty font"
    dot push

`dot` = `git --git-dir=$HOME/.dotfiles --work-tree=$HOME` (alias in ~/.config/zsh/user.zsh)

## Restore on a NEW machine
    # 1. install packages
    sudo pacman -S --needed - < ~/.config/dotfiles/pkglist-native.txt
    yay  -S --needed - < ~/.config/dotfiles/pkglist-aur.txt
    # 2. clone the dotfiles into place (bare-repo checkout)
    git clone --bare <REPO_URL> ~/.dotfiles
    alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
    dot checkout        # back up any conflicting files it names, then re-run
    dot config status.showUntrackedFiles no
