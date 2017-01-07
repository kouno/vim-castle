"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundles
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

scriptencoding utf-8

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if filereadable($HOME . "/.vimrc.bundles")
  source ~/.vimrc.bundles
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2  " Always display the status line
set nobackup
set nocp          " Use Vim settings, rather then Vi settings
set noswapfile
set nowritebackup
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set nohidden      " delete buffer instead of keeping it open
set backspace=2   " make backspace work like most other apps

" Search by increment (/)
set incsearch
set hlsearch
set ignorecase    " searches are case insensitive...
set smartcase     " ... unless they contain at least one capital letter

" Tabs (key) management
set tabstop=2
set shiftwidth=2
set expandtab

" Add numbers to line
set number
set numberwidth=5

" Font
set guifont:Inconsolata-dz-Powerline:14

" Set a column guideline
set colorcolumn=120
set textwidth=120

" Fold Configuration
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Tab completion options
set wildmode=longest,list,full
set wildmenu
set complete=.,w,t

" Set mac clipboard
set clipboard=unnamed

" Send more characters for redraws
set ttyfast

" Enable mouse use in all modes
set mouse=a

" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
if !has('nvim')
  set ttymouse=xterm2
endif

" buffers
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

" Remap map leader to space
let mapleader=' '

" Trailing space removal
autocmd FileType c,cpp,java,php,ruby,go autocmd BufWritePre <buffer> :%s/\s\+$//e

" Tabulation (feature) mapping
map <c-l> :tabn<CR>
map <c-h> :tabp<CR>

" Map Y to copy the rest of the line
nnoremap Y y$

" Remove highlighting
nnoremap <CR> :noh<CR><CR>

" Search multiple tags
nnoremap \] :ts <c-r><c-w><CR>

" Copy to system clipboard
nnoremap <leader>y "+y

" Copy the whole file to system clipboard
nnoremap <leader>a :%y+<CR>

" Save by pressing " s"
nnoremap <leader>s :w<CR>

" Quit by pressing " q<CR>"
nnoremap <leader>q :q

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Resize window (alt key character)
"map <silent> <a-h> <c-w><
"map <silent> <a-j> <c-w>-
"map <silent> <a-k> <c-w>+
"map <silent> <a-l> <c-w>>

map <silent> ˙ <C-w><
map <silent> ∆ <C-W>-
map <silent> ˚ <C-W>+
map <silent> ¬ <C-w>>

" Use open new files faster with " e<stuff>"
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Open tag in a new tab window.
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Reload Ctags using F12
map <F11> :!ripper-tags -R --exclude=@./.ctagsignore . 2> /dev/null && echo 'Ripper-tags reloaded'<CR>
map <F12> :!ctags -R --exclude=@./.ctagsignore . 2> /dev/null && echo 'Ctags reloaded'<CR>

augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Improve syntax highlighting
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile *.hbs set filetype=html
au BufNewFile,BufRead *.prawn set filetype=ruby
au BufRead,BufNewFile *.md set filetype=markdown

" color scheme of the moment:
syntax on

if &diff
  " vimdiff uses ugly 256 colors.
  " I change the scheme because my eyes are suffering
  set t_Co=256
  set background=dark
  colorscheme vividchalk
elseif isdirectory($SSHHOME)
  " In case we use sshrc, source out theme file
  source $SSHHOME/.sshrc.d/Tomorrow-Night-Eighties.vim
else
  colorscheme Tomorrow-Night-Eighties
endif

highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=black
highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black
highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black

highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Default spacing configuration
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype coffee setlocal ts=2 sts=2 sw=2

" nvim
if has('nvim')
  if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
      autocmd!
      au InsertEnter * set timeoutlen=0
      au InsertLeave * set timeoutlen=1000
    augroup END
  endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if filereadable($HOME . "/.vimrc.options")
  source ~/.vimrc.options
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Environment personalisation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
