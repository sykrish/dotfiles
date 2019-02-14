" Basic config
syntax on
" Git color setting
au BufNewFile,BufRead .gitmessage.txt setlocal colorcolumn=50
let g:solarized_termcolors=256
set nu rnu
:set colorcolumn=120

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'universal-ctags/ctags'
Plug 'tpope/vim-dispatch'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'janko-m/vim-test'
Plug 'dracula/vim'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'gregsexton/gitv'
Plug 'justinmk/vim-sneak'
Plug 'tmhedberg/matchit'
Plug 'craigemery/vim-autotag'
Plug 'int3/vim-extradite'
"Plug 'Mizuchi/vim-ranger'
Plug 'francoiscabrol/ranger.vim'

call plug#end()

set mouse=a
" Netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 0


" Quickscope colour settings
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
nnoremap <leader>h :QuickScopeToggle <CR>
nnoremap <leader>f :MixFormat <CR>
"Mapping
" Ctrlp
"map ; :Files<CR>
"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words
" Resize steps


" FZF
nmap <c-p> :cclose<CR>:FZF<CR>
"nmap <m-p> :execute ':FZF -q '.shellescape(expand('<cword>'))<CR>
nmap <c-o> :cclose<CR>:Tags<CR>
nmap <m-o> :execute ':Tags '.expand('<cword>')<CR>
nmap <c-i> :cclose<CR>:BLines<CR>
map :ls :Buffers
map :sbl :set bg=light
map :sbd :set bg=dark

autocmd VimEnter * command! -bang -nargs=* FZF
  \ call fzf#vim#files(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%:hidden', '?')
  \                         : fzf#vim#with_preview('right:50%', '?'),
  \                 <bang>0)
autocmd VimEnter * command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%:hidden', '?')
  \                         : fzf#vim#with_preview('right:50%', '?'),
  \                 <bang>0)

" Sneak (search 2 letters)
map S <Plug>Sneak_s

" tagbar
nmap <F8> :TagbarToggle<CR>

" Remap code completion to Ctrl+Space {{{2
inoremap <Nul> <C-n>

" Multicursor
if !has('gui_running')
  map <leader>a <A-n>
endif
nnoremap <leader>h :QuickScopeToggle <CR>

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Ctagsder
"nnoremap <C-I> :BLines<CR>
nnoremap <Leader-K> :Tags<CR>
nnoremap <Leader-P> :Files<CR>
" nnoremap <C-P> :execute ':FZF -q '.shellescape(expand('<cword>'))<CR>

" FZF settings
"let g:fzf --preview 'cat {}'

map :dt :diffthis
map :do :diffoff

map <leader>s :nohlsearch<CR>

map <F5> :Ranger <CR>
map <leader><F5> :e! .<CR>

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
" Test
nmap <silent> <leader>t :TestFile<CR>
let test#strategy = "dispatch"
let g:test#preserve_screen = 1

" Zoom on search results
nnoremap n nzz
nnoremap N Nzz

"Show tabs as 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

"Show tabs and trailing spaces
"set listchars=tab:^|,trail:~
set list listchars=tab:\|\ ,trail:·,extends:»,precedes:«
set list

"Strip trailing whitespace on save
autocmd BufWritePre *.ex,*.iex,*.exs,*.skim,*.ejs,*.coffee,*.php,*.rb,*.erb,*.haml,*.slim,*.sass,*.js,*.hamlc :%s/\s\+$//e

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained * set number relativenumber
  autocmd BufLeave,FocusLost   * set number norelativenumber
augroup END

" Disable backing up
"set nobackup
"set nowritebackup
set noswapfile
" Statusbar
set laststatus=2
"set statusline+=%-3.3n\                      " buffer number
"set statusline+=%*                           " switch back to normal statusline highlight
"set statusline+=%f\                          " filename
"set statusline+=%h%m%r%w                     " status flags
"set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
"set statusline+=%=                           " right align remainder
"set statusline+=0x%-8B                       " character value
"set statusline+=%-14(%l,%c%V%)               " line, character
"set statusline+=%<%P                         " file position
"set statusline+=%{StatuslineGit()}

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=1 guifg=Black ctermbg=15
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=2 guifg=Black ctermbg=7
  else
    hi statusline guibg=DarkRed ctermfg=4 guifg=Black ctermbg=7
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=15 guifg=White ctermbg=8


" default the statusline to green when entering Vim
hi statusline guibg=DarkGrey ctermfg=15 guifg=White ctermbg=8

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

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

set incsearch
set ruler
set ignorecase
set autoindent
set scrolloff=5
set backspace=2 " Backspace can delete stuff I didn't enter
set hlsearch

" ------- colours
highlight ColorColumn ctermbg=darkmagenta
highlight Function ctermfg=darkcyan
highlight Define ctermfg=blue
highlight Conditional ctermfg=yellow
highlight Operator ctermfg=Darkred
highlight Type ctermfg=lightgreen

"diff
highlight DiffAdd ctermbg=green
highlight DiffAdd ctermfg=black
highlight DiffChange ctermfg=yellow
highlight DiffChange ctermfg=black
highlight DiffDelete ctermbg=red
highlight DiffDelete ctermfg=black
highlight DiffText ctermfg=black



highlight Comment ctermfg=DarkGray
highlight Special ctermfg=Darkred
highlight NonText ctermfg=DarkRed
highlight SpecialKey ctermfg=DarkGrey

" If git diff calss vimdiff, use different colorscheme
" if &diff
"     colorscheme slate
" endif
