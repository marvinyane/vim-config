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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
" Plug 'Yggdroot/LeaderF'
Plug 'tpope/vim-commentary'
Plug 'albfan/ag.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'milkypostman/vim-togglelist'
Plug 'fatih/vim-go'

" Initialize plugin system
call plug#end()

" Vim default settings
set encoding=utf-8
set number
" set listchars=tab:▸\ ,trail:▫
" set list
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
set hlsearch
set incsearch
set display=lastline
set hidden
set tags=./.tags;,.tags
set completeopt=menu,menuone
set signcolumn=yes
set mouse=a
set foldmethod=manual

if has('gui_running')
    set background=light
else
    set background=dark
endif

" let g:solarized_termtrans=1
" let g:solarized_termcolors=256
colorscheme solarized

hi! clear SignColumn
hi! clear LineNr
hi! clear VertSplit

highlight DiffAdd    cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete cterm=bold ctermbg=none ctermfg=167
highlight DiffChange cterm=bold ctermbg=none ctermfg=227

" Hotkey
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
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let mapleader   = ","

map <leader>w :w!<CR>
noremap <silent><leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
noremap <leader>h :nohls<CR>
noremap <leader>s :A<CR>
noremap <leader><space> :call StripTrailing()<CR>
" noremap <leader>g :YcmCompleter GoTo<CR>
noremap <leader>f :CtrlPFunky<CR>
" nnoremap <Leader>u :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
noremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>a :Ag!<space>
vnoremap <leader>a y:Ag! <C-r>=fnameescape(@")<CR>
" nmap f <Plug>(easymotion-f)
" nmap F <Plug>(easymotion-F)
" nmap <leader>f <Plug>(easymotion-f)
" nmap <leader>F <Plug>(easymotion-F)
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

vnoremap <leader>r "hy:%s/<c-r>h//gc<left><left><left>

" YouCompleteMe settings
let g:ycm_use_ultisnips_completer                       = 1
let g:ycm_semantic_triggers                             = {'c,cpp,python,java,go,lua,javascript': ['re!^\s+\w{2}']}
let g:ycm_filetype_whitelist                            = {'c': 1, 'cpp': 1, 'cc': 1, 'h': 1, 'go': 1, 'java': 1, 'lua': 1, 'javascript': 1}
let g:ycm_seed_identifiers_with_syntax                  = 0
let g:ycm_key_invoke_completion                         = '<leader>c'
let g:ycm_complete_in_comments                          = 1
let g:ycm_complete_in_strings                           = 1
let g:ycm_log_level                                     = 'error'
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_min_num_identifier_candidate_chars            = 2
let g:ycm_confirm_extra_conf                            = 0
let g:ycm_max_num_candidates                            = 10
let g:ycm_show_diagnostics_ui                           = 0

" Gutentags
let g:gutentags_project_root     = ['.svn', '.git', '.project']
let g:gutentags_ctags_tagfile    = '.tags'
let s:vim_tags                   = expand('~/.cache/tags')
let g:gutentags_cache_dir        = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q', '--c++-kinds=+px', '--c-kinds=+px', '--output-format=e-ctags']

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

let g:gutentags_auto_add_gtags_cscope=1
let g:gutentags_plus_nomap=1
let g:gutentags_plus_switch=1

" Echodoc
let g:echodoc_enable_at_startup=1

" Dirvish
augroup dirvish_config
    autocmd!
    autocmd FileTYpe dirvish nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR> |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
    autocmd FileType dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish %<CR>
    autocmd FileType dirvish silent keeppatterns g@\v/\.[^\/]+/?$@d _
    autocmd FileType dirvish sort ,^.*[\/],
augroup END

let g:loaded_netrwPlugin=1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" Quickfix
augroup qf_config
    autocmd!
    autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
augroup END

" CtrlP
let g:ctrlp_extensions = ['tag']
let g:ctrlp_working_path_mode = 'ra'
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif

" CppEnhancedHighlight
let g:cpp_class_scope_highlight     = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight      = 1
let g:cpp_no_function_highlight     = 0

" Airline
let g:airline_theme                           = 'solarized'
let g:airline#extensions#tabline#enabled      = 1
let g:airline#extensions#tabline#left_sep     = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Easymotion
let g:EasyMotion_smartcase = 1

" Ale
let g:ale_linters_explicit           = 0
let g:ale_completion_delay           = 500
let g:ale_echo_delay                 = 20
let g:ale_lint_delay                 = 500
let g:ale_echo_msg_format            = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed       = 'normal'
let g:ale_lint_on_insert_leave       = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_c_gcc_options              = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options            = '-Wall -O2 -std=c++17'
let g:ale_c_cppcheck_options         = ''
let g:ale_cpp_cppcheck_options       = ''

" UltiSnippets/vim-snippets
" let g:UltiSnipsExpandTrigger       = "<leader><leader>"
let g:UltiSnipsJumpForwardTrigger  = "<c-f>"
let g:UltiSnipsJumpBackwardTrigger = "<c-b>"

" Function
function! StripTrailing()
    let previous_search=@/
    let previous_cursor_line=line('.')
    let previous_cursor_column=col('.')
    %s/\s\+$//e
    let @/=previous_search
    call cursor(previous_cursor_line, previous_cursor_column)
endfunction

