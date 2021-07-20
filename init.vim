" {{{ Plugins
call plug#begin(stdpath('config') . '/init.nvim')

Plug 'lifepillar/vim-gruvbox8'
Plug 'glepnir/spaceline.vim'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'airblade/vim-gitgutter'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'

Plug 'kyazdani42/nvim-web-devicons'

call plug#end()
" }}}

filetype plugin on
"{{{ Autocmd
autocmd CursorHold * sil call CocActionAsync('highlight')
autocmd CursorHoldI * sil call CocActionAsync('showSignatureHelp')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
autocmd VimLeave * set guicursor=a:ver1
autocmd FileType scss setl iskeyword+=@-@
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
set backspace=indent,eol,start
set cindent
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
set updatetime=300
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
"}}}

"{{{ Theme
set background=dark
colorscheme gruvbox8_hard
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
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
vnoremap <leader>gd :diffput<CR>
nmap <silent> <leader>gp :GFiles<CR>
"}}}
"{{{ Other
nnoremap <space> za
nmap <C-]> :noh<CR>
nmap <leader>tt :TagbarToggle<CR>
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
"}}}

"{{{ Lua Scripts
lua <<EOF
require'nvim-treesitter.configs'.setup {
        highlight={
            enable=true,       -- false will disable the whole extension
        }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.objc = {
    install_info = {
        url = "~/workspace/tree-sitter-objc",
        files = {"src/parser.c"}
    }
}
EOF
"}}}
