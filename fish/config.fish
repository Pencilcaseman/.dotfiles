# Spack is really slow to load, so we only source it when we need it
function spack
    if test -z $SPACK_COMMAND_INITIALIZED
        source $HOME/spack/share/spack/setup-env.fish
        set SPACK_COMMAND_INITIALIZED 1
    end
    command spack $argv
end

# Lmod is also incredibly slow, so we do the same thing here
function module
    if test -z $LMOD_COMMAND_INITIALIZED
        source $(spack location -i lmod)/lmod/lmod/init/fish
        source $HOME/spack/share/spack/setup-env.fish
        set LMOD_COMMAND_INITIALIZED 1
    end
    module $argv
end

function yazi
    DISPLAY="" $YAZI_PATH $argv
end

# X11 binaries
contains /usr/X11/bin $PATH || set -gx PATH /usr/X11/bin $PATH

contains /usr/local/bin $PATH || set -gx PATH /usr/local/bin $PATH
contains /Library/TeX/texbin $PATH || set -gx PATH $PATH /Library/TeX/texbin
contains $HOME/.modular $PATH || set -gx PATH $PATH $HOME/.modular
contains $HOME/.modular/pkg/packages.modular.com_mojo/bin $PATH || set -gx PATH $PATH $HOME/.modular/pkg/packages.modular.com_mojo/bin
contains $HOME/.nix-profile/lib $PATH || set -gx PATH $PATH $HOME/.nix-profile/lib
contains $HOME/.codon/bin $PATH || set -gx PATH $PATH $HOME/.codon/bin

contains $HOME/opt/bin $PATH || set -gx PATH $PATH $HOME/opt/bin
contains $HOME/.config/bin$PATH || set -gx PATH $PATH $HOME/.config/bin
contains $HOME/.local/share/bob/nvim-bin $PATH || set -gx PATH $PATH $HOME/.local/share/bob/nvim-bin

contains $HOME/.nix-profile/lib $LIBRARY_PATH || set -gx LIBRARY_PATH $LIBRARY_PATH $HOME/.nix-profile/lib

# Core Audio? idfk
# set -gx COREAUDIO_SDK_PATH /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreAudio.framework
# set -gx AUDIOUNIT_SDK_PATH /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/AudioUnit.framework

# Cat (bat)
set -gx PATH $PATH "$HOME/.local/bin"
alias cat "bat --paging=always"
alias catp "bat --paging=never"
alias ccat /bin/cat

# Hunspell
set -gx DICT_ROOT $HOME/opt/dict

# Set Neovim as editor
set -gx EDITOR nvim
set -gx VISUAL nvim

