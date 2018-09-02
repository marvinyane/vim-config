set nocompatible
syntax on

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', {'branch' : 'stable'}
Plug 'altercation/vim-colors-solarized'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'
Plug 'mhinz/vim-signify'
Plug 'justinmk/vim-dirvish'
Plug 'Shougo/echodoc.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'vim-scripts/a.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Yggdroot/LeaderF'

" Initialize plugin system
call plug#end()

" Vim default settings
set encoding=utf-8
set number
set listchars=tab:▸\ ,trail:▫
set list
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set ignorecase
set noerrorbells
set novisualbell
set backspace=2
set lazyredraw
set autoindent
set smartindent
set laststatus=2
set noshowmode
set noshowcmd
set incsearch
set hlsearch
set display=lastline
set hidden
set tags=./.tags;,.tags
set completeopt=menu,menuone
set signcolumn=yes

if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized

if has('mouse')
    set mouse=a
endif

" Hotkey settings
inoremap jj <ESC>
map j gj
map k gk
noremap <C-l> <C-W>l
noremap <C-k> <C-W>k
noremap <C-j> <C-W>j
noremap <C-h> <C-W>h
noremap <silent><C-\>s :GscopeFind s <C-R><C-W><cr>
noremap <silent><C-\>g :GscopeFind g <C-R><C-W><cr>
noremap <silent><C-\>c :GscopeFind c <C-R><C-W><cr>
noremap <silent><C-\>t :GscopeFind t <C-R><C-W><cr>
noremap <silent><C-\>e :GscopeFind e <C-R><C-W><cr>
noremap <silent><C-\>f :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent><C-\>i :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <silent><C-\>d :GscopeFind d <C-R><C-W><cr>
noremap <silent><C-\>a :GscopeFind a <C-R><C-W><cr>
nnoremap <silent><C-p> :PreviewTag <C-R><C-W><CR>
nnoremap <silent><C-n> :PreviewClose<CR>

let mapleader=","
let g:mapleader=","
nmap <leader>w :w!<CR>
noremap <silent><leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
noremap <leader>h :nohls<CR>
noremap <leader>q :cw<CR>
noremap <leader>s :A<CR>
noremap <leader><space> :call StripTrailing()<CR>
noremap <leader>g :YcmCompleter GoTo<CR>
noremap <leader>f :LeaderfFile<CR>
noremap <leader>b :LeaderfBuffer<CR>
noremap <leader>t :LeaderfTag<CR>
noremap <leader>r :LeaderfMRU<CR>
noremap <leader>m :LeaderfFunction<CR>

" YouCompleteMe settings
let g:ycm_semantic_triggers={'c,cpp,python,java,go,lua,javascript': ['re!\w{2}']}
let g:ycm_filetype_whitelist={'c': 1, 'cpp': 1, 'cc': 1, 'h': 1, 'go': 1, 'java': 1, 'lua': 1, 'javascript': 1}
let g:ycm_complete_in_comments=1
let g:ycm_server_log_level='info'
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_min_num_identifier_candidate_chars=2
let g:ycm_confirm_extra_conf=0
let g:ycm_max_num_candidates=10

" Gutentags settings
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
let g:gutentags_plus_nomap=1
let g:gutentags_plus_switch=1

" Echodoc settings
let g:echodoc_enable_at_startup=1

" Dirvish settings
augroup dirvish_config
    autocmd!
    autocmd FileTYpe dirvish nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR> |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
    autocmd FileType dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish %<CR>
    autocmd FileType dirvish silent keeppatterns g@\v/\.[^\/]+/?$@d _
    autocmd FileType dirvish sort ,^.*[\/],
    autocmd FileType dirvish silent! unmap <buffer> o
    autocmd FileType dirvish nmap o i
augroup END

let g:loaded_netrwPlugin=1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" Quickfix
augroup qf_config
    autocmd!
    autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
    autocmd FileType qf nnoremap <silent><buffer> o <CR>:cclose<CR>
    autocmd FileType qf nnoremap <silent><buffer> q :cclose<CR>
augroup END

" Preview
augroup priview_config
    autocmd!
    autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<CR>
    autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<CR>
augroup END

" CppEnhancedHighlight
let g:cpp_class_scope_highlight=1
let g:cpp_member_variable_highlight=1
let g:cpp_class_decl_highlight=1
let g:cpp_no_function_highlight=0

" LeaderF
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = ['.project', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:Lf_CommandMap={'<C-J>': ['<C-N>'], '<C-K>': ['<C-P>']}

" Function
function! StripTrailing()
    let previous_search=@/
    let previous_cursor_line=line('.')
    let previous_cursor_column=col('.')
    %s/\s\+$//e
    let @/=previous_search
    call cursor(previous_cursor_line, previous_cursor_column)
endfunction
