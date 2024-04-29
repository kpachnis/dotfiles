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
vim.opt.clipboard:append('unnamedplus')
vim.opt.fileformats = unix
vim.opt.number = true
vim.opt.report = 0
vim.opt.smartcase = true
vim.opt.title = true

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.wrap = false

vim.opt.wildignore = {
    '*.o', '*.pyc', '*.pyo', '*.so',
    'build', 'dist', '__pycache__', '.pytest_cache',
    '.DS_STore'
}
vim.opt.wildmode = { 'longest:full', 'full' }

vim.keymap.set("n", "<c-P>",
  "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })

vim.cmd.colorscheme 'catppuccin-mocha'
