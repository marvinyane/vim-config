set nocompatible
syntax enable

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', {'branch' : 'stable'}
Plug 'altercation/vim-colors-solarized'
Plug 'ludovicchabant/vim-gutentags'

" Initialize plugin system
call plug#end()

" Vim default setting
set encoding=utf-8
set nu
set listchars=tab:▸\ ,trail:▫
set list
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set ignorecase
set smartcase
set noerrorbells
set novisualbell
set backspace=indent,eol,start
set lazyredraw
set autoindent
set laststatus=2
set showmode
set showcmd
set incsearch
set hlsearch
set display=lastline
set hidden
set tags=./.tags;,.tags
set completeopt=menu,menuone

if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized

if has('mouse')
    set mouse=a
endif

" Hotkey setting
inoremap jj <ESC>
map j gj
map k gk
let mapleader=","
let g:mapleader=","
nmap <leader>w :w!<CR>
noremap <leader><space> :call StripTrailing()<CR>
noremap <leader>g :YcmCompleter GoTo<CR>

" Function
function! StripTrailing()
    let previous_search=@/
    let previous_cursor_line=line('.')
    let previous_cursor_column=col('.')
    %s/\s\+$//e
    let @/=previous_search
    call cursor(previous_cursor_line, previous_cursor_column)
endfunction

" YouCompleteMe setting
let g:ycm_semantic_triggers={'c,cpp,python,java,go,lua,javascript': ['re!\w{2}']}
let g:ycm_filetype_whitelist={'c': 1, 'cpp': 1, 'cc': 1, 'h': 1, 'go': 1, 'java': 1, 'lua': 1, 'javascript': 1}
let g:ycm_complete_in_comments=1
let g:ycm_server_log_level='info'
let g:ycm_key_invoke_completion='<c-z>'
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_min_num_identifier_candidate_chars=2
let g:ycm_confirm_extra_conf=0
let g:ycm_max_num_candidates=10

" Gutentags setting
let g:gutentags_project_root=['.svn', '.git', '.project']
let g:gutentags_ctags_tagfile='.tags'
let s:vim_tags=expand('~/.cache/tags')
let g:gutentags_cache_dir=s:vim_tags
let g:gutentags_ctags_extra_args=['--fields=+niazS', '--extra=+q', '--c++-kinds=+px', '--c-kinds=+px', '--output-format=e-ctags']

if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

let $GTAGSLABEL='native-pygments'
let $GTAGSCONF=fnamemodify(systemlist('which gtags')[0], ':p:h') . '/../share/gtags/gtags.conf'

let g:gutentags_modules=[]
if executable('ctags')
    let g:gutentags_modules+=['ctags']
endif
if executable('gtags') && executable('gtags-cscope')
    let g:gutentags_modules+=['gtags_cscope']
endif

let g:gutentags_auto_add_gtags_cscope=0
let g:gutentags_define_advanced_commands=1
