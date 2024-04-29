return {
    "nvim-treesitter/nvim-treesitter",
    {
        "numToStr/Comment.nvim",
        lazy = false,
    },
    { "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({})
        end
    }
}
