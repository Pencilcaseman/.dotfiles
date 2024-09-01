return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  lazy = false,
  config = function()
    require("dapui").setup()
  end,
}
