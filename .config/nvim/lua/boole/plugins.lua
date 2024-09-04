local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..." vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional
    },
  }
  use {
    "akinsho/bufferline.nvim",
    -- tag = '*',
    requires = "nvim-tree/nvim-web-devicons"
  }
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use {
    "folke/which-key.nvim",
    requires = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.icons"
    },
  }

  -- ToggleTerm
  use {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
    require("toggleterm").setup()
  end}

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use "arzg/vim-substrata"
  use "ChristianChiarulli/nvcode-color-schemes.vim"
  use "folke/tokyonight.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }
  use "morhetz/gruvbox"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- sets a bridge between mason.nvim and nvim-lspconfig for configuration
  -- use "williamboman/nvim-lsp-installer" -- simple to use language server installer (OLD)
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "https://git.sr.ht/~whynothugo/lsp_lines.nvim" -- for LSP Virtual Text lines
  use "danymat/neogen" -- for comment intellisense

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Syntax Highlighting
  use { "nvim-treesitter/nvim-treesitter", lazy=false }

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Discord Rich Presence
  use {"neoclide/coc.nvim", branch = 'release'}

  -- Minimap coding window like Sublime Text
  use {
    "gorbit99/codewindow.nvim",
    config = function()
      local codewindow = require('codewindow')
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  }

  -- for competitive programming
  use {
    'xeluxee/competitest.nvim',
    requires = 'MunifTanjim/nui.nvim',
    config = function() require('competitest').setup() end
  }

  -- Development plugins
  use { '/home/boole/Documents/projects/keylab.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
        vim.keymap.set('n', '<leader>kl', require('keylab').start, { desc = "Start Keylab" })
        vim.keymap.set('n', '<leader>ks', require('keylab').close_game, { desc = "Stop Keylab" })
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
