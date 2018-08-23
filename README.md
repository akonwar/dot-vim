# Anshuman's vim setup

## Installation

1. `git clone git@github.com:akonwar/dot-vim.git ~/.vim`
3. `cd ~/.vim`
4. `git submodule update --init --recursive`
5. `ln -s ~/.vim/.vimrc ~/.vimrc`
6. `dnf install -y vim ctags cscope powerline`

## Plugins Information

I use [Pathogen](https://github.com/tpope/vim-pathogen) to manage the following
plugins:

- [vim-airline](https://github.com/vim-airline/vim-airline)
- [vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides.git)
- [vim-markdown](https://github.com/plasticboy/vim-markdown)
- [vim-polyglot](https://github.com/sheerun/vim-polyglot)
- [vim-syntastic](https://github.com/vim-syntastic/syntastic.git)
- [vim-tagbar](https://github.com/majutsushi/tagbar.git)

## Shortcut Keys

Shortcut | Function
-------- | --------
\<F5\> | Show set list (whitespaces, tabs, and end-of-lines)
\<F6\> | Highlight tabs, trailing whitespaces, and lines that exceed 80 columns
\<F7\> | Run-Show/Hide syntastic error window (cpplint and shellcheck)
\<F8\> | Jump to next syntastic error
\<F9\> | Jump to previous syntastic error
\<F10\> | Show/Hide indent guides
\<F11\> | Show/Hide tag bar
\<C-l\> | Show list of open buffers
\<C-k\> | Switch to next buffer
\<C-j\> | Switch to previous buffer
\<C-a\> | Send cursor to start-of-line
\<C-e\> | Send cursor to end-of-line
\<C-\\\>c | Find functions calling this function
\<C-\\\>d | Find functions called by this function
\<C-\\\>e | Find this egrep pattern
\<C-\\\>f | Find this file
\<C-\\\>g | Find this definition
\<C-\\\>i | Find files #including this file
\<C-\\\>s | Find this C symbol
\<C-\\\>t | Find this text string
\<C-\]\> | Jump to the tag underneath the cursor
\<C-t\> | Jump back up in the tag stack
