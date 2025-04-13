return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    'christoomey/vim-tmux-navigator'
  },
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    ---@module "which-key"
    ---@type wk.Opts
    opts = {
      preset = "helix",
    },
    keys = {
      {
        "<leader>?",
        function ()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)"
      }
    }
  },
  {
    'ellisonleao/glow.nvim',
    opts = {}
  },
  {
    'echasnovski/mini.pairs',
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    }
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- OR 'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {}
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
    config = function ()
      require("ibl").setup()
    end
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = false },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    config = function (_, opts)
      require('snacks').setup(opts)
      vim.keymap.set({ 'n', 'v' }, '<leader>gg', function () Snacks.lazygit() end)
      vim.keymap.set({ 'n', 'v' }, '<leader>bd', function () Snacks.bufdelete() end)
    end
  }
}
