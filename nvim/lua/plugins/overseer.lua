return {
  "stevearc/overseer.nvim",
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {},
  config = function(_, opts)
    require("overseer").setup(opts)
    local map = vim.api.nvim_set_keymap

    map("n", "<Space>Ob", "<Cmd>OverseerBuild<CR>", opts)
    map("n", "<Space>Oc", "<Cmd>OverseerClose<CR>", opts)
    map("n", "<Space>Od", "<Cmd>OverseerDeleteBundle<CR>", opts)
    map("n", "<Space>Ol", "<Cmd>OverseerLoadBundle<CR>", opts)
    map("n", "<Space>Oo", "<Cmd>OverseerOpen<CR>", opts)
    map("n", "<Space>Or", "<Cmd>OverseerRun<CR>", opts)
    map("n", "<Space>Os", "<Cmd>OverseerSaveBundle<CR>", opts)
    map("n", "<Space>Ot", "<Cmd>OverseerTaskAction<CR>", opts)
  end,
}
