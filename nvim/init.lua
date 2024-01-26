-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.defer_fn(function()
  require("lualine").setup({
    sections = {
      lualine_x = {
        {
          require("noice").api.statusline.mode.get,
          cond = require("noice").api.statusline.mode.has,
          color = { fg = "#ff9e64" },
        },
      },
    },
  })
end, 500)

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Disable conceal for tex files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "markdown" },
  callback = function()
    vim.wo.conceallevel = 0
  end,
})

-- Set 'option+shift+h' to move to the left window
vim.api.nvim_set_keymap("n", "<A-H>", "<C-W>h", { noremap = true, silent = true })
-- Set 'option+shift+j' to move to the bottom window
vim.api.nvim_set_keymap("n", "<A-J>", "<C-W>j", { noremap = true, silent = true })
-- Set 'option+shift+k' to move to the top window
vim.api.nvim_set_keymap("n", "<A-K>", "<C-W>k", { noremap = true, silent = true })
-- Set 'option+shift+l' to move to the right window
vim.api.nvim_set_keymap("n", "<A-L>", "<C-W>l", { noremap = true, silent = true })
