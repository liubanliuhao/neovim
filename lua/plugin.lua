-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
  {
    'williamboman/mason.nvim',
    config = function()
      require("config.mason")
    end,
    lazy = false
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("config.neodev")
    end
  },
  ----------------------------- lsp -----------------------------
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('config.lsp')
    end,
  },
  {
    'ray-x/lsp_signature.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    }
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    }
  },
  {
    'arkav/lualine-lsp-progress',
    dependencies = {
      'neovim/nvim-lspconfig',
    }
  },
  {
    'lukas-reineke/lsp-format.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    }
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('config.null-ls')
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    dependencies = { "catppuccin/nvim", "lewis6991/gitsigns.nvim" },
    config = function()
      require('config.lspsaga').setup()
    end,
  },
  -- Displaying errors/warnings in a window
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  },

  ----------------------------- ui -----------------------------
  -- better UI
  {
    "stevearc/dressing.nvim",
    config = function()
      require("config.dressing").setup()
    end,
  },
  -- themes
  { "catppuccin/nvim", name = "catppuccin" },
  -- automatic themes switcher
  {
    'JManch/sunset.nvim',
    dependencies = {
      "catppuccin"
    },
    config = function()
      require('config.sunset').setup()
    end,
    lazy = false,
    priority = 1000,
  },
  -- line in the bottom
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("config.lualine")
    end,
  },
  -- indent-blankline
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('config.indent-blankline')
    end,
  },
  -- bufferline
  {
    'akinsho/bufferline.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('config.bufferline')
    end,
  },
  {
    'kazhala/close-buffers.nvim',
  },
  -- nvim-tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('config.nvim-tree')
    end,
  },
  -- welcome dashboard
  {
    'goolord/alpha-nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('config.alpha')
    end
  },
  {
    "VonHeikemen/searchbox.nvim",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
    config = function()
      require("config.searchbox").setup()
    end,
  },
  ------------------------ language parser -----------------------
  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    name = "nvim-treesitter",
    config = function()
      require('config.nvim-treesitter')
    end,
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    dependencies = { "nvim-treesitter" },
  },
  {
    'p00f/nvim-ts-rainbow',
    dependencies = { "nvim-treesitter" },
  },
  ------------------------- finder -------------------------------
  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    name = "telescope.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('config.telescope')
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    dependencies = { "telescope.nvim" },
  },
  --------------------------- git -------------------------------
  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns")
    end
  },
  -- lazygit
  {
    'kdheepak/lazygit.nvim',
  },
  -- diffview
  -- TODO need more document for this
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim'
  },
  ------------------------- auto-complete ------------------------
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
      -- vsnip
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "rafamadriz/friendly-snippets",
      -- lspkind
      "onsails/lspkind-nvim",
      -- nerd-font
      "davidmh/cmp-nerdfonts",
    },
    config = function()
      require('config.nvim-cmp')
    end,
  },
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require('config.copilot')
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  },
  ------------------------- debugger ----------------------------
  -- language specific tools
  -- Adds extra functionality over rust analyzer
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require('config.rust_tools').setup()
    end,
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
    },
  },
  -- clangd extension
  {
    "p00f/clangd_extensions.nvim",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
    },
  },
  -- python extension
  {
    "mfussenegger/nvim-dap-python",
  },
  -- cmake
  {
    -- "cdelledonne/vim-cmake",
    "Civitasv/cmake-tools.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("config.cmake").setup()
    end,
  },
  -- dap settings
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      require('mason-nvim-dap').setup {
        automatic_installation = true,
        ensure_installed = { "python", "cpptools", "codelldb" },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      require('config.debugging').setup()
    end,
  },
  ------------------------- helper -------------------------------
  -- folds
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("config.nvim_ufo").setup()
    end,
  },
  -- commnet
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  -- toggle terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("config.toggle_term")
    end
  },
  -- which-key
  {
    'folke/which-key.nvim',
  },
  -- Makes Directories If They Don't Exist at Save Time
  {
    "jghauser/mkdir.nvim",
  },
  -- autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup {}
    end
  },
  -- for speeding up the loading of plugin
  {
    'lewis6991/impatient.nvim'
  },

})
