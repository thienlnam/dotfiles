" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'ludovicchabant/vim-gutentags'

Plug 'jelera/vim-javascript-syntax'

Plug 'vim-syntastic/syntastic'

Plug 'modess/vim-phpcolors'

Plug 'StanAngeloff/php.vim'

Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }

Plug 'pangloss/vim-javascript'

Plug 'NLKNguyen/papercolor-theme'

Plug 'NLKNguyen/c-syntax.vim'

Plug 'prabirshrestha/async.vim'

Plug 'prabirshrestha/vim-lsp'

Plug 'ajh17/vimcompletesme'

" Install fuzzy finder for vim and cli
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'vim-vdebug/vdebug', {'tag': 'v1.5.2'}

" Initialize plugin system
call plug#end()

" auto command to remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" split to the bottom on horizontal splits, to the right on vertical split
set splitbelow
set splitright

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:javascript_plugin_jsdoc = 1
let g:loaded_syntastic_java_javac_checker = 1 " disable javac checker

set t_Co=256
set background=light
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
colorscheme PaperColor

" Gutentag settings
set statusline+=%{gutentags#statusline()}
" When to regenerate tags
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_add_default_project_roots = 0
let g:gutentags_define_advanced_commands = 1
" define various roots for 'projects' to break up tag file sizes
let g:gutentags_project_root = ['package.json', '.git', 'Web-Expensify/site', 'Web-Expensify/lib']

" execute pathogen#infect()
" let g:CommandTWildIgnore=&wildignore . ",**/node_modules/*"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set hidden " allow unsaved background buffers and remember marks/undo for them
set history=10000 " remember more commands and search history
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase " make searches case-sensitive only if they contain upper-case characters
set cursorline " highlight current line
set cmdheight=1
set switchbuf=useopen
set numberwidth=4
set showtabline=2
set winwidth=79
set spell spelllang=en_us

" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=5
" Store temporary files in a central spot
" set backup
" set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set noswapfile
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd

" Enable highlighting for syntax
syntax on

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" allow easier edits to crontab on macos
autocmd FileType crontab setlocal bkc=yes

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list,full

" make tab completion for files/buffers act like bash
set wildmenu
set smartindent
set tabstop=4
set number
let mapleader=","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  "autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
":set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
"set statusline=%<%f\                     " Filename
"set statusline+=%w%h%m%r                 " Options
" set statusline+=%{fugitive#statusline()} " Git Hotness
"set statusline+=\ [%{&ff}/%Y]            " Filetype
"set statusline+=\ [%{getcwd()}]          " Current dir
"set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap GT gT

" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

nnoremap Y y$
nnoremap j gj
nnoremap k gk

" Prevent entering ex mode
:nnoremap Q <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" solarized options
"let g:solarized_termcolors = 256
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "normal"
"set background=light
"colorscheme solarized

set timeoutlen=400
" nmap <leader>m :CommandT <cr>

" Copy current buffer content and return to position
nmap <leader>c mxgg"*yG'x

" Delete current buffer
nmap <leader>d :bd<cr>

" Open file on github in current line and on current hash
" Note: this depends on the git url alias
nmap <leader>g :!echo `git url`/blob/`git rev-parse --short HEAD`/%\#L<C-R>=line('.')<CR> \| xargs open<CR><CR>

nmap <leader>dd :bd<cr>:vs<cr><right><down>
map <leader>e :edit %%
map <leader>v :view %%
nmap <leader>' :s/"/'/g<cr><cr>
nnoremap <leader><leader> <c-^>
nnoremap <leader>s q/kA

nnoremap H ^

" Git diff current file
nmap <F1> :!git diff -- %<cr>

" Toggle line numbers
nnoremap <F2> :set nonumber!<CR>

" Search for git conflict markers
nnoremap <f3> /\v[=\<\>]{4,}<cr>

" Fix whitespcae
nmap <F4> :FixWhitespace<cr>

" Toggle set paste
nmap <F6> :set paste!<cr>:set paste?<cr>

" select inner word and go back to normal mode
nnoremap <space> viw

vnoremap < <gv
vnoremap > >gv

command! WQ wq
command! Wq wq
command! W w
command! Q q
command! Qa qa
command! Formatjson %!python -m json.tool
nnoremap vv :e ~/.vimrc<cr>

augroup js_syntax " {
    autocmd!
    autocmd Syntax js setlocal foldmethod=syntax
    autocmd Syntax js normal zR
augroup END " }


" ctags path
" set tags=./tags
set tags=./tags,tags;$HOME

" Auto reload vimrc on save
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

set cc=0
set undofile                " Save undo's after file closes
set undodir=~/.vim/undo

" Load extra configs
let s:extrarc = expand($HOME . '/.extra-vimrc')
if filereadable(s:extrarc)
    exec ':so ' . s:extrarc
endif

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424

augroup whitespace " {
    autocmd!
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    " the above flashes annoyingly while typing, be calmer in insert mode
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
augroup END

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space.
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

augroup git " {
    autocmd!
    autocmd BufNewFile,BufRead *.git/{,modules/**/}{COMMIT_EDIT,MERGE_}MSG set ft=gitcommit
augroup END

nnoremap dlt dt>X

iab lje Log::alert( json_encode() );<esc>F(a

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vdebug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vdebug_options = {}
let g:vdebug_options["path_maps"] = {
\    "/vagrant/Server-Scraper" : $HOME."/Expensidev/Server-Scraper",
\    "/vagrant/Web-Expensify" : $HOME."/Expensidev/Web-Expensify",
\    "/vagrant/config/www/switch/_beforeSwitch.php" : $HOME."/Expensidev/Web-Expensify/_before.php",
\    "/vagrant/config/www/switch/_afterSwitch.php" : $HOME."/Expensidev/Web-Expensify/_after.php"
\}
let g:vdebug_options['timeout'] = 60
let g:vdebug_options['break_on_open'] = 0

" from https://vim.fandom.com/wiki/Pretty-formatting_XML
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

let g:vdebug_options = {}
let g:vdebug_options["path_maps"] = {
\    "/vagrant/Server-Scraper" : $HOME."/Expensidev/Server-Scraper",
\    "/vagrant/Web-Expensify" : $HOME."/Expensidev/Web-Expensify",
\    "/vagrant/config/www/switch/_beforeSwitch.php" : $HOME."/Expensidev/Web-Expensify/_before.php",
\    "/vagrant/config/www/switch/_afterSwitch.php" : $HOME."/Expensidev/Web-Expensify/_after.php"
\}
let g:vdebug_options['timeout'] = 60
let g:vdebug_options['break_on_open'] = 0
