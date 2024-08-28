-- local M = {}
--
-- -- Function to get the project root directory
-- function M.get_project_root()
--   return vim.fn.getcwd()
-- end
--
-- -- Function to initialize CMake build directory
-- function M.cmake_init()
--   local project_root = M.get_project_root()
--   local build_dir = project_root .. "/.nvim_cmake"
--
--   -- Create build directory if it doesn't exist
--   if vim.fn.isdirectory(build_dir) == 0 then
--     vim.fn.mkdir(build_dir, "p")
--   end
--
--   -- Change to build directory
--   vim.fn.chdir(build_dir)
--
--   -- Run CMake
--   local cmake_command = "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .."
--   local output = vim.fn.system(cmake_command)
--   local exit_code = vim.v.shell_error
--
--   if exit_code ~= 0 then
--     print("Error running CMake command. Exit code: " .. exit_code)
--     print("Output: " .. output)
--   else
--     print("CMake initialization successful")
--
--     -- Symlink compile_commands.json to project root
--     local link_command =
--       string.format("ln -sf %s/compile_commands.json %s/compile_commands.json", build_dir, project_root)
--     vim.fn.system(link_command)
--
--     -- Change back to project root
--     vim.fn.chdir(project_root)
--
--     -- Restart LSP
--     vim.cmd("LspRestart")
--   end
-- end
--
-- -- Function to build the project
-- function M.cmake_build()
--   local project_root = M.get_project_root()
--   local build_dir = project_root .. "/.nvim_cmake"
--
--   if vim.fn.isdirectory(build_dir) == 0 then
--     print("Build directory not found. Run :CMakeInit first.")
--     return
--   end
--
--   vim.fn.chdir(build_dir)
--   local build_command = "cmake --build ."
--   local output = vim.fn.system(build_command)
--   local exit_code = vim.v.shell_error
--
--   if exit_code ~= 0 then
--     print("Error building project. Exit code: " .. exit_code)
--     print("Output: " .. output)
--   else
--     print("Build successful")
--   end
--
--   vim.fn.chdir(project_root)
-- end
--
-- -- Create custom commands
-- vim.api.nvim_create_user_command("CMakeInit", M.cmake_init, {})
-- vim.api.nvim_create_user_command("CMakeBuild", M.cmake_build, {})
--
-- return M

local M = {}
local Job = require("plenary.job")

-- Function to get the project root directory
function M.get_project_root()
  return vim.fn.getcwd()
end

-- Function to run a command with inherited environment
local function run_command_with_env(cmd, cwd, on_exit)
  Job:new({
    command = "sh",
    args = { "-c", cmd },
    cwd = cwd,
    env = vim.fn.environ(), -- This inherits the parent shell's environment
    -- on_exit = function(j, return_val)
    --   on_exit(return_val, table.concat(j:result(), "\n"))
    -- end,
    on_stdout = function(_, data)
      -- table.insert(output, data)
      print(data) -- Print each line of output as it's received
    end,
    on_stderr = function(_, data)
      -- table.insert(output, data)
      print(data) -- Print each line of error output as it's received
    end,
    on_exit = function(j, return_val)
      on_exit(return_val, table.concat(j:result(), "\n"))
    end,

    -- on_exit = function(_, return_val)
    --   on_exit(return_val, table.concat(output, "\n"))
    -- end,
  }):start()
end

-- Function to initialize CMake build directory
function M.cmake_init()
  local project_root = M.get_project_root()
  local build_dir = project_root .. "/.nvim_cmake"
  print("Building in " .. build_dir)

  -- Create build directory if it doesn't exist
  if vim.fn.isdirectory(build_dir) == 0 then
    vim.fn.mkdir(build_dir, "p")
    print("Created build directory")
  end

  -- Run CMake
  print("Running CMake")
  local cmake_command = "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .."
  run_command_with_env(cmake_command, build_dir, function(exit_code, output)
    if exit_code ~= 0 then
      print("Error running CMake command. Exit code: " .. exit_code)
      print("Output: " .. output)
    else
      print("CMake initialization successful")

      -- Symlink compile_commands.json to project root
      local link_command =
        string.format("ln -sf %s/compile_commands.json %s/compile_commands.json", build_dir, project_root)
      run_command_with_env(link_command, project_root, function(link_exit_code, link_output)
        if link_exit_code ~= 0 then
          print("Error creating symlink. Exit code: " .. link_exit_code)
          print("Output: " .. link_output)
        else
          -- Schedule LSP restart
          vim.schedule(function()
            vim.cmd("LspRestart")
          end)
        end
      end)
    end
  end)
end

-- Function to build the project
function M.cmake_build()
  local project_root = M.get_project_root()
  local build_dir = project_root .. "/.nvim_cmake"

  if vim.fn.isdirectory(build_dir) == 0 then
    print("Build directory not found. Run :CMakeInit first.")
    return
  end

  local build_command = "cmake --build ."
  run_command_with_env(build_command, build_dir, function(exit_code, output)
    if exit_code ~= 0 then
      print("Error building project. Exit code: " .. exit_code)
      print("Output: " .. output)
    else
      print("Build successful")
    end
  end)
end

-- Create custom commands
vim.api.nvim_create_user_command("CMakeInit", M.cmake_init, {})
vim.api.nvim_create_user_command("CMakeBuild", M.cmake_build, {})

return M

-- return {
--   "cmake_config",
--   config = function()
--     vim.api.nvim_create_user_command("CMakeInit", M.cmake_init, {})
--     vim.api.nvim_create_user_command("CMakeBuild", M.cmake_build, {})
--   end,
-- }
