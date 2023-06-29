language en_US
set scrolloff=16
set number
set relativenumber
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent

set guifont=DroidSansMono_Nerd_Font:h11

set encoding=UTF-8

set tags=tags

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

set splitbelow
set splitright

" Vim-airline

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

let g:ale_disable_lsp = 1

call plug#begin('~/.config/nvim/plugged')

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': 'master'}
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile && yarn prepare', 'branch': 'master'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile && yarn prepare', 'branch': 'master'}
Plug 'neoclide/coc-jest', {'do': 'yarn install --frozen-lockfile && yarn prepare', 'branch': 'master'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile && yarn prepare', 'branch': 'master'}
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'

call plug#end()

set rtp^=~/.config/nvim/plugged/coc.nvim
let g:coc_global_extensions = ['coc-tsserver']
let g:coc_node_path = '/opt/homebrew/bin/node'
let g:coc_user_config = {
\ 'tsserver.disableAutomaticTypeAcquisition': v:true,
\ 'https.rejectUnauthorized': v:false,
\ }

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "javascript" }, 

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

colorscheme gruvbox-material 

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <leader>n :NERDTreeFind<CR>
inoremap <S-CR> <esc>o
inoremap <A-BS> <esc>ldbi
nnoremap <leader>h :noh<CR>

" Move to the next buffer
noremap <leader><Right> :bnext<CR>

" Move to the previous buffer
noremap <leader><Left> :bprevious<CR>

nnoremap <leader><Tab> <C-w>w

" COC
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <C-space> coc#refresh()

" COC Jest
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Ale plugin for linting
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
 
let g:ale_sign_error = 'вЭМ'
let g:ale_sign_warning = 'вЪ†пЄП'
