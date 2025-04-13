-- Set leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- unset other mappings

require("config.lazy")

-- Load vim config files
local config_path = vim.fn.stdpath('config')
local mappings_path = config_path .. '/mappings.vim'
vim.cmd('source ' .. mappings_path)
vim.cmd('source ' .. config_path .. '/autocommands.vim')

-- vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
vim.cmd('colorscheme tokyonight-night')

-- Options
local opt = vim.o

opt.mouse = 'a' -- enable mouse
opt.list = true -- show trailing spaces, tabs etc.
opt.completeopt = 'menuone,noselect'
-- vim.wo.signcolumn = 'yes' -- sign column always on
opt.undofile = true -- undo history
vim.o.termguicolors = true

opt.breakindent = true -- wrapped lines same indent
opt.smartindent = true

-- Sensible defaults
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

opt.relativenumber = true -- relative line numbers
opt.number = true -- but not the line we are on

-- Ignore case if not upper case in search
opt.ignorecase = true
opt.smartcase = true

-- Decrease update time
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 300

-- Buffer options
opt.hidden = true
opt.autoread = true
opt.autowrite = true

-- Scrolloff
opt.so = 15

-- Windows
opt.splitright = true

-- Netrw browser for ssh
vim.g.netrw_altv = 'spr'
vim.g.netrw_banner = 0

-- Airline
-- vim.g['airline#extensions#tabline#enabled'] = 1

-- VimTex
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1

-- Create a separate venv for pynvim!
local venv = vim.fn.stdpath('data') .. '/venv'
if vim.fn.isdirectory(venv) then
  vim.g.python3_host_prog = venv .. '/bin/python'
end

local function nmap(keys, fun, desc)
  vim.keymap.set('n', keys, fun, { desc = desc })
end

-- Config keymaps
nmap('<leader>vem', function () vim.cmd('e ' .. mappings_path) end)
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- local lsp_formatting = function ()
--   vim.lsp.buf.format() -- {
--     -- filter = function (client)
--     --   return client.name == "null-ls"
--     -- end,
--   -- })
-- end

-- local on_attach = function(client, bufnr)
--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

--   -- Enable completion triggered by <c-x><c-o>
--   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

--   -- Mappings.
--   local opts = { noremap = true, silent = true }
--   vim.api.nvim_set_keymap('n', '<leader>sd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--   vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
--   vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
--   vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   vim.keymap.set('n', '<space>f', lsp_formatting, {noremap = true, silent = true, buffer = bufnr})

--   buf_set_keymap('n', '<leader>ds', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
--   nmap('<leader>fs', function ()
--     require('telescope.builtin').lsp_dynamic_workspace_symbols({
--       ignore_symbols = {
--         'variable'
--       }
--     })
--   end, "[F]ind [S]ymbols")
-- end

-- Setup lspconfig.
-- local servers = {
--   pyright = {
--     -- settings = {
--     -- python = {
--     --     analysis = {
--     --       autoSearchPaths = true,
--     --       diagnosticMode = "openFilesOnly",
--     --       -- useLibraryCodeForTypes = true
--     --     }
--     --   }
--     -- }
--   },

-- Register ls server setup callbacks
-- local handlers = {
--   ["lua_ls"] = function ()
--     require("lspconfig")["lua_ls"].setup({
--       on_init = function(client)
--         if client.workspace_folders then
--           local path = client.workspace_folders[1].name
--           if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
--             return
--           end
--         end

--         client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
--           runtime = {
--             -- Tell the language server which version of Lua you're using
--             -- (most likely LuaJIT in the case of Neovim)
--             version = 'LuaJIT'
--           },
--           -- Make the server aware of Neovim runtime files
--           workspace = {
--             checkThirdParty = false,
--             library = {
--               vim.env.VIMRUNTIME
--               -- Depending on the usage, you might want to add additional paths here.
--               -- "${3rd}/luv/library"
--               -- "${3rd}/busted/library",
--             }
--             -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
--             -- library = vim.api.nvim_get_runtime_file("", true)
--           },
--         })
--       end,
--       settings = {
--         Lua = {
--           completion = {
--             callSnippet = 'Replace',
--           },
--           -- diagnostics = {
--           --   globals = { "vim" }
--           -- },
--         }
--       }
--     }
--   )
--   end
-- }
