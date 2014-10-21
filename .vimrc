set ts=2
set sw=2
set backspace=2
set iskeyword+=:
set nu
set smartindent
set expandtab
set shiftwidth=2
set softtabstop=2
set shellslash
set grepprg=grep\ -nH\ $*
set ic
set smartcase
set laststatus=2
set hlsearch
set mouse=a
set nocompatible
syntax enable
filetype plugin on
filetype indent on
set colorcolumn=80


" Auto remove trailing space on save"
autocmd BufWritePre *.py :%s/\s\+$//e

" -- Smart C++ indent for << by Yucheng Low
setlocal cino=l1,g1,i2s,(0,u0,w1,:1,+2s,N-s,h1,j1,P1
let c_no_curly_error=1

if (!exists("*CppIndentDepth"))
  function CppIndentDepth()
    let l:lineno = v:lnum
    " check if last character is a semicolon
    if l:lineno >= 1 
      let l:prevline= getline(l:lineno - 1)
      " if line does not end with a semicolon
      if match(l:prevline, ";\\s*$") == -1
        " if there is a stream operator align to it
        let l:laststreamop = match(l:prevline, "<<")
        if laststreamop != -1
          return laststreamop 
        endif
      endif
      "lines after template declarations are NOT continuation lines!
      if prevline =~# '^\s*template.*'
        return indent(lineno-1)
      endif
    endif
  return cindent(lineno)
  endfunction
endif
setlocal indentexpr=CppIndentDepth()

" Tabbing for command mode
nmap <S-Tab> <<
" for insert mode
imap <S-Tab> <C-o><<

autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType cython setlocal shiftwidth=4 tabstop=4

" Vundle Plugins "
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'tomtom/tcomment_vim'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'derekwyatt/vim-scala'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-scripts/Vim-R-plugin'
Plugin 'benmills/vimux'
Plugin 'jgors/vimux-ipy'
" All of your Plugins must be added before the following line
call vundle#end()            " required

" Syntastics python setting, requires pip install flake8" 
let g:syntastic_always_populate_loc_list=1
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--max-line-length=120 --ignore=E501,E401,E403'

" CommandT
let g:CommandTMaxFiles=500000
let g:CommandTTraverseSCM="pwd"

" Youcomplete
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_previous_completion = ['<Up>']
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

" Latex
let g:Tex_ViewRule_pdf = 'Preview'
let vimrplugin_screenplugin = 0

" VimIpy
map <Leader>vip :call VimuxIpy()<CR>
vmap <silent> <Leader>e :python run_visual_code()<CR>
noremap <silent> <Leader>c :python run_cell(save_position=False, cell_delim='####')<CR>


" Random utils
function! Box() range
  :'<,'>!boxes -ac -s 76 -k 1 -pa1
endfunction

function! Unbox() range
  :'<,'>!boxes -r
endfunction

function! Cowsay() range
  :'<,'>!cowsay
endfunction

function! Cowsay() range
  :'<,'>!cowsay
endfunction

vmap ,b :call Box()<CR> 
vmap ,ub :call Unbox()<CR> 



