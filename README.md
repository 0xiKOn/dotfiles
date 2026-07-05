# dotfiles

Personal configuration for an [Athena OS](https://athenaos.org) (Arch-based)
setup running **Hyprland / HyDE**, tracked with a **bare git repository** whose
work-tree is the home directory. The files live in place under `$HOME`; this
repo only stores their history.

## What's inside

| Area          | Files |
|---------------|-------|
| Shell (zsh)   | `.zshrc`, `.zshenv`, `.config/zsh/user.zsh`, `.blerc` |
| Shell (bash)  | `.bashrc`, `.bash_profile`, `.bash_aliases`, `.bash_logout` |
| Hyprland/HyDE | `.config/hypr/` — `hyprland.conf`, `keybindings.conf`, `monitors.conf`, `userprefs.conf`, `windowrules.conf`, `pyprland.toml` |
| Terminal      | `.config/kitty/kitty.conf` |
| Notifications | `.config/dunst/dunstrc` |
| Launcher      | `.config/rofi/` |
| Misc          | `.gitconfig`, `.tmux.conf`, `.vimrc`, `.Xresources`, `.gtkrc-2.0` |
| Applications  | `.local/share/applications/yazi.desktop` |
| Meta          | `.config/dotfiles/` — package lists + helper script (below) |

Secrets are intentionally **not** tracked: no `~/.ssh`, `~/.gnupg`, tokens,
`.npmrc`, or browser data.

## How it works (bare repo)

There is no `.git` folder in `$HOME`. The git database lives in `~/.dotfiles`
and the work-tree is pointed at `$HOME`, via an alias:

```sh
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

Because the work-tree is `$HOME`, a file like `~/.config/hypr/hyprland.conf` is
just the tracked path `.config/hypr/hyprland.conf`. `status.showUntrackedFiles`
is set to `no` so `dot status` reports only tracked files instead of the whole
home directory.

## Daily use

```sh
dot status                              # what changed
dot add ~/.config/kitty/kitty.conf      # start/track a change
dot commit -m "tweak kitty font"
dot push
```

Only files that are **already tracked** are picked up automatically; a brand-new
config must be `dot add`-ed once, after which its changes are tracked normally.

## Package lists

`~/.config/dotfiles/` holds a reproducible record of installed packages:

- `pkglist-native.txt` — explicitly installed native packages (`pacman -Qqen`)
- `pkglist-aur.txt` — foreign/AUR packages (`pacman -Qqem`)
- `update-pkglists.sh` — regenerates both lists

## Restore on a new machine

```sh
# 1. Install packages
sudo pacman -S --needed - < ~/.config/dotfiles/pkglist-native.txt
yay  -S --needed - < ~/.config/dotfiles/pkglist-aur.txt

# 2. Clone the dotfiles into place (bare-repo checkout)
git clone --bare https://github.com/0xiKOn/dotfiles.git "$HOME/.dotfiles"
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dot checkout        # if it lists conflicting files, back them up, then re-run
dot config --local status.showUntrackedFiles no
```

Then reload the shell (`exec zsh`) to pick up the `dot` alias and config.
