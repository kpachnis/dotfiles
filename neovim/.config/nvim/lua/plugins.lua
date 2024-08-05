return {
    { "neovim/nvim-lspconfig" },

    { "mfussenegger/nvim-dap" },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require('nvim-treesitter.configs').setup({
                auto_install = true,

                indent = {
                    enable = true
                },

                highlight = {
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
            })
        end
    },

    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = function()
            require('Comment').setup({})
        end
    },

    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("telescope").setup({
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                },

            })

            require('telescope').load_extension('fzf')

            local builtin = require "telescope.builtin"

            vim.keymap.set("n", "<leader>fd", builtin.find_files)
            vim.keymap.set("n", "<leader>ft", builtin.git_files)
            vim.keymap.set("n", "<leader>fh", builtin.help_tags)
            vim.keymap.set("n", "<leader>fg", builtin.live_grep)
            vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)

        end
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },

        config = function()
            vim.keymap.set('n', '<leader>t', "<cmd>Neotree toggle<cr>")
        end
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
        opts = {
            fast_wrap = {}
        }

    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },

        config = function() require('lualine').setup() end
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night"
        },
    }
}
