return { 

    -- Nvimtree (File Explorer)
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
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

    {
        -- Which-key Extension
        "folke/which-key.nvim",
        lazy = true,
    }
}