function setspellchecklang --description 'Set the spellchecker language'
    # Parse arguments
    set -l silent 0
    set -l lang ""

    for arg in $argv
        if test "$arg" = "--silent"
            set silent 1
        else
            set lang $arg
        end
    end

    # Ensure a language argument was provided
    if test -z "$lang"
        if test $silent -eq 0
            echo "❌ No language specified."
        end
        return 1
    end

    set tmp_path $DICT_ROOT/$lang

    if test -d $tmp_path
        set -gx DICPATH $tmp_path
        if test $silent -eq 0
            echo "✅ Spellchecker language set to '$lang'"
        end
    else
        if test $silent -eq 0
            echo "❌ Language '$lang' does not exist."
        end

        # Get a list of available dictionaries
        set available_dirs (ls -d $DICT_ROOT/* 2>/dev/null | xargs -n1 basename)

        # Perform a fuzzy search (case-insensitive)
        set matches (string match -i -- "*$lang*" $available_dirs)

        if test (count $matches) -gt 0
            if test $silent -eq 0
                echo "📌 Did you mean one of these?"
                for match in $matches
                    echo "   - $match"
                end
            end
        else if test $silent -eq 0
            echo "No similar dictionaries found."
        end
    end
end

setspellchecklang en --silent

# Mullvad commands
function mullvadforcedisconnect --description 'Disable Lockdown Mode and disconnect the VPN'
    mullvad lockdown-mode set off
    mullvad disconnect
end

function mullvadforceconnect --description 'Enable lockdown mode and connect the VPN'
    mullvad lockdown-mode set on
    mullvad connect
end


if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Apple, please ship a proper LLVM installation by default. Pretty please.
set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib/unwind -lunwind" $LDFLAGS
set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib/c++ -L/opt/homebrew/opt/llvm/lib/unwind -lunwind" $LDFLAGS
fish_add_path /opt/homebrew/opt/llvm/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib" $LDFLAGS
set -gx CFLAGS "-I/opt/homebrew/opt/llvm/include" $CFLAGS
set -gx CXXFLAGS "-I/opt/homebrew/opt/llvm/include" $CXXFLAGS

# set -gx CC /usr/bin/clang
# set -gx CXX /usr/bin/clang++

set -gx LIBCLANG_PATH (brew --prefix llvm)/lib
set -gx PATH (brew --prefix llvm)/bin $PATH
set -gx CC (brew --prefix llvm)/bin/clang
set -gx CXX (brew --prefix llvm)/bin/clang++
set -gx FC (brew --prefix flang)/bin/flang-new

set -gx BINDGEN_EXTRA_CLANG_ARGS "-I/opt/homebrew/opt/llvm/include"

# Vulkan SDK
set -gx VULKAN_SDK (realpath ~/VulkanSDK/1.4.304.0/macOS/)

alias ls "eza --icons"
alias lls "eza --icons --smart-group --git --long --binary"
alias tls "eza --icons --tree"
alias tlls "eza --icons --tree --smart-group --git --long --binary"

alias btmb "btm --basic"
alias sg "gh copilot suggest"
alias fs "yazi"

alias diff difft

alias lg lazygit

# Launch alacritty in the background without tmux integration. Useful for cases
# where you want to ssh into a remote machine and run tmux there.
function ant --description 'Run Alacritty in the background'
    alacritty --working-directory=(pwd) --command $SHELL &
end

# Launch neovide in the background (normally for larger projects)
function nv --description 'Run Neovide in the background'
    neovide $argv &
end

function nvm --description 'Launch a minimal Neovim configuration'
    NVIM_MINIMAL=True nvim $argv
end

# Make a directory and cd into it
function mkcd --description 'Make a directory and cd into it'
    mkdir -p $argv
    cd $argv
end

function nproc --description 'Print the number of processors'
    sysctl -n hw.physicalcpu
end

# Ensure programs use the .config directory for config files
set -gx XDG_CONFIG_HOME "$HOME/.config"

# Do this last to ensure the correct python install is used
set -gx PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" $PATH

# Set CARGO_REGISTRY_TOKEN
set -gx CARGO_REGISTRY_TOKEN (cat $HOME/opt/cargo_token.txt)

set -gx MACOSX_DEPLOYMENT_TARGET $(sw_vers -productVersion | cut -d '.' -f1,2)

set -gx SDKROOT (xcrun --sdk macosx --show-sdk-path)

set -gx YAZI_PATH (which yazi)

# ----------------

# set -gx FZF_DEFAULT_OPTS \
#     "--style full \
# --border --padding 1,2 \
# --border-label ' Demo ' --input-label ' Input ' --header-label ' File Type ' \
# --preview 'catp --color always {}' \
# --bind 'result:transform-list-label:
# if [[ -z \$FZF_QUERY ]]; then
#     echo \" \$FZF_MATCH_COUNT items \"
# else
#     echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"
# fi
# ' \
# --bind 'focus:transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" {}' \
# --bind 'focus:+transform-header:file --brief {} || echo \"No file selected\"' \
# --bind 'ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; git ls-files)' \
# --color 'border:#aaaaaa,label:#cccccc' \
# --color 'preview-border:#9999cc,preview-label:#ccccff' \
# --color 'list-border:#669966,list-label:#99cc99' \
# --color 'input-border:#996666,input-label:#ffcccc' \
# --color 'header-border:#6699cc,header-label:#99ccff'"

set -gx FZF_DEFAULT_OPTS \
    "--style full \
--border --padding 1,2 \
--color 'border:#aaaaaa,label:#cccccc' \
--color 'preview-border:#9999cc,preview-label:#ccccff' \
--color 'list-border:#669966,list-label:#99cc99' \
--color 'input-border:#996666,input-label:#ffcccc' \
--color 'header-border:#6699cc,header-label:#99ccff'"

# --------------------------------------------------------------------------------------------

set fish_greeting "" # disable fish greeting

starship init fish | source
# zoxide init fish --cmd cd | source
zoxide init fish | source
nh completions --shell fish | source
navi widget fish | source
direnv hook fish | source

# tv init fish | source

function tv_smart_autocomplete
    set -l current_prompt (commandline -cp)

    set -l output (tv --autocomplete-prompt "$current_prompt")

    if test -n "$output"
        # add a space if the prompt does not end with one (unless the prompt is an implicit cd, e.g. '\.')
        string match -r '.*( |./)$' -- "$current_prompt" || set current_prompt "$current_prompt "
        commandline -r "$current_prompt$output"
    end
end

function tv_shell_history
    set -l current_prompt (commandline -cp)

    set -l output (tv fish-history --input "$current_prompt")

    if test -n "$output"
        commandline -r "$output"
    end
end

bind --erase \ct
bind --erase \cr
bind --erase -M insert \ct
bind --erase -M insert \cr

bind \ct tv_smart_autocomplete
bind \cr tv_shell_history
bind -M insert \ct tv_smart_autocomplete
bind -M insert \cr tv_shell_history

# Use VIM keybindings
fish_vi_key_bindings
