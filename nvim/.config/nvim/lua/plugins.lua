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
        'folke/tokyonight.nvim',
    },

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

    {
        -- Which-key Extension
        "folke/which-key.nvim",
        lazy = true,
    }
}
