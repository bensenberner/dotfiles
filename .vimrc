"TODO: create a function that, upon pressing ctrl-g, will save your position
"in the file, reindent the file, and then reposition your cursor back where
"you left it.
" TODO: find out what this does
"let python_highlight_all=1
" TODO: find out how registers work (i.e. the " stuff)
" TODO: memorize these! https://github.com/davidhalter/jedi-vim#features

let mapleader=';'
set autochdir
set background=dark
set backspace=indent,eol,start
set directory=~/.vim/tmp
set foldlevel=99
set foldmethod=indent
set history=100
set encoding=utf-8
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set mouse=a
set nocompatible
set nowrap
set number
set relativenumber
set rtp+=~/.vim/bundle/Vundle.vim
set ruler
set showcmd
set smartcase
set complete=.,b,u,]
set wildmode=longest,list:longest

" TODO: remap navigation
"nnoremap <silent> <c-f>h :wincmd h<CR>
"nnoremap <silent> <c-f>j :wincmd j<CR>
"nnoremap <silent> <c-f>k :wincmd k<CR>
"nnoremap <silent> <c-f>l :wincmd l<CR>

nnoremap <space> za " enable folding with spacebar
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>q :nohlsearch<CR>
nnoremap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nnoremap <F3> :NumbersToggle<CR>
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprev<CR>
nnoremap j gj
nnoremap k gk
inoremap jk <ESC>
nnoremap <c-g> <esc>gg=Ggg
nnoremap n nzz
nnoremap N Nzz
" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
" Set auto textwidth
au Bufread,BufNewFile *.md set filetype=markdown textwidth=79
au Bufread,BufNewFile *.markdown set textwidth=79
au Bufread,BufNewFile *.txt Goyo
augroup autosourcing " automatically source vimrc upon any change
    autocmd!
    autocmd BufWritePost ~/.vimrc source %
augroup END

augroup JumpCursorOnEdit " Restore cursor position to where it was before
    au!
    autocmd BufReadPost *
                \ if expand("<afile>:p:h") !=? $TEMP |
                \   if line("'\"") > 1 && line("'\"") <= line("$") |
                \     let JumpCursorOnEdit_foo = line("'\"") |
                \     let b:doopenfold = 1 |
                \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
                \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
                \        let b:doopenfold = 2 |
                \     endif |
                \     exe JumpCursorOnEdit_foo |
                \   endif |
                \ endif
    " Need to postpone using "zv" until after reading the modelines.
    autocmd BufWinEnter *
                \ if exists("b:doopenfold") |
                \   exe "normal zv" |
                \   if(b:doopenfold > 1) |
                \       exe  "+".1 |
                \   endif |
                \   unlet b:doopenfold |
                \ endif
augroup END

" 256 colors
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
endif

filetype off " filetype needs to be off before Vundle
" TODO: pick out which snippet is best
"Plugin 'KeyboardFire/vim-minisnip'
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
"TODO: figure out why this tabs you all the way to the bottom when you exit vim
"Plugin 'davidhalter/jedi-vim'
call vundle#begin()
Plugin 'bling/vim-airline'
Plugin 'dNitro/vim-pug-complete'
Plugin 'digitaltoad/vim-pug'
Plugin 'dracula/vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'ervandew/supertab'
Plugin 'gmarik/Vundle.vim'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'google/vim-maktaba'
Plugin 'junegunn/goyo.vim'
"Plugin 'junegunn/limelight.vim'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
call vundle#end()
call glaive#Install()

syntax on
filetype plugin indent on
set autoindent
colorscheme dracula

" Plugin Settings
:nmap <leader>e :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" Enable UTF-8 to properly display directory arrows. Otherwise, uncomment this.
"let g:NERDTreeDirArrows=0
" A function that automatically closes NERDTree if it is the last buffer open
function! NERDTreeQuit()
    redir => buffersoutput
    silent buffers
    redir END
    let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
    let windowfound = 0
    for bline in split(buffersoutput, "\n")
        let m = matchlist(bline, pattern)
        if (len(m) > 0)
            if (m[2] =~ '..a..')
                let windowfound = 1
            endif
        endif
    endfor

    if (!windowfound)
        quitall
    endif
endfunction
autocmd WinEnter * call NERDTreeQuit()

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" Tab Settings
:set expandtab tabstop=4 shiftwidth=4 softtabstop=4
:nmap <leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
:nmap <leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
:nmap <leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
:nmap <leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
au FileType ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
au FileType eruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
au FileType html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
au FileType javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
au Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
" au Filetype text setlocal spell spelllang=en_us " I guess this is useful?

let g:numbers_exclude = ['nerdtree']
let g:ycm_python_binary_path = '/usr/local/bin/python3.6'
"
" UltiSnips settings so that there's no competition with YCM
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"
" airline
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#syntastic#enabled = 10
