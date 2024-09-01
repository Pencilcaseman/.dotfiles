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
  format_on_save = false,
  opts = {
    format = {
      extra_options = {
        -- Specify the path to your .clang-format file
        -- config = "/Users/tobydavis/dev/librapid_dev/.clang-format",
      },
    },
  },
})

-- vim.keymap.set("n", "<leader>th", function()
--   vim.lsp.inlay_hint(0, nil)
-- end, { desc = "Toggle Inlay Hints" })

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

-- Set the visual mode selection color
vim.api.nvim_set_hl(0, "Visual", { bg = "#2A2753" })

-- Set the inlay hint color
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#5577A1" })

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

-- Enable word-wrap by default
vim.cmd([[set wrap]])

-- Map 'space rg' to GrugFar
vim.api.nvim_set_keymap("n", "<leader>rg", ":GrugFar<CR>", { noremap = true, silent = true })

-- Set 'noignorecase' so search commands are case sensitive
-- vim.opt.ignorecase = false

-- Swap '0' and '^'
vim.keymap.set("n", "0", "^", { noremap = true })
vim.keymap.set("n", "^", "0", { noremap = true })
vim.keymap.set("v", "0", "^", { noremap = true })
vim.keymap.set("v", "^", "0", { noremap = true })

-- Resession Configuration
local resession = require("resession")
resession.setup()
vim.keymap.set("n", "<leader>sS", resession.save)
vim.keymap.set("n", "<leader>sL", resession.load)
vim.keymap.set("n", "<leader>sD", resession.delete)

-- Create a new directory-specific session when Neovim exits.
-- Reload the session when Neovim starts if no args were passed
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only load the session if nvim was started with no args
    if vim.fn.argc(-1) == 0 then
      -- Save these to a different directory, so our manual sessions don't get polluted
      resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
    end
  end,
  nested = true,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
  end,
})
