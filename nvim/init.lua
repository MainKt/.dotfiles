vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_exec('autocmd TermOpen * setlocal nonu nornu', false)
vim.api.nvim_exec('autocmd TermOpen * startinsert', false)

vim.opt.mouse = 'a'

vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>fs', '<cmd>w<CR>', { desc = '[F]ile [S]ave' })
vim.keymap.set('n', '<leader>w', '<C-w>')

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'black hole and Paste' })

vim.keymap.set('n', '<leader>t', '<cmd>split term://zsh<CR>', { desc = '[T]erminal vsplit' })
vim.keymap.set('n', '<leader>T', '<cmd>tabnew term://zsh<CR>', { desc = '[T]erminal tabnew' })

-- vim.keymap.set('n', '<leader>o-', '<Cmd>Ex<CR>', { desc = '[O]pen Netrw' })
vim.keymap.set('n', '<leader>o-', '<Cmd>Oil<CR>', { desc = '[O]pen Oil' })

vim.keymap.set('n', '<leader>bp', '<Cmd>bp<CR>', { desc = '[B]uffer [P]revious' })
vim.keymap.set('n', '<leader>bn', '<Cmd>bn<CR>', { desc = '[B]uffer [N]ext' })
vim.keymap.set('n', '<leader>`', '<Cmd>b#<CR>', { desc = 'Last buffer' })
vim.keymap.set('n', '<leader>bd', '<Cmd>bd<CR>', { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>bk', '<Cmd>bd<CR>', { desc = '[B]uffer [K]ill' })

vim.keymap.set('n', '<leader>qn', '<Cmd>cn<CR>', { desc = '[Q]uick [N]ext' })
vim.keymap.set('n', '<leader>qp', '<Cmd>cp<CR>', { desc = '[Q]uick [P]revious' })
vim.keymap.set('n', '<leader>ql', '<Cmd>cl<CR>', { desc = '[Q]uick [L]ist' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>ce', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>ce', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  'tpope/vim-sleuth',

  { 'numToStr/Comment.nvim', opts = {} },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ebug', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]indow', _ = 'which_key_ignore' },
        ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>q'] = { name = '[Q]uickfix list', _ = 'which_key_ignore' },
        ['<leader>o'] = { name = '[O]pen', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[F]ile', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
      }
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      require('telescope').setup {

        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>*', builtin.grep_string, { desc = 'Search current Word' })
      vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Search by Grep' })
      vim.keymap.set('n', '<leader>cx', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', "<leader>'", builtin.resume, { desc = 'Search Resume' })
      vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader>bi', builtin.buffers, { desc = 'Find existing buffers' })

      vim.keymap.set('n', '<leader>f/', function()
        builtin.current_buffer_fuzzy_find(require('telescope/themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[F]uzzily search in current buffer' })

      vim.keymap.set('n', '<leader>o/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>fp', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search Neovim files' })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('<leader>cd', require('telescope.builtin').lsp_definitions, 'Code Definition')

          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('<leader>cD', require('telescope.builtin').lsp_references, 'Code References')

          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>ci', require('telescope.builtin').lsp_implementations, '[C]ode [I]mplementation')

          map('<leader>ct', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          map('<leader>cs', require('telescope.builtin').lsp_document_symbols, '[C]ode [S]ymbols')

          map('<leader>cS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')

          map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')

          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          map('<leader>=', vim.lsp.buf.format, 'Format buffer')

          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},

        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<CR>'] = cmp.mapping.confirm { select = true },

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
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'

      vim.cmd.hi 'Comment gui=none'

      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
    end,
  },

  { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup()

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return ''
      end
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',

      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      'leoluz/nvim-dap-go',
      'jonboh/nvim-dap-rr',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        automatic_setup = true,

        handlers = {},

        ensure_installed = {
          'delve',
        },
      }

      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<leader>dj', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })

      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      vim.keymap.set('n', '<leader>dl', dapui.toggle, { desc = 'Debug: See last session result.' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      require('dap-go').setup()
    end,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():append()
      end, { desc = 'Add to Harpoon list' })
      vim.keymap.set('n', '<leader>oh', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[O]pen [H]arpoon UI' })
      vim.keymap.set('n', '<leader>ho', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[H]arpoon [O]pen UI' })

      for i = 1, 9 do
        vim.keymap.set('n', '<leader>' .. i, function()
          harpoon:list():select(i)
        end, { desc = 'Harpoon [' .. i .. ']' })
      end

      vim.keymap.set('n', '<leader>hp', function()
        harpoon:list():prev()
      end, { desc = '[H]arpoon [P]revious' })
      vim.keymap.set('n', '<leader>hn', function()
        harpoon:list():next()
      end, { desc = '[H]arpoon [N]ext' })
    end,
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', '<Cmd>UndotreeToggle<CR>', { desc = '[U]ndotree' })
    end,
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
      'ibhagwan/fzf-lua',
    },
    config = (function()
      vim.keymap.set('n', '<leader>gg', '<Cmd>Neogit<CR>', { desc = '[G]it' })
      vim.keymap.set('n', '<leader>gp', '<Cmd>Neogit push<CR>', { desc = '[G]it' })

      return true
    end)(),
  },

  'tpope/vim-rhubarb',

  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  {
    'nomnivore/ollama.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },

    cmd = { 'Ollama', 'OllamaModel', 'OllamaServe', 'OllamaServeStop' },

    keys = {
      {
        '<leader>oo',
        ":<c-u>lua require('ollama').prompt()<cr>",
        desc = 'ollama prompt',
        mode = { 'n', 'v' },
      },

      {
        '<leader>oG',
        ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
        desc = 'ollama Generate Code',
        mode = { 'n', 'v' },
      },
    },

    opts = {},
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  { 'echasnovski/mini.pairs', opts = {} },

  { 'nvim-treesitter/nvim-treesitter-context' },

  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },

  { 'ThePrimeagen/vim-be-good' },
}
