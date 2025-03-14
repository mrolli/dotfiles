#!/usr/bin/env bash

# install starship
curl -ss https://starship.rs/install.sh -o install_starship.sh
chmod 755 install_starship.sh
./install_starship.sh -f
rm install_starship.sh

# Setup Neovim from appimage
# As we have Homebrew installed, use it to install Neovim, its dependencies and
# some other useful and often used tools.
brew install nvim fzf delta node npm yarn rg fd lazygit
ln -sf ~/dotfiles/nvim ~/.config/nvim

# setup symlinks
mkdir -p ~/.{cache,config,local,ssh}
chmod 700 ~/.{cache,config,local,ssh}
for foo in bash editorconfig gh git starship.toml yamllint zsh; do
  ln -sf ~/dotfiles/config/${foo} ~/.config/${foo}
done

# Setup zsh
ln -sf ~/dotfiles/config/zsh/zshenv ~/.zshenv

# Setup bash
if ! grep bash_profile ~/.bashrc >/dev/null 2>&1; then
  echo "source ~/.bash_profile" >>~/.bashrc
fi
ln -sf ~/dotfiles/config/bash/profile ~/.bash_profile
