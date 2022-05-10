" {{{ Plugins
call plug#begin(stdpath('config') . '/init.nvim')

Plug 'lifepillar/vim-gruvbox8'
Plug 'joshdick/onedark.vim'
Plug 'glepnir/spaceline.vim'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'andweeb/presence.nvim'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'airblade/vim-gitgutter'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'puremourning/vimspector'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'github/copilot.vim'
" Plug 'leafgarland/typescript-vim'
" Plug 'HerringtonDarkholme/yats.vim'
Plug 'thosakwe/vim-flutter'
Plug 'jparise/vim-graphql'
Plug 'dense-analysis/ale'
" Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()
" }}}

filetype plugin on
"{{{ Autocmd
autocmd CursorHold * sil call CocActionAsync('highlight')
autocmd CursorHoldI * sil call CocActionAsync('showSignatureHelp')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
autocmd VimLeave * set guicursor=a:ver1
"autocmd FileType scss setl iskeyword+=@-@
"}}}

"{{{Environment
function! SetupEnvironment()
	let l:path = expand('%:p')
	if l:path =~ '/Users/uros/workspace/ragebite'
        " TODO change coc-settings.json
	endif
endfunction
"}}}

"{{{ NVim
syntax on
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set cindent
set clipboard+=unnamedplus
set cmdheight=2
set colorcolumn=110
set cursorline
set diffopt+=vertical
set encoding=utf-8
set expandtab
set fdm=marker
set foldenable
set formatoptions=cqt
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:\|\ ,trail:·
set modeline
set modelines=5
set mouse=a
set noswapfile
set nowrap
set nu
set numberwidth=5
set re=0
set rnu
set scrolloff=8
set shiftwidth=4
set sidescroll=1
set sidescrolloff=15
set signcolumn=yes
set smartcase
set smartindent
set smarttab
set tabstop=4
set termguicolors
set textwidth=110
set updatetime=200
set viminfo='10,\"100,:20,%,n~/.nviminfo
"}}}

"{{{ Highlighting
highlight NonText ctermbg=red ctermfg=white
highlight SpecialKey ctermbg=red ctermfg=white
highlight CocErrorHighlight ctermfg=Red guibg=#ff0000
highlight CocHighlightText ctermbg=Blue guibg=#005599
"}}}

"{{{ Plugin Configuration
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_preview_window='right:60%'
let g:indentLine_char_list=['|', '|', '|', '|']
let g:gruvbox_filetype_hi_groups=1
let g:gruvbox_plugin_hi_groups=1
let g:spaceline_colorscheme='one'
"let g:python_host_prog='/usr/bin/python2'
"let g:python3_host_prog='/usr/local/bin/python3'
let g:spaceline_seperate_style='arrow'
let g:spaceline_diff_tool='git-gutter'
let g:tcomment_opleader1='yc'
let g:vimspector_enable_mappings = 'HUMAN'
let g:typescript_compiler_binary='tsc'
let g:indentLine_setConceal = 0
let g:ale_fixers = {
            \ 'typescript': ['eslint'],
            \ 'javascript': ['eslint']
\ }
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

" General options
let g:presence_auto_update         = 1
let g:presence_neovim_image_text   = "The One True Text Editor"
let g:presence_main_image          = "neovim"
let g:presence_client_id           = "793271441293967371"
let g:presence_debounce_timeout    = 10
let g:presence_log_level           = "error"
let g:presence_enable_line_number  = 0
let g:presence_blacklist           = []
let g:presence_buttons             = 1
let g:presence_file_assets         = {}

" Rich Presence text options
let g:presence_editing_text        = "Editing %s"
let g:presence_file_explorer_text  = "Browsing %s"
let g:presence_git_commit_text     = "Committing changes"
let g:presence_plugin_manager_text = "Managing plugins"
let g:presence_reading_text        = "Reading %s"
let g:presence_workspace_text      = "Working on %s"
let g:presence_line_number_text    = "Line %s out of %s"


" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1
"}}}

"{{{ Theme
set background=dark
colorscheme onedark
"}}}

"{{{ Functions
function! s:my_fzf_handler(lines) abort
    if empty(a:lines)
        return
    endif
    let cmd=get({ 'ctrl-t': 'tabedit',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit' }, remove(a:lines, 0), 'e')
    for item in a:lines
        execute cmd escape(item, ' %#\')
    endfor
endfunction
"}}}

"{{{ Bindings
"{{{ Buffers
nmap <C-H> :bp<CR>
nmap <C-L> :bn<CR>
nmap <C-K> :bd<CR>
nnoremap <C-c> :bd<CR>
nnoremap <leader>cc :call CurtineIncSw()<CR>
"}}}
"{{{ Completion
inoremap <silent><expr> <C-Space> coc#refresh()
nnoremap <silent> I :call CocActionAsync('doHover')<CR>
nmap <silent> <leader>cf <Plug>(coc-fix-current)
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cy <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>co :CocCommand workspace.showOutput<CR>
"}}}
"{{{ Formatting
nmap <silent> <leader>rf :RustFmt<CR>
nmap <silent> <leader>pf <Plug>(Prettier)
nmap <silent> <leader>pp <Plug>(PrettierPartial)
"}}}
"{{{ FZF
nmap <silent> <leader>fb :Buffers<CR>
nmap <silent> <leader>fg :Rg<CR>
nmap <silent> <leader>fl :BLines<CR>
nmap <silent> <leader>fc :BCommits<CR>
nnoremap <silent> <C-P> :call fzf#run({
    \ 'source': 'git ls-files',
    \ 'options': '--expect=ctrl-t,ctrl-x,ctrl-v',
    \ 'window': {'width': 0.9, 'height': 0.6},
    \ 'sink*':  function('<sid>my_fzf_handler')})<CR>

nnoremap <silent> <C-T> :call fzf#run({
    \ 'options': '--expect=ctrl-t,ctrl-x,ctrl-v',
    \ 'window': {'width': 0.9, 'height': 0.6},
    \ 'sink*':  function('<sid>my_fzf_handler')})<CR>
"}}}
"{{{ Git
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit -v<CR>
nnoremap <leader>ga :Git commit --amend<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gu :Git push<CR>
nnoremap <leader>gb :Git blame<CR>
vnoremap <leader>gd :diffput<CR>
nmap <silent> <leader>gp :GFiles<CR>
"}}}
"{{{ Other
nnoremap <space> za
nmap <C-]> :noh<CR>
nmap <leader>tt :TagbarToggle<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-z> :NERDTree<CR>
nnoremap <C-x> :NERDTreeToggle<CR>
"}}}
"{{{ Tabs
nmap <S-T> :tabnew<CR>
nmap <S-H> :tabprev<CR>
nmap <S-L> :tabnext<CR>
nmap <S-D> :tabclose<CR>
"}}}
"{{{ Windows
nmap <A-h> :wincmd h<CR>
nmap ˙ :wincmd h<CR>

nmap <A-j> :wincmd j<CR>
nmap ∆ :wincmd j<CR>

nmap <A-k> :wincmd k<CR>
nmap ˚ :wincmd k<CR>

nmap <A-l> :wincmd l<CR>
nmap ¬ :wincmd l<CR>
"}}}
"{{{ Rust
nmap <leader>rcr :Cargo run<CR>
nmap <leader>rct :Cargo test<CR>
nmap <leader>rcb :Cargo build<CR>
"}}}
"}}}

"{{{ Lua Scripts
lua <<EOF
require'nvim-treesitter.configs'.setup {
        highlight={
            enable=true,       -- false will disable the whole extension
        }
}

EOF
"}}}
