"""""""""""""""""""""""""""""""""""""""
""""""""""" Editor looks """"""""""""""
"""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
colorscheme dante
syntax on
set nu rnu
set ruler
set hlsearch
set colorcolumn=80
highlight ColorColumn ctermbg=235

"""""""""""""""""""""""""""""""""""""""
""""""" KeyBindings / mapping """""""""
"""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
" Use the space-bar as the leader rather than the backslash.
let mapleader = ' '
map :dt :diffthis
map :do :diffoff
map <leader>s :nohlsearch<CR>
map <F5> :Ranger <CR>
map <leader><F5> :e! .<CR>
map <leader>n :NERDTreeToggle<CR>
"
" Sneak (search 2 letters)
map S <Plug>Sneak_s
nnoremap <leader>h :QuickScopeToggle <CR>
"
" tagbar
nmap <F8> :TagbarToggle<CR>
"
" Remap code completion to Ctrl+Space {{{2
inoremap <Nul> <C-n>
"
" Buffers
nmap <leader><Tab> :Buffers<CR>
nmap <silent> <leader>ls :Buffers<CR>
map :ls :Buffers
nmap <leader><Tab> :Buffers<CR>
"
" Navigate through buffers.
nnoremap <leader>h :bprev<CR>
nnoremap Z :bprev<CR>
nnoremap <leader>l :bnext<CR>
nnoremap X :bnext<CR>
"
" Interact with buffers.
nnoremap <Leader>w :bwipe<CR>
"
" Move to the previous buffer
nmap <leader>lh :bprevious<CR>
"
" Silver searcher
map <c-a> :Ag! 
" map :sbl :set bg=light
" map :sbd :set bg=dark
"
" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"
" Ctagsder
"nnoremap <C-I> :BLines<CR>
nnoremap <Leader-K> :Tags<CR>
nnoremap <Leader-P> :Files<CR>
" nnoremap <C-P> :execute ':FZF -q '.shellescape(expand('<cword>'))<CR>
nnoremap <leader>h :QuickScopeToggle <CR>
nnoremap <leader>m :MixFormat <CR>
nnoremap <leader>se :set syntax=elixir <CR>
"
" Indent more than once on visual blocks.
vnoremap < <gv
vnoremap > >gv
"
" Elixir Configs
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>f :MixFormat<CR>
" Test settings
let test#strategy = "dispatch"
let g:test#preserve_screen = 1

" Zoom on search results
nnoremap n nzz
nnoremap N Nzz

"""""""""""""""""""""""""""""""""""""""
""""""""""""" Settings """"""""""""""""
"""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
"
" Undo settings
set undofile
set undodir=~/.vim/undo,/tmp
set undolevels=1024
set undoreload=1024
"
" Better command-line completion
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc,*.tmp
"
" Show partial commands in the last line of the screen
set showcmd
"
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set incsearch
set autoindent
set scrolloff=5
set backspace=2 " Backspace can delete stuff I didn't enter
set ignorecase
" Disable backing up
"set nobackup
"set nowritebackup
set noswapfile
"
"Show tabs as 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" :set fillchars+=vert:\|
hi vertsplit ctermfg=235 ctermbg=235
"
" Allow for switching a buffer without saving it. TODO is still comment
" relevant? 
" set hidden
"
" Git color setting
au BufNewFile,BufRead .gitmessage.txt setlocal colorcolumn=50

"""""""""""""""""""""""""""""""""""""""
""""""""""""" Plugins """""""""""""""""
"""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'Lokaltog/vim-monotone'
Plug 'NLKNguyen/papercolor-theme'
Plug 'Yggdroot/indentLine'
Plug 'altercation/vim-colors-solarized'
Plug 'andreasvc/vim-256noir'
Plug 'ap/vim-buftabline'
Plug 'ayu-theme/ayu-vim'
Plug 'bilalq/lite-dfm'
Plug 'camgunz/amber'
Plug 'cseelus/vim-colors-lucid'
Plug 'danilo-augusto/vim-afterglow'
Plug 'dracula/vim'
Plug 'elixir-editors/vim-elixir'
Plug 'elzr/vim-json'
Plug 'francoiscabrol/ranger.vim'
Plug 'gregsexton/gitv'
Plug 'int3/vim-extradite'
Plug 'janko-m/vim-test'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'leafgarland/typescript-vim'
Plug 'lifepillar/vim-wwdc17-theme'
Plug 'mhinz/vim-mix-format'
Plug 'mr-ubik/vim-hackerman-syntax'
Plug 'mxw/vim-jsx'
Plug 'owozsh/amora'
Plug 'pangloss/vim-javascript'
Plug 'rakr/vim-one'
Plug 'rakr/vim-two-firewatch'
Plug 'scrooloose/nerdtree'
Plug 'sickill/vim-monokai'
Plug 'terryma/vim-multiple-cursors'
Plug 'tmhedberg/matchit'
Plug 'tomasr/molokai'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'universal-ctags/ctags'
Plug 'whatyouhide/vim-gotham'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
call plug#end()

"""""""""""""""""""""""""""""""""""""""
""""""""" Plugins Configs """""""""""""
"""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
"
" Quickscope colour settings
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
"
" FZF
nmap <c-p> :cclose<CR>:FZF<CR>
"nmap <m-p> :execute ':FZF -q '.shellescape(expand('<cword>'))<CR>
"nmap <c-o> :cclose<CR>:Tags<CR>
"nmap <m-o> :execute ':Tags '.expand('<cword>')<CR>
nmap <c-i> :cclose<CR>:BLines<CR>

