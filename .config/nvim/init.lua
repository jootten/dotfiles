-- Set leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- unset other mappings

-- Load vim config files
local config_path = vim.fn.stdpath('config')
vim.cmd('source ' .. config_path .. '/plugins.vim')
vim.cmd('source ' .. config_path .. '/mappings.vim')
vim.cmd('source ' .. config_path .. '/autocommands.vim')

-- Colorscheme and transparent background
-- vim.cmd('colorscheme catppuccin')

-- Options
local opt = vim.opt

opt.mouse = 'a' -- enable mouse
opt.list = true -- show trailing spaces, tabs etc.
opt.completeopt = 'menuone,noselect'
vim.wo.signcolumn = 'yes' -- sign column always on
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

-- Netrw browser for ssh
vim.g.netrw_altv = 'spr'
vim.g.netrw_banner = 0

-- Airline
vim.g['airline#extensions#tabline#enabled'] = 1

-- VimTex
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1

-- Create a separate venv for pynvim!
local venv = vim.fn.stdpath('data') .. '/venv'
if vim.fn.isdirectory(venv) then
  vim.g.python3_host_prog = venv .. '/bin/python'
end

-- Telescope setup
local telescope = require('telescope')
telescope.setup()

local function nmap(keys, fun, desc)
  vim.keymap.set('n', keys, fun, { desc = desc })
end

-- See `:help telescope.builtin`
local actions = require "telescope.actions"
nmap('<leader>?', require('telescope.builtin').oldfiles, '[?] Find recently opened files')
nmap('<leader><space>', function()
  require('telescope.builtin').buffers({
    only_cwd = true,
    path_display = { 'smart' },
    attach_mappings = function(_, map)
      map("i", "k", actions.move_selection_previous)
      map("i", "j", actions.move_selection_next)
      map("i", "x", actions.delete_buffer)
      return true
    end,
  })
end, '[ ] Find existing buffers')

nmap('<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, '[/] Fuzzily search in current buffer')

nmap('<leader>ff', function()
  require('telescope.builtin').find_files({
    find_command = { 'rg', '--hidden', '--files', '-g', '!.git/', '-S' } -- include hidden, exclude git, smartcase
  })
end, '[F]ind [F]iles')

nmap('<leader>fh', require('telescope.builtin').help_tags, '[F]ind [H]elp')
nmap('<leader>fw', require('telescope.builtin').grep_string, '[F]ind current [W]ord')
nmap('<leader>fl', require('telescope.builtin').live_grep, '[F]ind by [G]rep')
nmap('<leader>fd', require('telescope.builtin').diagnostics, '[F]ind [D]iagnostics')

nmap('<leader>fgs', require('telescope.builtin').git_status, '[F]ind [G]it [S]tatus')
nmap('<leader>fgc', require('telescope.builtin').git_commits, '[F]ind [G]it [C]ommits')
nmap('<leader>fgb', require('telescope.builtin').git_branches, '[F]ind [G]it [B]ranches')

-- Tree explorer setup
require("nvim-tree").setup()

-- nnn file browser setup
require("nnn").setup({
  picker = {
    session = "shared",
  }
})
nmap('<leader>e', function()
  require('nnn').toggle('picker')
end, 'Open [E]xplorer')

require("ibl").setup()

-- Markdown preview setup
require('glow').setup()

-- Treesitter setup
require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>sd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  buf_set_keymap('n', '<leader>ds', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
end

-- Setup lspconfig.
local servers = {
  pyright = {},
  texlab = {},
  eslint = {},
  tsserver = {},
  -- sourcekit = {},
  svelte = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua completion, signature help etc.
require('neodev').setup()

-- Setup mason
require('mason').setup()

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Register ls server setup callbacks
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Setup linting
require('lint').linters_by_ft = {
  python = { 'flake8', }
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- Python Debugging Setup
local dap_python = require('dap-python')
dap_python.setup()
dap_python.test_runner = 'pytest'

table.insert(require('dap').configurations.python, {
  type = 'python';
  request = 'launch';
  name = 'Debug current module';
  module = function()
    local file = vim.fn.expand('%')  -- get current file relative to wd
    file = file:gsub('/', '.'):gsub('.py', '')  -- make module
    return file
  end;
  console = "integratedTerminal";
})
table.insert(require('dap').configurations.python, {
  type = 'python';
  request = 'launch';
  name = 'Debug current module with arguments';
  module = function()
    local file = vim.fn.expand('%')  -- get current file relative to wd
    file = file:gsub('/', '.'):gsub('.py', '')  -- make module
    return file
  end;
  args = function()
    local args_string = vim.fn.input('Arguments: ')
    return vim.split(args_string, " +")
  end;
  console = "integratedTerminal";
})

-- Setup lightbulb
require('nvim-lightbulb').setup({ autocmd = { enabled = true } })

-- Keymap help
require("which-key").setup {}

-- Setup nvim-cmp.
local cmp = require('cmp')


local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  -- sorting = {
  --  comparators = {
  --    cmp_compare.score,
  --  },
  -- },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs( -4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
    { name = 'path' }
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup nvim-autopairs
require('nvim-autopairs').setup({})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

require "lsp_signature".setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded"
  }
})

-- Symbols Outline Configuration
local outline_ops = {
  width = 30,
}
require("symbols-outline").setup(outline_ops)

require("octo").setup()

-- Terminal Setup
require("toggleterm").setup {
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'horizontal', -- 'vertical' | 'horizontal' | 'window' | 'float'
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'shadow', -- single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    width = 150,
    height = 100,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = true, -- disables setting the background color.
})
-- vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
vim.cmd('colorscheme catppuccin')
