return {
    -- Alpha (Dashboard)
    {
        "goolord/alpha-nvim",
        lazy = true,
    },

    -- Nvimtree (File Explorer)
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },

    {
        'numToStr/Comment.nvim',
    },

      -- Hop (Better Navigation)
    {
        "phaazon/hop.nvim",
        lazy = true,
    },

    -- Bufferline
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons'
    },

    -- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons'
    },


    -- Colorscheme
    {
        'folke/tokyonight.nvim', lazy = false,
    },
    { 'projekt0n/github-nvim-theme', tag = 'v0.0.7',},

    -- Telescope (Fuzzy Finder)
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = {
            {'nvim-lua/plenary.nvim'},
        }
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
    },


    -- Indentation style
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = false,
        init = function ()
            show_end_of_line = true
        end,
    },

    -- Which-key Extension
    {
        "folke/which-key.nvim",
        lazy = true,
    },


    {
     "alexghergh/nvim-tmux-navigation",
        lazy = false,
        config = function()
        local nvim_tmux_nav = require('nvim-tmux-navigation')

        nvim_tmux_nav.setup {
            disable_when_zoomed = true -- defaults to false
        }

        vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
        vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
        vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
        vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
        vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end
    }
}