autocmd VimEnter * command! -bang -nargs=* FZF
  \ call fzf#vim#files(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:~90%:hidden', '?')
  \                         : fzf#vim#with_preview('right:50%', '?'),
  \                 <bang>0)
autocmd VimEnter * command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:90%:hidden', '?')
  \                         : fzf#vim#with_preview('right:50%', '?'),
  \                 <bang>0)




" let g:indentLine_enabled = 1
" let g:indentLine_setConceal = 1

" set mouse=a
" Netrw settings
" let g:netrw_banner = 0
" let g:netrw_liststyle = 0

" Multicursor
if !has('gui_running')
  map <leader>a <A-n>
endif

" FZF settings
"let g:fzf --preview 'cat {}'


" Tagbar settings
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'f:functions',
        \ 'functions:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records',
        \ 't:tests'
    \ ]
\ }

"Show tabs and trailing spaces
"set listchars=tab:^|,trail:~
" set list listchars=tab:\|\ ,trail:·,extends:»,precedes:«
" set list listchars=trail:·,extends:»,precedes:«
" set lcs=tab:._,eol:$
" set list

"Strip trailing whitespace on save
autocmd BufWritePre *.ex,*.iex,*.exs,*.skim,*.ejs,*.coffee,*.php,*.rb,*.erb,*.haml,*.slim,*.sass,*.js,*.hamlc :%s/\s\+$//e

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained * set number relativenumber
  autocmd BufLeave,FocusLost   * set number norelativenumber
augroup END

"""""""""""""""""""""""""""""""""""""""
"""""""""""""" Statusbar """"""""""""""
"""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
set laststatus=2
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=1 guifg=Black ctermbg=15
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=2 guifg=Black ctermbg=7
  else
    hi statusline guibg=DarkRed ctermfg=black guifg=Black ctermbg=7
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=black guifg=black ctermbg=darkred

" default the statusline to white when entering Vim
"hi statusline guibg=DarkGrey ctermfg=black guifg=White ctermbg=white
hi statusline guibg=DarkGrey ctermfg=green guifg=White ctermbg=234
hi statuslineNC guibg=DarkGrey ctermfg=darkred guifg=White ctermbg=black

" Formats the statusline
set statusline+=\ [%n]\ -                      " Buffer number
set statusline+=\ %f                           " file name
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag

set statusline+=\ %=                        " align left
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor

"""""""""""""""""""""""""""""""""""""""
"""""""""""""" Syntax """""""""""""""""
"""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
highlight ColorColumn ctermbg=240
highlight Function ctermfg=red 
highlight Define ctermfg=Darkred
highlight Conditional ctermfg=yellow
highlight Operator ctermfg=lightgreen
highlight Type ctermfg=lightblue
"
"diff syntax
highlight DiffAdd ctermbg=green
highlight DiffAdd ctermfg=black
highlight DiffChange ctermfg=yellow
highlight DiffChange ctermfg=black
highlight DiffDelete ctermbg=red
highlight DiffDelete ctermfg=black
highlight DiffText ctermfg=black
"
" Other syntax
highlight Search ctermfg=black ctermbg=yellow
highlight Normal ctermfg=white
highlight Comment ctermfg=Gray
highlight Special ctermfg=Darkred
highlight NonText ctermfg=DarkRed
highlight SpecialKey ctermfg=DarkGrey
highlight LineNr ctermfg=darkGrey
highlight CursorLineNr ctermfg=darkred
"
" Buffer syntax
highlight BufTabLineFill ctermfg=DarkRed
highlight BufTabLineCurrent ctermfg=yellow
highlight BufTabLineHidden ctermfg=DarkGrey
highlight BufTabLineActive ctermfg=yellow
"
" Add syntax for following files
augroup twig_ft
  au!
  autocmd BufEnter,BufRead qf   set syntax=elixir
  autocmd BufNewFile,BufRead *.ts   set syntax=typescript
  autocmd BufNewFile,BufRead *.input   set syntax=elixir
  autocmd BufNewFile,BufRead *.output   set syntax=elixir
  autocmd BufNewFile,BufRead *.artifact   set syntax=json
augroup END

