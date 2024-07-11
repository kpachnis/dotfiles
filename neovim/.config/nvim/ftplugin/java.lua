local jdtls = require('jdtls')

local config = {
    cmd = { vim.fn.expand("~") .. "/.local/jdtls/bin/jdtls" },

    root_dir = vim.fs.dirname(vim.fs.find({"gradlew", ".git", "mvnw"}, { upward = true })[1]),

    on_attach = function(_, bufnr)
        -- jdtls_setup.add_commands()

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
            vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })

        vim.api.nvim_buf_create_user_command(bufnr, "W", jdtls.organize_imports, { nargs = 0 })
    end,

    settings = {
        java = {
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                settings = {
                    profile = "GoogleStyle",
                    url = vim.fn.stdpath("config") .. "/ftstyles/eclipse-java-google-style.xml",
                },
            },
        }
    }
}

jdtls.start_or_attach(config)
