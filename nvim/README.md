# 💤 LazyVim

My own Neovim config based on starter template of [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Activated LazyVim Extras

A bunch of LazyVim Extras are activated by default, see `lazyvim.json` to see the
list.

## Additional plugins

In addition to the standard set of plugins coming with LazyVim I added a bunch
of additional plugins I regularly use. These are configured in topic based
configuration files, i.e. `ui.lua`. See `lua/plugins/*.lua`.

| Plugin                     | File            |   Description    |
|---------------             |  -------------- |  --------------- |
| sainhe/gruvbox-material    | colorscheme.lua | A great colorscheme based on gruvbox   |
| b0o/incline.nvim           | ui.lua          | Floating status lines |
| folke/zen-mode.nvim        | ui.lua          | Plugin for distraction free coding |
| folke/twilight.nvim        | ui.lua          | Plugin that dims inactive portions of the code using TreeSitter |

## Custom Keymaps

As I have turned off direct yanking to the system clipboard (unnamedplus), there
are additional keymaps regarding system clipboard handling:

| Keymap   | Function    |
|----------| ----------- |
| \<leader>y   | Yank to the clipboard  |
| \<leader>yy   | Yank line to the clipboard  |
| \<leader>p   | Paste fromt the system clipboard  |
| \<leader>d   | Delete to the back hole register |

Other keymaps include:

| Keymap     | Function    |
|----------- | ----------- |
| \<leader>fx | Make current file in buffer executable |
| \<leader>cs | Show list of available snippets for the current filetype |
