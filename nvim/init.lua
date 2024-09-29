---@diagnostic disable: missing-fields
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.guicursor = ''
vim.opt.inccommand = 'split'

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

vim.api.nvim_create_autocmd({ 'TermEnter', 'TermLeave' }, { command = 'set invnu invrnu' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>w', '<C-w>')
vim.keymap.set('n', '<leader>ts', '<cmd>split term://$SHELL<CR>')
vim.keymap.set('n', '<leader>tv', '<cmd>vsplit term://$SHELL<CR>')
vim.keymap.set('n', '<leader>tt', '<cmd>tabnew term://$SHELL<CR>')
vim.keymap.set('n', '<leader>tb', '<cmd>term<CR>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'cr', vim.lsp.buf.rename)
vim.keymap.set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

local spec = {
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'nvim-tree/nvim-web-devicons',
  'neovim/nvim-lspconfig',

  { 'williamboman/mason.nvim',     opts = {} },
  { 'numToStr/Comment.nvim',       opts = {} },
  { 'lewis6991/gitsigns.nvim',     opts = {} },
  { 'j-hui/fidget.nvim',           opts = {} },
  { 'echasnovski/mini.statusline', opts = {} },
  { 'echasnovski/mini.ai',         opts = {} },

  { 'tpope/vim-fugitive',          keys = { { '<leader>g', '<cmd>Git<CR>' } } },
  { 'mbbill/undotree',             keys = { { '<leader>u', '<cmd>UndotreeToggle<CR>' } } },

  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
      keymaps = {
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-s>'] = 'actions.select_split',
      },
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
    },
    keys = { { '-', '<cmd>Oil<CR>' } }
  },

  {
    'williamboman/mason-lspconfig.nvim',
    opts = { handlers = { function(server) require('lspconfig')[server].setup({}) end } }
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'lua-language-server', 'bash-language-server', 'gopls', 'zls', 'pyright', 'rust-analyzer', 'clangd', 'elixir-ls',
        'emmet-ls', 'eslint', 'cpptools',
      },
      auto_update = true,
    }
  },

  {
    'stevearc/conform.nvim',
    opts = { format_on_save = { timeout_ms = 500, lsp_format = 'fallback' } },
    keys = {
      { '<leader>=', function() require('conform').format({ async = true, lsp_format = 'fallback' }) end },
    }
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    dependencies = { { 'Bilal2453/luvit-meta', lazy = true } },
    opts = { library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } } },
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
    keys = function()
      local telescope = require('telescope.builtin')
      return {
        { '<leader><leader>', telescope.find_files },
        { '<leader>j',        telescope.jumplist },
        { '<leader>*',        telescope.grep_string },
        { '<leader>/',        telescope.live_grep },
        { "<leader>'",        telescope.resume },
        { '<leader>?',        telescope.oldfiles },
        { '<leader>,',        telescope.buffers },
        { 'cx',               telescope.diagnostics },
        { 'cs',               telescope.lsp_document_symbols },
        { 'gd',               telescope.lsp_definitions },
        { 'gr',               telescope.lsp_references },
        { 'gI',               telescope.lsp_implementations },
      }
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        highlight = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = { ['as'] = '@block.outer', ['is'] = '@block.inner' },
          },
        },
      })
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
          },
        },
      },
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup {
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'lazydev' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
      }

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = 'path' } },
          { { name = 'cmdline' } }
        ),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui',         opts = {} },
      'nvim-neotest/nvim-nio',
      { 'leoluz/nvim-dap-go',           opts = {} },
      { 'jay-babu/mason-nvim-dap.nvim', opts = {} },
    },
    config = function()
      local dap                                          = require('dap')

      local elixir_ls_debugger                           = vim.fn.exepath('elixir-ls-debugger')
      dap.adapters.mix_task                              = { type = 'executable', command = elixir_ls_debugger }
      dap.configurations.elixir                          = {
        {
          type = 'mix_task',
          name = 'phoenix server',
          task = 'phx.server',
          request = 'launch',
          projectDir = '${workspaceFolder}',
          exitAfterTaskReturns = false,
          debugAutoInterpretAllModules = false,
        },
      }

      local cpptools                                     = vim.fn.exepath('OpenDebugAD7')
      dap.adapters.cppdbg                                = { id = 'cppdbg', type = 'executable', command = cpptools }
      dap.configurations.cpp                             = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
        },
        {
          name = 'Attach to gdbserver :1234',
          type = 'cppdbg',
          request = 'launch',
          MIMode = 'gdb',
          miDebuggerServerAddress = 'localhost:1234',
          miDebuggerPath = '/usr/bin/gdb',
          cwd = '${workspaceFolder}',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
        },
      }

      local dapui                                        = require('dapui')
      dap.listeners.before.attach.dapui_config           = function() dapui.open() end
      dap.listeners.before.launch.dapui_config           = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config     = function() dapui.close() end
    end,

    keys = function()
      local dap, dapui = require('dap'), require('dapui')
      return {
        { '<leader>dc', dap.continue },
        { '<leader>db', dap.toggle_breakpoint },
        { "<leader>dC", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
        { '<leader>di', dap.step_into },
        { '<leader>do', dap.step_out },
        { '<leader>dO', dap.step_over },
        { '<leader>dB', dap.step_back },
        { '<leader>dr', dap.restart },
        { '<leader>du', dapui.toggle },
        { '<leader>de', function() dapui.eval(nil, { enter = true }) end },
      }
    end
  },
}

require('lazy').setup({
  spec = spec,
  install = { colorscheme = { 'default' } },
  checker = { enabled = true },
})
