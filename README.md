# Description

`nvim-bufmode` is a plugin that provides a new mode in Neovim for managing buffers.

# Requirements

* [nvim-libmodal](https://github.com/Iron-E/nvim-libmodal)

# Installation

Either use `packadd` or any package manager.

## Examples

* [dein.vim](https://github.com/Shougo/dein.vim):
	* Add `call dein#add('https://github.com/Iron-E/nvim-bufmode')` to `~/.config/nvim/init.vim`
	* `:call dein#install()`
* [NeoBundle](https://github.com/Shougo/neobundle.vim):
	* Add `NeoBundle 'https://github.com/Iron-E/nvim-bufmode'` to `~/.config/nvim/init.vim`
	* Re-open vim or execute `:source ~/.vimrc`
* [vim-plug](https://github.com/junegunn/vim-plug):
	* Add `Plug 'https://github.com/Iron-E/nvim-bufmode'` to `~/.config/nvim/init.vim`
	* `:PlugInstall` or `$ vim +PlugInstall +qall`
* [Vundle](https://github.com/gmarik/vundle):
	* Add `Plugin 'https://github.com/Iron-E/nvim-bufmode'` to `~/.config/nvim/init.vim`
	* `:PluginInstall` or `$ vim +PluginInstall +qall`

# Usage

Enter `nvim-bufmode` with `<leader><Tab>` or `:BufmodeEnter`.

| Key                                                | Use                               |
|:--------------------------------------------------:|:---------------------------------:|
| `<Esc>`                                            | Leave `bufmode`                   |
| `?`                                                | Show help message                 |
| `^`,`0`,`<Home>`,`<Up>`                            | Go to beginning of buffer list.   |
| `$`,`<End>`,`<Down>`                               | Go to end of buffer list.         |
| `b`,`j`,`h`,`<Left>`,`<PageUp>`                    | Go to buffer left.                |
| `w`,`k`,`l`,`<Right>`,`<PageDown>`                 | Go to buffer right.               |
| `<S-b>`,`<S-j>`,`<S-h>`,`<S-Left>`,`<S-PageUp>`    | Move current buffer to the left.  |
| `<S-w>`,`<S-k>`,`<S-l>`,`<S-Right>`,`<S-PageDown>` | Move current buffer to the right. |
| `d`                                                | Delete the current buffer.        |
| `f`,`g`,`t`                                        | Goto buffer by name.              |
| `p`                                                | Pick buffer for current window.   |
| `r`                                                | Replace current buffer with new.  |

See `:help bufmode-usage` for additional details.

# Documentation

```vim
:help bufmode
```

The actual document for help is in [bufmode.txt](doc/win.txt).
