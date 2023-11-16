" Ease vim config editing
nmap <Leader>ve :e $MYVIMRC<cr>
nmap <Leader>vs :source $MYVIMRC<cr>

" Cancel search with esc
map <Esc> :noh<cr>

" Exit insert mode with jj
inoremap jj <Esc>

" Exit terminal with esc
tnoremap <Esc> <C-\><C-n>
tnoremap gg <C-\><C-n>
nmap <Leader>t :terminal<cr>i

" Set background
nmap <Leader>sbl :set background=light<cr>
nmap <Leader>sbd :set background=dark<cr>

" Copy to system clipboard
map <Leader>c "+y

" Buffers
nmap <Leader>w :w!<cr>
nmap <Leader>r :bd<cr>

" Fugitive
nmap <Leader>gg :Ge :<cr>
nmap <Leader>gb :GBrowse<cr>
nmap <Leader>gl :G log<cr>
nmap <Leader>gls :G log --stat<cr>
nmap <Leader>gp : G pull<cr>

" Symbols Outline
nmap <Leader>o :SymbolsOutline<cr>

" File browser
" noremap <Leader>e :NvimTreeToggle<cr>

" Debug mappings
nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>

nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>dp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
nnoremap <silent> <Leader>K <Cmd>lua require('dap.ui.widgets').hover()<CR>

" Tmux pane navigation
let g:tmux_navigator_no_mappings = 1

noremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>
" noremap <silent> {Previous-Mapping} :<C-U>TmuxNavigatePrevious<cr>
