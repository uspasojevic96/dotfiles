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

call plug#end()

colorscheme gruvbox

syntax on

set autoindent
set autoread " automatically reload files upon change outside VIM
set backspace=indent,eol,start
set cindent
set colorcolumn=110
"set cursorline
set encoding=utf-8
set fdm=marker
set foldenable
set formatoptions=cqt "tcron
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:\|\ ,trail:.
set modeline
set modelines=5
set mouse=a
set noexpandtab
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
set tabstop=4
"set termguicolors
set textwidth=70
set viminfo='10,\"100,:20,%,n~/.viminfo
set wrapmargin=0

let g:indentLine_char_list = ['|', '|', '|', '|']
let g:coc_global_extensions = [
	\ 'coc-tsserver'
	\ ]

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

" setup environment
function! SetupEnvironment()
	let l:path = expand('%:p')
	
	if l:path =~ '/home/uros/workspace/ragebite'
		setlocal expandtab
		setlocal tabstop=2 shiftwidth=2
	endif
endfunction

autocmd! BufReadPost,BufNewFile * call SetupEnvironment()
