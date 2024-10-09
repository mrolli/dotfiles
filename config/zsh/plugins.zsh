# Add in zsh plugins

zinit ice depth=1; zinit light zsh-users/zsh-completions
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit ice depth=1; zinit light Aloxaf/fzf-tab

# See https://wezfurlong.org/wezterm/shell-integration.html
zinit snippet https://raw.githubusercontent.com/wez/wezterm/main/assets/shell-integration/wezterm.sh

# Add direnv and its hook, see https://zdharma-continuum.github.io/zinit/wiki/Direnv-explanation/
zinit from"gh-r" as"program" mv"direnv* -> direnv" \
  atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
  pick"direnv" src="zhook.zsh" for \
    direnv/direnv

# On a MacOS machine I want my macos-goodies
if [ "$(uname -s)" = "Darwin" ]; then
  zinit ice depth=1; zinit light mrolli/zsh-macos-goodies
fi

# keep syntax highlighting last
zinit ice depth=1; zinit light zdharma-continuum/fast-syntax-highlighting
