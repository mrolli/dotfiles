# 💤 LazyVim

My own Neovim config based on starter template of [LazyVim](https://github.com/LazyVim/LazyVim).

In addition to the standard set of plugins coming with LazyVim I added a bunch
of additional plugins I'm used to. These are added using their own config files,
see `lua/plugins/*.lua`.

## Activated LazyVim Extras

The following LazyVim Extras are activated in `nvim/lua/config/lazy.lua`:

* lazyvim.plugins.extras.editor.navic
* lazyvim.plugins.extras.lang.markdown
* lazyvim.plugins.extras.lang.terraform
* lazyvim.plugins.extras.lang.yaml

## Additional plugins

| Plugin                     |  Description    |
|---------------             |  --------------- |
| NvChad/nvim-colorizer.lua  |  Add visual representaton for colors inline as virtualtext   |
| sainhe/gruvbox-material    |  A great colorscheme based on gruvbox   |
| zbirenbaum/copilot         |  GitHub Copilot at your fingertips   |
| folke/zen-mode.nvim        |  Plugin for distraction free coding |
| folke/twilight.nvim        |  Plugin that dims inactive portions of the code using TreeSitter |

## Custom Keymaps

As I use the Expose keybindings on my Mac, I added new key bindings for moving
lines. These work in normal, insert and virtual mode:

| Keymap | Function    |
|--------| ----------- |
| \<M-k>  | Move current line/selecton up one line   |
| \<M-j>  | Move current line/selecton down one line   |

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
