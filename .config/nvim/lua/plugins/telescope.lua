return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-lua/plenary.nvim',
  },
  config = function ()
    local telescope = require('telescope')
    telescope.setup({})

    local function nmap(keys, fun, desc)
      vim.keymap.set('n', keys, fun, { desc = desc })
    end

    -- See `:help telescope.builtin`
    local actions = require "telescope.actions"
    local builtin = require("telescope.builtin")
    nmap('<leader><space>', function()
      require('telescope.builtin').buffers({
        only_cwd = true,
        path_display = { shorten = 5 },
        attach_mappings = function(_, map)
          map("n", "d", actions.delete_buffer)
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
    end, '[F]ind [A]ll files')
    nmap('<leader>fa', function()
      require('telescope.builtin').find_files({
        find_command = { 'rg', '--files', '-g', '!.git/', '-S' }, -- include hidden, exclude git, smartcase
        no_ignore = true,
      })
    end, '[F]ind [F]iles')
    nmap('<leader>fO', builtin.oldfiles, '[F]ind [O]ld Files')
    nmap('<leader>fo', function ()
      builtin.oldfiles({only_cwd = true})
    end, '[F]ind [o]ld Files')
    nmap('<leader>fgf', require('telescope.builtin').git_files, '[F]ind [G]it [F]iles')

    nmap('<leader>fh', require('telescope.builtin').help_tags, '[F]ind [H]elp')
    nmap('<leader>fw', require('telescope.builtin').grep_string, '[F]ind current [W]ord')
    nmap('<leader>fl', require('telescope.builtin').live_grep, '[F]ind by [G]rep')
    nmap('<leader>fd', require('telescope.builtin').diagnostics, '[F]ind [D]iagnostics')

    nmap('<leader>fgs', require('telescope.builtin').git_status, '[F]ind [G]it [S]tatus')
    nmap('<leader>fgc', require('telescope.builtin').git_commits, '[F]ind [G]it [C]ommits')
    nmap('<leader>fgb', require('telescope.builtin').git_branches, '[F]ind [G]it [B]ranches')
  end
}
