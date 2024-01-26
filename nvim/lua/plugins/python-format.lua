return {
  "mhartington/formatter.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local types = "formatter.filetypes."
    require("formatter").setup({
      filetype = {
        python = {
          require(types .. "python").black,
          require(types .. "python").isort,
        },
      },
    })
  end,
}
