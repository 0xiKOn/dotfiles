#!/usr/bin/env bash
# Refresh package lists before committing. Then:
#   dot add ~/.config/dotfiles && dot commit -m "update pkglists" && dot push
d="$HOME/.config/dotfiles"
pacman -Qqen > "$d/pkglist-native.txt"
pacman -Qqem > "$d/pkglist-aur.txt"
echo "native: $(wc -l < "$d/pkglist-native.txt")  aur: $(wc -l < "$d/pkglist-aur.txt")"
