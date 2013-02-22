" Vim configuration file ######################################
" Date: 2013/02/19
" Author: N.Kodaira
"
" -------------------------------------------------------------
" Vundler settings
" -------------------------------------------------------------
set nocompatible                " be iMproved
filetype off                    " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Example --------------------------
"
" Bundle 'rails.vim'                            " vim-scripts repos
" Bundle 'tpope/vim-fugitive'                   " original repos on github
" Bundle 'git://git.wincent.com/command-t.git'  " non github repos
" let Vundle manage Vundle
" ----------------------------------

" plug in --------------------------
" Unite
Bundle 'Shougo/unite.vim'
" VimFiler
Bundle 'Shougo/vimfiler'
" Unite-help
Bundle 'tsukkee/unite-help'
" VimProc
Bundle 'Shougo/vimproc'

" color scheme ---------------------
" Solarized
Bundle 'altercation/vim-colors-solarized'
" Zenburn
Bundle 'Zenburn'

filetype plugin indent on       " Undo filetype

" -------------------------------------------------------------
" Character code settings
" -------------------------------------------------------------
if has('win32')             " Win32
    set encoding=utf-8
    set termencoding=cp932
    set fileencoding=cp932
    set fileformat=dos
elseif has('unix')          " Unix and Mac
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
    set fileformat=unix
endif
set fileencodings=utf-8,ucs-bom,euc-jp,cp932,iso-2022-jp

" -------------------------------------------------------------
" General settings
" -------------------------------------------------------------
" Tab
set tabstop=4                       " tab width
set shiftwidth=4                    " indent tab width

" Show command
set cmdheight=2
set showcmd

" Status bar
set laststatus=2                    " always enable
" filename, character code, newline character
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

set virtualedit=block               " Free cursor mode for visual block mode
set cindent                         " C like indent
set number                          " Show number line
set visualbell                      " flash beep
set foldmethod=syntax               " Line collapse
set list                            " Show invisible character
set listchars=eol:^,tab:>-,trail:-  " Invisible character list
set nowrap                          " No wrap
set expandtab                       " Convert a tab to spaces
set tw=0                            " Column auto control off

" -------------------------------------------------------------
" Backup and swap settings
" -------------------------------------------------------------
set backup      " make backup
set swapfile    " make swap file

" Set the file path
" backupdir: directry to save backup file in.
" direcotry: directry to save swap file in.
set backupdir=~/.vim/work
set directory=~/.vim/work

" -------------------------------------------------------------
" Key mapping settings
" -------------------------------------------------------------
" Normal mode key map  ----------------------------------------
" <F2>: Replace a word on the cursor.
nmap <F2> viwy<Esc>:%s /<C-r>"/ /gc<C-Left><BS>
" <F3>: See " Search settings".
"       Search the word which the cursor is on.
" <F5>: Execute the ctags.
augroup MyNormalMapping
    autocmd!
    autocmd FileType java nmap <buffer> <F5> :!ctags --java-kinds=cfimp -R .<CR>
    autocmd FileType c    nmap <buffer> <F5> :!ctags --c-kinds=+px-d -R .<CR>
augroup END

" -------------------------------------------------------------
" Search settings
" -------------------------------------------------------------
set hlsearch                        " Highlight a search results.
set ignorecase                      " Ignore the case of characters in searches.
set smartcase                       " If there a capital letter, distinguish it.
set wrapscan                        " Loop search
set incsearch                       " Incremental search
autocmd QuickfixCmdPost grep cw     " The Window open when Quickfix posts result

" Search the word which the cursor is on. (directory recursive grep)
nnoremap <silent><expr> <F3> ':vimgrep /' .
            \ input("pattern: ", expand('<cword>')) .
            \ '/gj ' .
            \ input("path: ", getcwd()) .
            \ '**/*<CR>'

" A search result display to the window center.
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" -------------------------------------------------------------
" Color settings
" -------------------------------------------------------------
" Enable the 256 color to terminal
if has('unix')      " unix only
    set t_Co=256
endif

syntax on

" Settings for Zenburn.
if isdirectory(expand('~/.vim/bundle/Zenburn'))
    colorscheme zenburn
    " Background transeparent
    highlight Normal ctermfg=188 ctermbg=none
else
    colorscheme desert
endif

" Status Line settings
augroup MyInsertHook
    autocmd!
    if g:colors_name == "zenburn"
        autocmd InsertEnter * highlight StatusLine ctermfg=186   ctermbg=236
        autocmd InsertLeave * highlight StatusLine ctermfg=236   ctermbg=186
    elseif g:colors_name == "desert"
        autocmd InsertEnter * highlight StatusLine cterm=bold
        autocmd InsertLeave * highlight StatusLine cterm=bold,reverse
    endif
augroup END

" Visible the Zenkaku space
highlight JpSpace ctermbg=Gray guibg=Gray
match JpSpace /　/

" doxygen syntax
let g:load_doxygen_syntax=1
autocmd BufRead *.java set syntax=java.doxygen

" ###############################################################
" Following settings enabled only when the vimproc was installed.
" ###############################################################
if isdirectory(expand('~/.vim/bundle/vimproc')) " {{{

" -------------------------------------------------------------
" Unite settings
" -------------------------------------------------------------
if isdirectory(expand('~/.vim/bundle/unite.vim')) " {{{

" The directory path of Unite data.
let g:unite_data_directory=expand('~/.vim/unite')
" The Unite open position is bottomright.
let g:unite_split_rule='botright'
" The height of window when open the Unite.
let g:unite_winheight=10

" Open Unite buffer list
nnoremap <silent> [b :<C-u>Unite buffer<CR>
" Open Unite help (a select word).
nnoremap <silent> [h :<C-u>Unite help<CR>
nnoremap <silent> [wh :<C-u>UniteWithCursorWord help<CR>
" Open the register list in Unite.
nnoremap <silent> [r :<C-u>Unite register<CR>
" Open the Unite bookmark in Unite.
nnoremap <silent> [a :<C-u>Unite bookmark<CR>
" Search the word which the cursor is on. (directory recursive grep)
nnoremap <silent><expr> <F3> ':Unite -no-quit grep:' .
            \ input("path: ", getcwd()) .
            \ '::' .
            \ input("word: ", expand('<cword>')) .
            \ '<CR>'

" Unite function
function! s:my_unite_settings()
    " f open VimFiler
    nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
    inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
    " Exit the Unite.
    nmap <silent><buffer> <ESC> <Plug>(unite_exit)
endfunction

" Unite dinamic setting.
augroup MyUnite
    autocmd!
    autocmd FileType unite call s:my_unite_settings()
augroup END

endif " }}} - Unite

" -------------------------------------------------------------
" VimFiler settings
" -------------------------------------------------------------
if isdirectory(expand('~/.vim/bundle/vimfiler')) " {{{

" The directory path of Vimfiler data.
let g:vimfiler_data_directory=expand('~/.vim/vimfiler')
" safe mode OFF
let g:vimfiler_safe_mode_by_default=0
" Change "netrw" command to "VimFiler".
let g:vimfiler_as_default_explorer=1

" VimFiler function
function! s:my_vimfiler_settings()
    " Executable file highlight
    highlight vimfilerTypeExecute ctermfg=187 ctermbg=none
endfunction

" VimFiler dinamic setting.
augroup MyVimFiler
    autocmd!
    autocmd FileType vimfiler call s:my_vimfiler_settings()
augroup END

endif " }}} - VimFiler

endif " }}} - vimproc

