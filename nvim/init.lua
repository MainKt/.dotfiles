---@diagnostic disable: missing-fields
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true

vim.opt.guicursor = ''
vim.opt.inccommand = 'split'

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

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
vim.keymap.set('n', '<leader>=', vim.lsp.buf.format)

vim.keymap.set('n', '-', '<cmd>Oil<CR>')
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>')
vim.keymap.set('n', '<leader>g', '<cmd>Git<CR>')
vim.keymap.set('n', '<leader>j', '<cmd>Telescope jumplist<CR>')
vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>*', '<cmd>Telescope grep_string<CR>')
vim.keymap.set('n', '<leader>/', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', "<leader>'", '<cmd>Telescope resume<CR>')
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<CR>')
vim.keymap.set('n', '<leader>,', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', 'cx', '<cmd>Telescope diagnostics<CR>')
vim.keymap.set('n', 'cs', '<cmd>Telescope lsp_document_symbols<CR>')
vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>')
vim.keymap.set('n', 'gI', '<cmd>Telescope lsp_implementations<CR>')

local spec = {
  'tpope/vim-sleuth',
  'tpope/vim-fugitive',
  'mbbill/undotree',
  'nvim-tree/nvim-web-devicons',
  "neovim/nvim-lspconfig",

  { 'numToStr/Comment.nvim',   opts = {} },
  { 'lewis6991/gitsigns.nvim', opts = {} },
  { "dundalek/lazy-lsp.nvim",  opts = {}, },
  { 'j-hui/fidget.nvim',       opts = {} },
  { 'stevearc/oil.nvim',       opts = { skip_confirm_for_simple_edits = true } },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = { { "Bilal2453/luvit-meta", lazy = true } },
    opts = {
      library = { { path = "luvit-meta/library", words = { "vim%.uv" } } },
    },
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
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        highlight = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = { ["as"] = "@block.outer", ["is"] = "@block.inner" },
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
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

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
          { name = 'cmdline' },
        },
      }
    end,
  },
}

require("lazy").setup({
  spec = spec,
  install = { colorscheme = { "default" } },
  checker = { enabled = true },
})
