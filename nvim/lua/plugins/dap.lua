return {
  "mfussenegger/nvim-dap",
  lazy = false,
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    -- Configure LLDB adapter
    -- local mason_registry = require("mason-registry")
    -- local codelldb = mason_registry.get_package("codelldb")
    -- local extension_path = codelldb:get_install_path() .. "/extension/"
    -- local codelldb_path = extension_path .. "adapter/codelldb"
    -- local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

    -- Use `/Users/tobydavis/.nix-profile/bin/lldb-vscode`
    dap.adapters.codelldb = {
      type = "executable",
      -- port = "${port}",
      -- executable = {
      --   command = "/Users/tobydavis/.nix-profile/bin/lldb-vscode",
      --   args = { "--port", "${port}" },
      -- },
      command = "/Users/tobydavis/.nix-profile/bin/lldb-vscode",
      name = "lldb",
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
