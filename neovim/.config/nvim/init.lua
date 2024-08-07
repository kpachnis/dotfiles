vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
require("lazy").setup("plugins")

vim.opt.autowrite = true
vim.opt.belloff = all
vim.opt.clipboard:append("unnamedplus")
vim.opt.fileformats = unix
vim.opt.number = true
vim.opt.report = 0
vim.opt.termguicolors = true
vim.opt.title = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true

vim.opt.undofile = true

vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.wrap = false

vim.o.statusline = [[[%n] %<%f %h%m%r %y%=%{v:register} %-14.(%l,%c%V%) %P]]

vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append(".git,.hg")
vim.opt.wildignore:append("*.o,*.so")
vim.opt.wildignore:append("*.pyc,*.pyo,build,dist,__pycache__,.pytest_cache")
vim.opt.wildignore:append(".DS_STore,._*")

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function()
      local save_cursor = vim.fn.getpos(".")
      pcall(function() vim.cmd [[%s/\s\+$//e]] end)
      vim.fn.setpos(".", save_cursor)
    end,
})

