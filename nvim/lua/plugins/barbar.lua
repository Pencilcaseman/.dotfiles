return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- Configure barbar here
    animation = true,
    auto_hide = false,
    tabpages = true,
    clickable = true,
    icons = {
      buffer_index = true,
      buffer_number = false,
      button = "",

      -- Use the default icons for diagnostics
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = true },
        -- [vim.diagnostic.severity.INFO] = { enabled = true },
        -- [vim.diagnostic.severity.HINT] = { enabled = true },
      },
      gitsigns = {
        added = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },
      filetype = {
        custom_colors = false,
        enabled = true,
      },
      separator = { left = "", right = "" },
      modified = { button = "󰧞" },
      pinned = { button = "󰐃", filename = true },
      alternate = { filetype = { enabled = false } },
      current = { buffer_index = true },
      inactive = { button = "" },
      visible = { modified = { buffer_number = false } },
    },
    insert_at_end = true,
    insert_at_start = false,
    maximum_padding = 1,
    minimum_padding = 1,
    maximum_length = 30,
    semantic_letters = true,
    letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
    no_name_title = nil,
  },
  config = function(_, fn_opts)
    require("barbar").setup(fn_opts)

    -- Keymaps for barbar
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Move left/right with H and L
    map(
      "n",
      "<Space>hh",
      "<Cmd>BufferPrevious<CR>",
      { noremap = true, silent = true, desc = "Move to the left buffer" }
    )
    map("n", "<Space>ll", "<Cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "Move to the right buffer" })

    -- Move left/right with Space b H and L using a function instead of a command call
    map("n", "<Space>bH", "<Cmd>lua require('barbar').move_left()<CR>", opts)
    map("n", "<Space>bL", "<Cmd>lua require('barbar').move_right()<CR>", opts)

    -- Re-order to previous/next with Space b < >
    map("n", "<Space>b<", "<Cmd>BufferMovePrevious<CR>", opts)
    map("n", "<Space>b>", "<Cmd>BufferMoveNext<CR>", opts)

    -- Goto buffer in position with Space b 1-9
    map("n", "<Space>1", "<Cmd>BufferGoto 1<CR>", opts)
    map("n", "<Space>2", "<Cmd>BufferGoto 2<CR>", opts)
    map("n", "<Space>3", "<Cmd>BufferGoto 3<CR>", opts)
    map("n", "<Space>4", "<Cmd>BufferGoto 4<CR>", opts)
    map("n", "<Space>5", "<Cmd>BufferGoto 5<CR>", opts)
    map("n", "<Space>6", "<Cmd>BufferGoto 6<CR>", opts)
    map("n", "<Space>7", "<Cmd>BufferGoto 7<CR>", opts)
    map("n", "<Space>8", "<Cmd>BufferGoto 8<CR>", opts)
    map("n", "<Space>9", "<Cmd>BufferGoto 9<CR>", opts)
    map("n", "<Space>0", "<Cmd>BufferLast<CR>", opts)

    -- Pin/unpin buffer with Space b p
    map("n", "<Space>bp", "<Cmd>BufferPin<CR>", opts)

    -- Close buffer with Space b c
    map("n", "<Space>bc", "<Cmd>BufferClose<CR>", opts)

    -- Magic buffer-picking mode with Space b g OR Space w
    map("n", "<Space>bg", "<Cmd>BufferPick<CR>", opts)
    -- map("n", "<Space>ww", "<Cmd>BufferPick<CR>", opts)

    -- Sort automatically by...
    map("n", "<Space>bn", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
    map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
    map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
    map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

    vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
      group = vim.api.nvim_create_augroup("Color", {}),
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "BufferCurrentIndex", { fg = "#E6B450", bold = true })
        vim.api.nvim_set_hl(0, "BufferInactiveIndex", { fg = "#836426" })
      end,
    })
  end,
}
