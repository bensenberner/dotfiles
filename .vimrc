let mapleader=';'
set nocompatible
set mouse=a
set laststatus=2
set number
set backspace=indent,eol,start
set rtp+=~/.vim/bundle/Vundle.vim
set history=50
set incsearch
set ignorecase
set smartcase
set hlsearch




inoremap jk <ESC>
inoremap <c-d> <ESC>0d$i
inoremap wq <ESC>:wq<CR>
noremap <leader>y "*y
noremap <leader>yy "*Y
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>
inoremap <c-g> <esc>gg=Ggg
" For when you come up with a great keymapping in the heat of coding
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
:nmap <leader>q :nohlsearch<CR>



call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-rails'
Plugin 'mattn/emmet-vim'
Plugin 'SirVer/ultisnips'
Plugin 'myusuf3/numbers.vim'
" Note that YCM has a compiled component as well!
" Refer to https://github.com/Valloric/YouCompleteMe/ for details.
Plugin 'Valloric/YouCompleteMe'
Plugin 'honza/vim-snippets'
call vundle#end()

syntax on
filetype plugin indent on
" Colorscheme
set background=dark
colorscheme vimbrant 
highlight ColorColumn ctermbg=7
" Different scheme for different time
if (strftime("%H") >= "21" || strftime("%H") <= "06")
    colorscheme flux 
endif

" buffer stuff
" :nmap <C-e> :e<CR>
:nmap <leader>l :bnext<CR>
:nmap <leader>h :bprev<CR>

" NERDtree
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

" 256 colors
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
endif

" Tab Settings
:set expandtab tabstop=4 shiftwidth=4 softtabstop=4
:nmap <leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
:nmap <leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
:nmap <leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
:nmap <leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
au FileType ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" wrap mode
:set nowrap
:nmap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>

" numbers -- note that this many slow your computer down during fast scrolling
nnoremap <F3> :NumbersToggle<CR>
let g:numbers_exclude = ['nerdtree']

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"let g:syntastic_error_symbol = "✗"
"let g:syntastic_warning_symbol = "⚠"
let g:syntastic_always_population_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0
let g:syntastic_c_auto_refresh_includes=1

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

"YCM
"let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
"let g:ycm_key_invoke_completion = '<C-Space>'
