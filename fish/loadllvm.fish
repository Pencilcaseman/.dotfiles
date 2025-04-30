function loadllvm --description "Load a specific version of LLVM or Apple Clang"
    # Default to the latest version if no argument is provided
    set -l llvm_version ""
    set -l llvm_version_str ""
    set -l silent_mode 0
    set -l tool_name "LLVM"
    set -l tool_path ""

    if test (count $argv) -gt 0
        if test $argv[1] = "--silent"
            set silent_mode 1

            if test (count $argv) -gt 1
                set llvm_version "$argv[2]"
            end
        else
            set llvm_version "$argv[1]"
        end
    end

    # Handle Apple Clang case
    if test "$llvm_version" = "apple-clang"
        set tool_name "Apple Clang"
        set tool_path "/usr"

        if not test -x "$tool_path/bin/clang"
            if test $silent_mode -eq 0
                echo "Error: $tool_name not found at $tool_path/bin/clang"
            end
            return 1
        end
    else
        # Handle LLVM versions
        if test -n "$llvm_version"
            set llvm_version_str "@$llvm_version"
        end

        set tool_path (brew --prefix "llvm$llvm_version_str")

        if not test -d "$tool_path"
            if test $silent_mode -eq 0
                echo "Error: LLVM$llvm_version_str not found. Make sure it's installed via Homebrew."
            end
            return 1
        end
    end

    # Set environment variables
    set -gx LLVM_PATH "$tool_path"
    set -gx LIBCLANG_PATH "$LLVM_PATH/lib"

    if test "$llvm_version" = "apple-clang"
        set -gx PATH "$LLVM_PATH/bin" $PATH
        set -gx CC "$LLVM_PATH/bin/clang"
        set -gx CXX "$LLVM_PATH/bin/clang++"
    else
        set -gx PATH "$LLVM_PATH/bin" $PATH
        set -gx CC "$LLVM_PATH/bin/clang"
        set -gx CXX "$LLVM_PATH/bin/clang++"
    end

    # Set Fortran compiler variables
    set -gx FC (brew --prefix gfortran)/bin/gfortran
    set -gx F77 $FC
    set -gx F99 $FC

    if test $silent_mode -eq 0
        echo "$tool_name$llvm_version_str loaded successfully from $LLVM_PATH"
    end
end

