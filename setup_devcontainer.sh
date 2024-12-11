#!/usr/bin/env bash

# install starship
curl -ss https://starship.rs/install.sh -o install_starship.sh
chmod 755 install_starship.sh
./install_starship.sh -f
rm install_starship.sh

# Setup Neovim from appimage
# see https://github.com/neovim/neovim/blob/master/install.md#install-from-package
sudo rm -rf /squashfs-root
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract >/dev/null
sudo mv squashfs-root /
sudo ln -sf /squashfs-root/AppRun /usr/bin/nvim
rm nvim.appimage
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
