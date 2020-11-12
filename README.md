# Description

`nvim-bufmode` is a plugin that provides a new mode in Neo/vim for managing buffers.

Although it is recommended that splits and buffers are used over buffers when possible, there _are_ scenarios when buffers are necessary. This plugin hopes to make that easier.

# Requirements

* [nvim-libmodal](https://github.com/Iron-E/nvim-libmodal)

# Installation

Either use `packadd` or any package manager.

## Examples

* [dein.vim](https://github.com/Shougo/dein.vim):
	* Add `call dein#add('https://github.com/Iron-E/nvim-bufmode')` to `~/.vimrc`
	* `:call dein#install()`
* [NeoBundle](https://github.com/Shougo/neobundle.vim):
	* Add `NeoBundle 'https://github.com/Iron-E/nvim-bufmode'` to `~/.vimrc`
	* Re-open vim or execute `:source ~/.vimrc`
* [vim-plug](https://github.com/junegunn/vim-plug):
	* Add `Plug 'https://github.com/Iron-E/nvim-bufmode'` to `~/.vimrc`
	* `:PlugInstall` or `$ vim +PlugInstall +qall`
* [Vundle](https://github.com/gmarik/vundle):
	* Add `Plugin 'https://github.com/Iron-E/nvim-bufmode'` to `~/.vimrc`
	* `:PluginInstall` or `$ vim +PluginInstall +qall`

# Usage

Enter `nvim-bufmode` with `<leader><Tab>` or `:bufmodeEnter`.

| Key         | Use                                                    |
|:-----------:|:------------------------------------------------------:|
| `<Esc>`     | Leave `bufmode`                                        |
| `?`         | Show help message                                      |
| `^`/`0`     | Go to the beginning of the tab list.                   |
| `<S-0>`     | Move the current tab to the beginning of the tab list. |
| `$`         | Go to the end of the tab list.                         |
| `%`         | Move the current tab to the end of the tab list.       |
| `b`/`j`/`h` | Tab left                                               |
| `w`/`k`/`l` | Tab right                                              |
| `a`         | Append a tab and switch to it.                         |
| `A`         | Append a tab to the end and switch to it.              |
| `i`         | Prepend a tab and switch to it.                        |
| `I`         | Prepend a tab to the beginning and switch to it.       |
| `d`         | Delete the current tab.                                |
| `s`         | Replace the current tab with a new tab.                |

See `:help bufmode-usage` for additional details.

# Documentation

```vim
:help bufmode
```

The actual document for help is in [bufmode.txt](doc/win.txt).
