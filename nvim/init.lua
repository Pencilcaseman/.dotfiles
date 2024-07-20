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

require("conform").setup({
  formatters_by_ft = {
    cpp = { "clang-format" },
    c = { "clang-format" },
  },
  format_on_save = true,
  opts = {
    format = {
      extra_options = {
        -- Specify the path to your .clang-format file
        config = "/Users/tobydavis/dev/librapid_dev/.clang-format",
      },
    },
  },
})

vim.keymap.set("n", "<leader>th", function()
  vim.lsp.inlay_hint(0, nil)
end, { desc = "Toggle Inlay Hints" })

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

-- Create an autocommand group
local quickscope_group = vim.api.nvim_create_augroup("qs_colors", { clear = true })

-- Create autocommands within the group
vim.api.nvim_create_autocmd("ColorScheme", {
  group = quickscope_group,
  callback = function()
    vim.api.nvim_set_hl(0, "QuickScopePrimary", {
      fg = "#FF08A5",
      underline = true,
      ctermfg = 155,
      cterm = { underline = true },
    })
    vim.api.nvim_set_hl(0, "QuickScopeSecondary", {
      fg = "#40FF1D",
      underline = true,
      ctermfg = 81,
      cterm = { underline = true },
    })
  end,
})

-- vim.cmd([[colorscheme tokyonight]])
vim.cmd([[colorscheme ayu]])

-- Set the line number color
vim.api.nvim_set_hl(0, "LineNr", { fg = "#C1AE89" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#E0585D" })

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

-- Spectre
vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word",
})
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})

-- Enable word-wrap by default
vim.cmd([[set wrap]])
