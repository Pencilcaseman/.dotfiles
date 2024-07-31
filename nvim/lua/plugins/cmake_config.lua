local M = {}

-- Function to get the project root directory
function M.get_project_root()
  return vim.fn.getcwd()
end

-- Function to initialize CMake build directory
function M.cmake_init()
  local project_root = M.get_project_root()
  local build_dir = project_root .. "/.nvim_cmake"

  -- Create build directory if it doesn't exist
  if vim.fn.isdirectory(build_dir) == 0 then
    vim.fn.mkdir(build_dir, "p")
  end

  -- Change to build directory
  vim.fn.chdir(build_dir)

  -- Run CMake
  local cmake_command = "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .."
  local output = vim.fn.system(cmake_command)
  local exit_code = vim.v.shell_error

  if exit_code ~= 0 then
    print("Error running CMake command. Exit code: " .. exit_code)
    print("Output: " .. output)
  else
    print("CMake initialization successful")

    -- Symlink compile_commands.json to project root
    local link_command =
      string.format("ln -sf %s/compile_commands.json %s/compile_commands.json", build_dir, project_root)
    vim.fn.system(link_command)

    -- Change back to project root
    vim.fn.chdir(project_root)

    -- Restart LSP
    vim.cmd("LspRestart")
  end
end

-- Function to build the project
function M.cmake_build()
  local project_root = M.get_project_root()
  local build_dir = project_root .. "/.nvim_cmake"

  if vim.fn.isdirectory(build_dir) == 0 then
    print("Build directory not found. Run :CMakeInit first.")
    return
  end

  vim.fn.chdir(build_dir)
  local build_command = "cmake --build ."
  local output = vim.fn.system(build_command)
  local exit_code = vim.v.shell_error

  if exit_code ~= 0 then
    print("Error building project. Exit code: " .. exit_code)
    print("Output: " .. output)
  else
    print("Build successful")
  end

  vim.fn.chdir(project_root)
end

-- Create custom commands
vim.api.nvim_create_user_command("CMakeInit", M.cmake_init, {})
vim.api.nvim_create_user_command("CMakeBuild", M.cmake_build, {})

return M
