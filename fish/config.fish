# Spack stuff
source $HOME/opt/spack/share/spack/setup-env.fish

# Lmod stuff??
set -gx LMOD_COLORIZE YES
 # source $(spack location -i lmod)/lmod/lmod/init/fish
set -gx LMOD_ROOT /Users/tobydavis/opt/spack/opt/spack/darwin-sequoia-m2/apple-clang-16.0.0/lmod-8.7.37-wq3tl2tvt5v5qsgmuv5ruiv2cuagw5ca
source $LMOD_ROOT/lmod/lmod/init/fish

# X11 binaries
contains /usr/X11/bin $PATH || set -gx PATH /usr/X11/bin $PATH

contains /usr/local/bin $PATH || set -gx PATH /usr/local/bin $PATH
contains /Library/TeX/texbin $PATH || set -gx PATH $PATH /Library/TeX/texbin
contains $HOME/.modular $PATH || set -gx PATH $PATH $HOME/.modular
contains $HOME/.modular/pkg/packages.modular.com_mojo/bin $PATH || set -gx PATH $PATH $HOME/.modular/pkg/packages.modular.com_mojo/bin
contains $HOME/.nix-profile/lib $PATH || set -gx PATH $PATH $HOME/.nix-profile/lib
contains $HOME/.codon/bin $PATH || set -gx PATH $PATH $HOME/.codon/bin

contains $HOME/opt/bin $PATH || set -gx PATH $PATH $HOME/opt/bin

contains $HOME/.nix-profile/lib $LIBRARY_PATH || set -gx LIBRARY_PATH $LIBRARY_PATH $HOME/.nix-profile/lib

# Core Audio? idfk
set -gx COREAUDIO_SDK_PATH /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreAudio.framework

# Cat (bat)
set -gx PATH $PATH "$HOME/.local/bin"
alias cat "bat --paging=always"
alias catp "bat --paging=never"
alias ccat /bin/cat

# if status is-interactive
#     # Commands to run in interactive sessions can go here
# end

set -gx RUSTFLAGS "-C target-cpu=native -C link-arg=-fuse-ld=lld"

 # set -gx LLVM_PATH $(spack location -i llvm)
set -gx LLVM_PATH /Users/tobydavis/opt/spack/opt/spack/darwin-sequoia-m2/apple-clang-16.0.0/llvm-19.1.4-cb34vqt5kaz4tdcn54b4fmx32n7457cu

alias ls lsd
alias lls "lsd -l"
alias btmb "btm --basic"
alias sg "gh copilot suggest"

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

set -gx SDKROOT (xcrun --sdk macosx --show-sdk-path)

# --------------------------------------------------------------------------------------------

set fish_greeting "" # disable fish greeting

starship init fish | source
# zoxide init fish --cmd cd | source
zoxide init fish | source
nh completions --shell fish | source
