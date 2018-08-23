function! RegularFormatting()
    " Tab settings
    setlocal expandtab
    setlocal shiftwidth=4
    setlocal tabstop=4
    setlocal softtabstop=4

    " Line width and wrap settings
    setlocal textwidth=79
    setlocal formatoptions+=t
    setlocal wrapmargin=2
    setlocal wrap

    " Code indentation settings
    setlocal autoindent
    setlocal cindent
    "setlocal cinoptions=h3,g0,l1,t0,i4,+4,(0,w1,W4
    setlocal cinoptions=N-s,h3,g1,l1,t0,i4,+4,(0,w1,W4
endfunction

function! LinuxFormatting()
    " Tab settings
    setlocal noexpandtab
    setlocal shiftwidth=8
    setlocal tabstop=8
    setlocal softtabstop=8

    " Line width and wrap settings
    setlocal textwidth=80
    setlocal formatoptions+=t
    setlocal wrapmargin=2
    setlocal wrap

    " Code indentation settings
    setlocal cindent
    setlocal cinoptions=:0,l1,t0,g0,(0
endfunction

" For those who want to apply these options conditionally, you can define an
" array of patterns in your vimrc and these options will be applied only if
" the buffer's path matches one of the pattern. In the following example,
" options will be applied only if "/linux/" or "/kernel" is in buffer's path.
"
let g:linuxsty_patterns = [ "linux" ]

function! ConfigureFormatting()
    let apply_linux_style = 0

    if exists("g:linuxsty_patterns")
        let path = expand('%:p')
        for p in g:linuxsty_patterns
            if path =~ p
                let apply_linux_style = 1
                break
            endif
        endfor
    endif

    if apply_linux_style
        call LinuxFormatting()
    else
        call RegularFormatting()
    endif
endfunction

augroup formatting
    autocmd!
    autocmd FileType c,cc,cpp,cxx,h,hpp,sh call ConfigureFormatting()
    autocmd FileType python call RegularFormatting()
    autocmd FileType diff setlocal noet sw=4 ts=4 sts=4
    autocmd FileType kconfig setlocal noet sw=4 ts=4 sts=4
    autocmd FileType dts setlocal noet sw=4 ts=4 sts=4
    autocmd FileType make setlocal noet sw=4 ts=4 sts=4
augroup END


" Highlight whitespaces, tabs, and column exceed errors
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
highlight TrailingWhitespace ctermbg=red ctermfg=white guibg=#592929
highlight Tabs ctermbg=red ctermfg=white guibg=#592929

function! HighlightWSErrors(hl_on)
    if a:hl_on
        let t:hl_ws_er_ol=matchadd('OverLength', '\%>80v.\+')
        let t:hl_ws_er_trlws=matchadd('TrailingWhitespace', '\s\+$')
        let t:hl_ws_er_tbs=matchadd('Tabs', '\t')
    else
        if exists('t:hl_ws_er_ol')
            call matchdelete(t:hl_ws_er_ol)
        endif

        if exists('t:hl_ws_er_trlws')
            call matchdelete(t:hl_ws_er_trlws)
        endif

        if exists('t:hl_ws_er_tbs')
            call matchdelete(t:hl_ws_er_tbs)
        endif
    endif
endfunction

function! ToggleHighlightWSErrors()
    let t:highlight_ws_errors = exists('t:highlight_ws_errors') ?
                \ !t:highlight_ws_errors : 1
    call HighlightWSErrors(t:highlight_ws_errors)
endfunction

call ToggleHighlightWSErrors()

" Keyboard mapping for highlighting errors
inoremap <F6> :call ToggleHighlightWSErrors()<CR>
nnoremap <F6> :call ToggleHighlightWSErrors()<CR>
vnoremap <F6> :call ToggleHighlightWSErrors()<CR>


" Color scheme
colorscheme default
set t_Co=256


" Window settings
set splitbelow
set splitright
set hlsearch
set incsearch
set ruler
set number


" Synchronize with the system clipboard
set clipboard=unnamed


" vim title settings
set title
set titlelen=85
set titlestring=%t\ %m\ %r\%(\ (%{expand(\"%:~:.:h\")})%)\ [%{strftime('%c')}]


" Basic statusline settings
"set laststatus=2
"set statusline=
"set statusline+=\[%F\]\ %m\ %r\ %=\ %p%%\ %l/%L\ %c\ %{strftime('%c')}


" Miscellaneous settings
set backspace=indent,eol,start
set showcmd
set visualbell t_vb=
set novisualbell
set ttyfast
set shortmess=atI
set nostartofline
set whichwrap=b,s,h,l,<,>,[,]
set ffs=unix,dos
set sm
set nofoldenable
set modeline
syntax on
filetype plugin indent on


" Remember line numbers
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" Show whitespaces, tabs, and end-of-lines in set list
set listchars=trail:-,nbsp:+,eol:$,tab:>-

" Keyboard mapping for set list
inoremap <F5> :set list!<CR>
nnoremap <F5> :set list!<CR>
vnoremap <F5> :set list!<CR>


" Commenting and Un-Commenting code
map ,c :s/^/\/\/ /<CR>
map ,u :s/^\/\/ //<CR>


" Keyboard mapping for switching buffers
inoremap <C-l> :ls<CR>
nnoremap <C-l> :ls<CR>
vnoremap <C-l> :ls<CR>
inoremap <C-k> :bnext<CR>
nnoremap <C-k> :bnext<CR>
vnoremap <C-k> :bnext<CR>
inoremap <C-j> :bprevious<CR>
nnoremap <C-j> :bprevious<CR>
vnoremap <C-j> :bprevious<CR>


" Keyboard mapping for home and end
map  <C-a> <Home>
imap <C-a> <Home>
vmap <C-a> <Home>
map  <C-e> <End>
imap <C-e> <End>
vmap <C-e> <End>


" Keyboard mapping for numeric keypad
imap <Esc>OM <c-m>
map  <Esc>OM <c-m>
imap <Esc>OP <nop>
map  <Esc>OP <nop>
imap <Esc>OQ /
map  <Esc>OQ /
imap <Esc>OR *
map  <Esc>OR *
imap <Esc>OS -
map  <Esc>OS -

imap <Esc>Ol +
imap <Esc>Om -
imap <Esc>On .
imap <Esc>Op 0
imap <Esc>Oq 1
imap <Esc>Or 2
imap <Esc>Os 3
imap <Esc>Ot 4
imap <Esc>Ou 5
imap <Esc>Ov 6
imap <Esc>Ow 7
imap <Esc>Ox 8
imap <Esc>Oy 9
imap <Esc>Oz 0


" cscope settings
if has("cscope")
    set nocscopeverbose
    set cscopetag
    set csto=0

    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " Keyboard mapping for cscope
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    " cscope timeout
    "set notimeout
    "set timeoutlen=4000
    "set ttimeout
    "set ttimeoutlen=100
endif


" Plugin Manager
execute pathogen#infect()

" vim-airline plugin settings
let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 50

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2


" vim-polyglot plugin settings
let g:polyglot_disabled = ['markdown']


" vim-markdown plugin settings
let g:vim_markdown_folding_disabled = 1


" vim-syntastic plugin settings
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_checkers = ['cpplint', 'clang-tidy']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_cpplint_args = ''
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

function! ToggleSyntasticCheck()
    if !exists('g:syntastic_check_status')
        let g:syntastic_check_status = 1
        SyntasticCheck
    else
        if g:syntastic_check_status == 1
            let g:syntastic_check_status = 0
            SyntasticReset
        else
            let g:syntastic_check_status = 1
            SyntasticCheck
        endif
    endif
endfunction

" Keyboard mapping for syntastic
inoremap <F7> :call ToggleSyntasticCheck()<CR>
nnoremap <F7> :call ToggleSyntasticCheck()<CR>
vnoremap <F7> :call ToggleSyntasticCheck()<CR>
inoremap <F8> :lprevious<CR>
nnoremap <F8> :lprevious<CR>
vnoremap <F8> :lprevious<CR>
inoremap <F9> :lnext<CR>
nnoremap <F9> :lnext<CR>
vnoremap <F9> :lnext<CR>


" vim-indent-guides plugin settings
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=darkgrey ctermbg=252
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=251

" Keyboard mapping for vim indent guides
inoremap <F10> :IndentGuidesToggle<CR>
nnoremap <F10> :IndentGuidesToggle<CR>
vnoremap <F10> :IndentGuidesToggle<CR>

" vim-tagbar plugin settings

" Keyboard mapping for vim tagbar
inoremap <F11> :TagbarToggle<CR>
nnoremap <F11> :TagbarToggle<CR>
vnoremap <F11> :TagbarToggle<CR>
