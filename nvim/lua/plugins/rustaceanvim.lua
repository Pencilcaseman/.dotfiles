return {
  "mrcjkb/rustaceanvim",
  version = "^5", -- Recommended
  lazy = false, -- This plugin is already lazy
  config = function()
    -- local mason_registry = require("mason-registry")
    -- local codelldb = mason_registry.get_package("codelldb")
    -- local extension_path = codelldb:get_install_path() .. "/extension/"
    -- local codelldb_path = extension_path .. "adapter/codelldb"
    -- local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
    -- local cfg = require("rustaceanvim.config")

    -- error("codelldb_path: " .. codelldb_path)

    -- vim.g.rustaceanvim = {
    --   dap = {
    --     adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    --   },
    -- }

    -- Use `/Users/tobydavis/.nix-profile/bin/lldb-vscode`
    -- vim.g.rustaceanvim = {
    --   dap = {
    --     adapter = "codelldb",
    --   },
    -- }

    local dap = require("dap")

    dap.configurations.rust = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
      },
    }

    vim.g.rustaceanvim = function()
      -- Update this path
      local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb"
      local this_os = vim.uv.os_uname().sysname

      -- The path is different on Windows
      if this_os:find("Windows") then
        codelldb_path = extension_path .. "adapter\\codelldb.exe"
        liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
      else
        -- The liblldb extension is .so for Linux and .dylib for MacOS
        liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
      end

      local cfg = require("rustaceanvim.config")
      return {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end
  end,
}
