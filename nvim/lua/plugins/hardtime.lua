-- return {
--   "m4xshen/hardtime.nvim",
--   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
--   -- lazy = false,
--   event = "VeryLazy",
--   -- event = "BufEnter",
--   opts = {
--     enabled = false,
--   },
--   config = function()
--     vim.keymap.set({ "n", "x" }, "j", function()
--       return vim.v.count > 0 and "j" or "gj"
--     end, { noremap = true, expr = true })
--     vim.keymap.set({ "n", "x" }, "k", function()
--       return vim.v.count > 0 and "k" or "gk"
--     end, { noremap = true, expr = true })
--
--     require("hardtime").setup()
--   end,
--   command = "Hardtime",
--   keys = {
--     { "n", "j", "<cmd>Hardtime<CR>", desc = "Hardtime" },
--     { "n", "k", "<cmd>Hardtime<CR>", desc = "Hardtime" },
--     { "n", "gj", "<cmd>Hardtime<CR>", desc = "Hardtime" },
--     { "n", "gk", "<cmd>Hardtime<CR>", desc = "Hardtime" },
--   },
-- }

return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {},
  command = "Hardtime",
  event = "BufEnter",
  keys = {
    { "n", "j", "<cmd>Hardtime<CR>", desc = "Hardtime" },
    { "n", "k", "<cmd>Hardtime<CR>", desc = "Hardtime" },
    { "n", "gj", "<cmd>Hardtime<CR>", desc = "Hardtime" },
    { "n", "gk", "<cmd>Hardtime<CR>", desc = "Hardtime" },
  },
}
