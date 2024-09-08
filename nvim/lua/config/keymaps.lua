-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
keymap("n", "<S-h>", "<cmd>BufferPrev<cr>", { desc = "Previous buffer" })
keymap("n", "<S-l>", "<cmd>BufferNext<cr>", { desc = "Next buffer" })

-- Re-order to previous/next with Shift < >
keymap("n", "<", "<Cmd>BufferMovePrevious<CR>", { desc = "Reorder buffer left" })
keymap("n", ">", "<Cmd>BufferMoveNext<CR>", { desc = "Reorder buffer right" })

-- Disable > + p, > + P, < + p, < + P
vim.keymap.del("n", ">p")
vim.keymap.del("n", ">P")
vim.keymap.del("n", "<p")
vim.keymap.del("n", "<P")

-- Debugger Keymaps
keymap("n", "<Leader>di", "<cmd> lua require'dap'.step_into()<cr>", { desc = "Step Into" })
keymap("n", "<Leader>do", "<cmd> lua require'dap'.step_over()<cr>", { desc = "Step Over" })
keymap("n", "<Leader>du", "<cmd> lua require'dap'.step_out()<cr>", { desc = "Step Out" })
keymap("n", "<Leader>dc", "<cmd> lua require'dap'.continue()<cr>", { desc = "Continue" })
keymap("n", "<Leader>db", "<cmd> lua require'dap'.toggle_breakpoint()<cr>", { desc = "Toggle Breakpoint" })

keymap(
  "n",
  "<Leader>dB",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
  { desc = "Set Conditional Breakpoint" }
)

keymap("n", "<Leader>dq", "<cmd> lua require'dap'.terminate()<cr>", { desc = "Terminate" })
keymap("n", "<Leader>dr", "<cmd> lua require'dap'.run_last()<cr>", { desc = "Run Last" })
keymap("n", "<Leader>dC", "<cmd> lua require'dap'.run_to_cursor()<cr>", { desc = "Run to Cursor" })
