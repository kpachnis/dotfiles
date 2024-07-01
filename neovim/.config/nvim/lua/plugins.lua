return {
    {
        "neovim/nvim-lspconfig"
    },

    {
        "elixir-tools/elixir-tools.nvim",
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local elixir = require("elixir")
            local elixirls = require("elixir.elixirls")

            elixir.setup {
                nextls = {enable = false},
                credo = {enable = false},
                elixirls = {
                    enable = true,
                    repo = "elixir-lsp/elixir-ls",
                    tag = "v0.22.0",
                    settings = elixirls.settings {
                        dialyzerEnabled = true,
                        enableTestLenses = true,
                        suggestSpecs = true,
                    },
                }
            }
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
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
            require("telescope").setup({})
        end
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },

    { "tpope/vim-projectionist" },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({})
        end
    },

    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').load()
        end
    }
}
