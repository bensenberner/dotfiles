set nocompatible
:set mouse=a
" Need this for airline to work
set laststatus=2
" Line numbers won't be displayed in insert without this
set number
set backspace=indent,eol,start
set rtp+=~/.vim/bundle/Vundle.vim

" Set your own leader here!
:let mapleader = ';'

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'mattn/emmet-vim'
Plugin 'SirVer/ultisnips'
Plugin 'myusuf3/numbers.vim'
Plugin 'fatih/vim-go'
" Note that YCM has a compiled component as well!
" Refer to https://github.com/Valloric/YouCompleteMe/ for details.
Plugin 'Valloric/YouCompleteMe'
Plugin 'honza/vim-snippets'
call vundle#end()

syntax on
filetype plugin indent on
" Essential remappings
" Because when do you ever type jk outside of sarcastic texts? 
:inoremap jk <ESC>
noremap <leader>y "*y
noremap <leader>yy "*Y
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

"Vim solarized
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized

" gleaned from https://statico.github.io/vim.html
:set incsearch
:set ignorecase
:set smartcase
:set hlsearch
:nmap <leader>q :nohlsearch<CR>
" more from https://github.com/NullMode/vim/blob/master/.vimrc

" buffer stuff
" :nmap <C-e> :e<CR>
:nmap <leader>l :bnext<CR>
:nmap <leader>h :bprev<CR>

" NERDtree
:nmap <leader>e :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
endif

" Tab Settings
" set the default that I prefer
:set expandtab tabstop=4 shiftwidth=4 softtabstop=4
:nmap <leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
:nmap <leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
:nmap <leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
:nmap <leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" wrap mode
:set nowrap
:nmap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>

" numbers -- note that this many slow your computer down during fast scrolling
nnoremap <F3> :NumbersToggle<CR>
let g:numbers_exclude = ['nerdtree']

" IndentLine
:let g:indentLine_char='¦'
:let g:indentLine_color_term = 239

" Syntastic
let g:syntastic_check_on_open=1
let g:synastic_enable_signs=1

" UltiSnips settings so that there's no competition with YCM
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#syntastic#enabled = 10
