#!/usr/bin/env bash

function fatal()
{
    echo "[err]" "$@" >&2
    exit 1
}

# XDG_CONFIG configs
stow --dir=config.d --target $HOME/.config --stow dot-config --dotfiles

# Home configs
stow --dir=config.d --target $HOME --stow home --dotfiles


# Root package will be applied to root directory. Duh...
if [ "$EUID" -eq 0 ]; then
    echo "What are you doing you dummy? You want to ruin your day? I don't want your root!"
    # stow --dir=config.d --target / root 
fi


