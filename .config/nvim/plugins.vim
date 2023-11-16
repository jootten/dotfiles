" Auto Setup
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" List Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joshdick/onedark.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Find stuff
Plug 'nvim-telescope/telescope.nvim' 
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'pwntester/octo.nvim' " Github

" Awesome tpope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sleuth' " Detect tabstop and shiftwidth automatically

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP and stuff
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'folke/neodev.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'simrat39/symbols-outline.nvim'

" Completion
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'

" Linting and formatting
Plug 'psf/black', { 'tag': '*.*.*' }
Plug 'mfussenegger/nvim-lint'
Plug 'nvie/vim-flake8'

" Filetype plugins
Plug 'lervag/vimtex'
Plug 'hashivim/vim-terraform'

" Others
Plug 'nvim-lua/plenary.nvim' " Lua utilities
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'luukvbaal/nnn.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/which-key.nvim'
Plug 'akinsho/toggleterm.nvim' " Toggle terminal
Plug 'windwp/nvim-autopairs'
Plug 'ellisonleao/glow.nvim' " Markdown preview
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'junegunn/goyo.vim' " Focus mode
Plug 'jlanzarotta/bufexplorer'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'christoomey/vim-tmux-navigator' " tmux pane navigation

call plug#end()
