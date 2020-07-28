call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'unkiwii/vim-nerdtree-sync'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'puremourning/vimspector'
Plug 'leafgarland/typescript-vim'

call plug#end()

colorscheme gruvbox

syntax on

set autoindent
set autoread " automatically reload files upon change outside VIM
set backspace=indent,eol,start
set bg=dark
set cindent
set colorcolumn=100
set encoding=utf-8
set fdm=marker
set foldenable
set foldlevelstart=1
set foldmethod=syntax
set formatoptions=cqt "tcron
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:\|\ ,trail:.
set modeline
set modelines=5
"set mouse=a
set expandtab
set noswapfile
set nowrap
set nu
set numberwidth=5
set rnu
set scrolloff=8
set shiftwidth=4
set sidescroll=1
set sidescrolloff=15
set smartcase
set smartindent
set smarttab
set statusline^=%{coc#status()}
set tabstop=4
set textwidth=100
set viminfo='10,\"100,:20,%,n~/.viminfo
set wrapmargin=0

highlight Normal guibg=NONE ctermbg=NONE

au CursorHold * sil call CocActionAsync('highlight')
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
highlight CocErrorHighlight ctermfg=Red guibg=#ff0000
highlight CocHighlightText ctermbg=Blue guibg=#005599

let g:vimspector_enable_mappings='HUMAN'
let g:indentLine_char_list = ['|', '|', '|', '|']
let g:coc_global_extensions = ['coc-highlight']
" folding
nnoremap <space> za

" bufnav
nmap <A-h> :wincmd h<enter>
nmap <A-j> :wincmd j<enter>
nmap <A-k> :wincmd k<enter>
nmap <A-l> :wincmd l<enter>

" tabnav
nmap <S-H> :tabprev<enter>
nmap <S-L> :tabnext<enter>
nmap <S-T> :tabnew<enter>
nmap <S-W> :tabclose<enter>

" git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>ga :Gcommit --ammend<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>

" coc
nn <silent> K :call CocActionAsync('doHover')<CR>
nmap <silent> <leader>cm :call CocActionAsync<CR>
nmap <silent> <leader>cf <Plug>(coc-fix-current)
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cy <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>cn <Plug>(coc-diagnostic-next)
nmap <silent> <leader>cp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>co :CocCommand workspace.showOutput<CR>

" NERDTree
nmap <C-N> :NERDTreeToggle<enter>
nmap <C-T> :NERDTreeFocus<enter>
nmap <C-]> :noh<enter>

" setup environment
function! SetupEnvironment()
	let l:path = expand('%:p')
	if l:path =~ '/home/uros/workspace/ragebite'
		setlocal expandtab
		setlocal tabstop=2 shiftwidth=2
	endif
endfunction

autocmd! BufReadPost,BufNewFile * call SetupEnvironment()
