# Ensure programs use the .config directory for config files
set -gx XDG_CONFIG_HOME "$HOME/.config"

set -gx SHELL $HOME/.nix-profile/bin/fish
set -gx NH_HOME_FLAKE "$XDG_CONFIG_HOME/home-manager"

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

set -gx PATH /usr/local/bin $PATH
set -gx PATH /Library/TeX/texbin $PATH
set -gx PATH $HOME/.modular $PATH
set -gx PATH $HOME/.modular/pkg/packages.modular.com_mojo/bin $PATH
set -gx PATH $HOME/.nix-profile/lib $PATH
set -gx PATH $HOME/.codon/bin $PATH

set -gx PATH $HOME/opt/bin $PATH
set -gx PATH $HOME/.config/bin $PATH

set -gx LIBRARY_PATH $HOME/.nix-profile/lib $LIBRARY_PATH

# Cat (bat)
set -gx PATH $PATH "$HOME/.local/bin"
alias cat "bat --paging=always"
alias catp "bat --paging=never"
alias ccat /bin/cat

# Hunspell
set -gx DICT_ROOT $HOME/opt/dict

# Python environment activation
alias vactivate "source .venv/bin/activate.fish"

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
    logecho "Disconnecting Mullvad VPN"
    mullvad lockdown-mode set off
    mullvad disconnect
    warnecho "You are now $FMT_COLOR_RED$FMT_BOLD""UNSECURE""$FMT_RESET"
end

function mullvadforceconnect --description 'Enable lockdown mode and connect the VPN'
    logecho "Connecting Mullvad VPN"
    mullvad lockdown-mode set on
    mullvad connect
    logecho "You are now $FMT_COLOR_GREEN$FMT_BOLD""SECURE""$FMT_RESET"
end

function mullvadreconnect --description 'Reconnect the VPN'
    logecho "Reconnecting Mullvad VPN"
    mullvad reconnect
    logecho "Mullvad $FMT_COLOR_GREEN$FMT_BOLD""RECONNECTED""$FMT_RESET"
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Vulkan SDK
set -gx VULKAN_SDK (realpath ~/VulkanSDK/1.4.304.0/macOS/)

alias ls "eza --icons"
alias lls "eza --icons --smart-group --git --long --binary"
alias tls "eza --icons --tree"
alias tlls "eza --icons --tree --smart-group --git --long --binary"

alias btmb "btm --basic"
alias sg "gh copilot suggest"
alias fs "yazi"
alias zj "zellij"
alias ssh "TERM=xterm-256color command ssh"

alias diff difft

alias lg lazygit

alias mvc mullvadforceconnect
alias mvd mullvadforcedisconnect
alias mvr mullvadreconnect

source $HOME/.config/fish/loadllvm.fish
loadllvm --silent

function gnz --description "Run Ghostty without Zellij"
     NO_ZELLIJ_PLZ=True open -n /Applications/Ghostty.app/
end

# Launch neovide in the background (normally for larger projects)
function nv --description 'Run Neovide in the background'
    neovide $argv &
end

function nvm --description 'Launch a minimal Neovim configuration'
    nvim --clean
end

set -gx PATH $HOME/.local/share/bob/nvim-bin $PATH

# Make a directory and cd into it
function mkcd --description 'Make a directory and cd into it'
    mkdir -p $argv
    cd $argv
end

function nproc --description 'Print the number of processors'
    sysctl -n hw.physicalcpu
end

export PIPX_DEFAULT_PYTHON=$HOME/.nix-profile/bin/python

# Set CARGO_REGISTRY_TOKEN
set -gx CARGO_REGISTRY_TOKEN (cat $HOME/opt/cargo_token.txt)

set -gx MACOSX_DEPLOYMENT_TARGET $(sw_vers -productVersion | cut -d '.' -f1,2)

set -gx SDKROOT (xcrun --sdk macosx --show-sdk-path)

set -gx YAZI_PATH (which yazi)

set -gx FZF_DEFAULT_OPTS \
    "--style full \
--border --padding 1,2 \
--color 'border:#aaaaaa,label:#cccccc' \
--color 'preview-border:#9999cc,preview-label:#ccccff' \
--color 'list-border:#669966,list-label:#99cc99' \
--color 'input-border:#996666,input-label:#ffcccc' \
--color 'header-border:#6699cc,header-label:#99ccff'"

set fish_greeting "" # disable fish greeting

starship init fish | source
zoxide init fish | source
nh completions fish | source
navi widget fish | source
direnv hook fish | source
atuin init fish | source

# Use VIM keybindings
fish_vi_key_bindings
