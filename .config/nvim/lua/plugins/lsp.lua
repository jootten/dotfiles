return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    }
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    opts = {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      }
    }
  },
  {
    "stevearc/aerial.nvim",
    event = "LspAttach",
    config = function ()
      require("aerial").setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>")
    end
  },
  {
    "alexpasmantier/pymple.nvim",
    ft = "python",
    opts = {},
    enabled = false,
    dependencies = {
      'stevearc/dressing.nvim',
      'MunifTanjim/nui.nvim',
      -- and sed, fd and gg (rust)
    }
  },
  {
    {
      "neovim/nvim-lspconfig",
      version = "*",
      dependencies = {
        "saghen/blink.cmp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "nvim-telescope/telescope.nvim",
      },
      opts = {
        servers = {
          "texlab",
          "eslint",
          "ts_ls",
          "sourcekit",
          "svelte",
          "jsonnet_ls",
          "bashls",
          "lua_ls",
          "clangd",
        },
        custom_configs = {
          basedpyright = {
            settings = {
              basedpyright = {
                  analysis = {
                    useLibraryCodeForTypes = true,
                    autoImportCompletions = false
                  }
                }
            }
          },
        }
      },
      config = function (_, opts)
        require('mason').setup()
        local mason_lspconfig = require('mason-lspconfig')

        local ensure_installed = {}
        for _, server in ipairs(opts.servers) do
          if server ~= "sourcekit" then
            table.insert(ensure_installed, server)
          end
        end

        mason_lspconfig.setup({
          ensure_installed = ensure_installed,
          automatic_installation = true,
        })

        local capabilities = require('blink.cmp').get_lsp_capabilities({}, true)
        capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
        vim.lsp.config("*", { capabilities = capabilities })

        for server, config in pairs(opts.custom_configs) do
          vim.lsp.config(server, config)
        end

        vim.keymap.set('n', 'grk', vim.diagnostic.open_float, {silent = true, noremap = true})

        local telescope_builtin = require('telescope.builtin')
        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function (args)
            vim.keymap.set('n', '<leader>fk', telescope_builtin.lsp_document_symbols,
              { desc = "[F]ind Buffer Symbols [K]urrent", noremap = true, silent = true })
            vim.keymap.set('n', '<leader>fs', function ()
              require('telescope.builtin').lsp_dynamic_workspace_symbols({
                ignore_symbols = {
                  'variable'
                }
              })
            end, { desc = "[F]ind [S]ymbols", buffer = args.buf, noremap = true, silent = true })
          end
        })
      end
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = { 'python', 'lua', 'markdown', 'json', 'yaml', 'typescript' },
        auto_install = true,
        sync_install = false,
      })
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
  },
  {
    'Wansmer/treesj',
    keys = { '<leader>m' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
    },
    config = function (_, opts)
      local treesj = require("treesj")
      treesj.setup(opts)
      vim.keymap.set('n', '<leader>m', treesj.toggle)
    end
  },
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
    },
    opts_extend = { 'source.default' }
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'lewis6991/gitsigns.nvim' },
    enabled = true,
    config = function ()
      -- Setup formatters
      local null_ls = require("null-ls")

      -- register any number of sources simultaneously
      local sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.diagnostics.write_good,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.formatting.swiftlint,
      }

      null_ls.setup({ sources = sources })
    end
  }
}
