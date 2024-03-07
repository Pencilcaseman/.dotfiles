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
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "tex", "markdown" },
--   callback = function()
--     vim.wo.conceallevel = 0
--   end,
-- })

-- Use '#' as the comment character for Nix files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "nix" },
  callback = function()
    vim.bo.commentstring = "# %s"
  end,
})

-- Set fish as the default shell
vim.opt.shell = "fish"

-- Set 'option+shift+h' to move to the left window
vim.api.nvim_set_keymap("n", "<A-H>", "<C-W>h", { noremap = true, silent = true })
-- Set 'option+shift+j' to move to the bottom window
vim.api.nvim_set_keymap("n", "<A-J>", "<C-W>j", { noremap = true, silent = true })
-- Set 'option+shift+k' to move to the top window
vim.api.nvim_set_keymap("n", "<A-K>", "<C-W>k", { noremap = true, silent = true })
-- Set 'option+shift+l' to move to the right window
vim.api.nvim_set_keymap("n", "<A-L>", "<C-W>l", { noremap = true, silent = true })

-- Neovide Configuration
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
end

vim.cmd([[colorscheme tokyonight]])

-- Break on words instead of characters
vim.opt.linebreak = true

-- Change key map timeout to 1s
vim.o.timeoutlen = 1000

-- local spec_treesitter = require("mini.ai").gen_spec.treesitter
-- require("mini.ai").setup({
--   custom_textobjects = {
--     f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
--     o = spec_treesitter({
--       a = { "@conditional.outer", "@loop.outer" },
--       i = { "@conditional.inner", "@loop.inner" },
--     }),
--   },
-- })

-- Disable copilot by default
vim.cmd("Copilot disable")
