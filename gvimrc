" GVim configuration file ######################################
" Date: 2013/02/24
" Author: N.Kodaira
"
" -------------------------------------------------------------
" General settings
" -------------------------------------------------------------
" Only GUI
if has('gui_running')
    set guioptions-=m   " Desable the menu bar
    set guioptions-=T   " Desable the tool bar
    set guioptions-=L   " Desable the vertical scroll bar (left).
    set guioptions-=r   " Desable the vertical scroll bar (right).
    set guioptions-=b   " Desable the horizontal scroll bar.
endif

if has('win32')
    set shellslash  " The path delimiter change into "/" from "\".
endif

if has('gui')
    set clipboard+=unnamed  " The yank buffer uses a clipboad.
endif

" -------------------------------------------------------------
" Color settings
" -------------------------------------------------------------
" Enable syntax colors.
syntax enable

" Settings for Zenburn.
if g:colors_name == 'zenburn'
    " Enable zenburn dark color.
    set background=dark
endif

" Status Line settings
augroup MyInsertHook
    autocmd!
    if g:colors_name == "zenburn"
        autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#313633
        autocmd InsertLeave * highlight StatusLine guifg=#313633 guibg=#ccdc90
    elseif g:colors_name == "desert"
        autocmd InsertEnter * highlight StatusLine guibg=black   guifg=#c2bfa5 gui=none
        autocmd InsertLeave * highlight StatusLine guibg=#c2bfa5 guifg=black   gui=none
    endif
augroup END

" -------------------------------------------------------------
" GUI Font settings
" -------------------------------------------------------------
if has('win32')                     " Win32
    set guifont=VL_Gothic:h10.5     " Font: VL Gothic, 10.5 point
elseif has('gui_gtk')               " Unix
    set guifont=VL_ゴシック:h10.5   " Font: VL Gothic, 10.5 point
elseif has('gui_macvim')            " Mac
    set guifont=Monaco:h11          " Font: Monaco, 11 point
endif

