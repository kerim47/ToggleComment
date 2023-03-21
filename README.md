# ToggleComment

This is a simple Neovim plugin to print stuff when `nvim` is starting up.

## Installation

### vim-plug

An example of how to load this plugin using vim-plug:

```VimL
Plug 'kerim47/ToggleComment'
```

After running `:PlugInstall`, the files should appear in your `~/.config/nvim/plugged` directory (or whatever path you have configured for plugins).


### How can I map a specific key or shortcut to open ToggleComment?

ToggleComment doesn't create any shortcuts outside of the ToggleComment window, so as not to overwrite any of your other shortcuts.
Use the `nnoremap` or `vnoremap` command in your `vimrc`. You, of course, have many keys and ToggleComment commands to choose from. 
Here are default shortcut.
```
nnoremap <space>hl :CommentLine<CR>
vnoremap <space>hk :<C-U>CommentBlock<CR>
nnoremap <space>hk :CommentBlock<CR>
```
