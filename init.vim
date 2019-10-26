let g:python3_host_prog = '/usr/bin/python3'

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes
"
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'
" Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer --rust-completer'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'cstrahan/vim-capnp'
Plug 'chriskempson/base16-vim'

" RLS related, see: https://github.com/autozimu/LanguageClient-neovim
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" (Optional) Multi-entry selection UI.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Allows drawing ascii art images in vim:
Plug 'vim-scripts/DrawIt'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()


" ctrlp: Ignore rust's target directories
let g:ctrlp_custom_ignore = 'target\|git'

" Makes the colors reasonable when using nvim's colorschemes.
set termguicolors

" For vim airline theme
" let g:airline_theme='one'
" colorscheme one
" set background=dark

" colorscheme base16-default-dark
" colorscheme base16-irblack

colorscheme base16-monokai
syntax on

" ------- Leader keys {{{
" Set leader key for global scripts:
let mapleader = "-"
" set local leader key for specific file type scripts:
" Note: It is set to \, the other \ is for escaping.
let maplocalleader = "\\"
" }}}

"
" -------- YouCompleteMe configuration{{{
" Rust source code path:
" let g:ycm_rust_src_path = $RUST_SOURCE_CODE_PATH
" let g:ycm_filetype_blacklist = {'tex': 1, 'markdown': 1, 'fasm': 1, 'asm': 1}
" nnoremap <leader>gt :YcmCompleter GoTo<cr>
" }}}
"

" -------- deoplete configuration {{{
let g:deoplete#enable_at_startup = 1
" Disable opening preview buffer for every autocompletion
" See: https://github.com/zchee/deoplete-clang/issues/55
set completeopt -=preview
" }}}

"
" -------- vim_markdown {{{
" Markdown folding seem to make vim_markdown very slow.
" Disable it:
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=1
" }}}


" -------- Syntastic configuration {{{
let g:syntastic_javascript_checkers = ['eslint']
" See http://stackoverflow.com/questions/7233005/how-to-configure-syntastic-with-jshint
" Make syntastic python linter understand python3:
let g:syntastic_python_python_exec = '/usr/bin/python3'

let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['rust'] }

" Rust syntastic fix from 
" https://github.com/rust-lang/rust.vim/issues/130 :

" let g:syntastic_rust_rustc_exe = 'cargo check --tests'
" let g:syntastic_rust_rustc_fname = ''
" let g:syntastic_rust_rustc_args = '--'
" let g:syntastic_rust_checkers = ['rustc']

" let g:syntastic_debug = 1
" let g:syntastic_debug_file = "~/syntastic.log" 
" }}}
"
" ----------- remmapping the jk to be <ESC>  {{{
" Map jk in insert mode to <Esc> -- go back to normal mode.
inoremap jk <Esc>
" }}}
"

" ---------- cwindow options {{{
"  Mapping for :cnext and :cprevious.
"  These are used to traverse the cwindow results 
"  (For example: results from the grep command, or from make command)
nnoremap <leader>cn :cnext<cr>
nnoremap <leader>cp :cprevious<cr>
"  }}}


" ---------------- Vimscript file settings  {{{
" open a split window to edit the vimrc file:
nnoremap <leader>ev :split $MYVIMRC<cr>
" source the vimrc file. (Run it):
nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}


" Expand tab into spaces:
set expandtab

" -------- Search options {{{
"  highlight search:
"  No highlighting for every search:
"
set hlsearch
"
" Enable incremental search: (Incrementally show results for searches).
"
set incsearch
"
" Disable temporarily the highligh search option.
" Note that it will be back after the next search. (If hlsearch is enabled)
nnoremap <leader>vf :nohlsearch<cr>
"  }}}

" ----------- Buffers {{{
" Make sure vim doesn't ask me to save before swapping between buffers:
set hidden
" }}}
"

" Rust format on save:
let g:rustfmt_autosave = 1

" -------- RLS configuration {{{
" See https://github.com/autozimu/LanguageClient-neovim
"
" \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ }

" Don't show inline errors. See:
" https://github.com/autozimu/LanguageClient-neovim/issues/719
let g:LanguageClient_useVirtualText=0

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>c :call LanguageClient#textDocument_codeAction()<CR>
nnoremap <silent> <leader>e :call LanguageClient#explainErrorAtPoint()<CR>
" }}}
