# Reset all formatting
set -gx FMT_RESET "\e[0m"

# --- Text Colors ---
set -gx FMT_COLOR_BLACK "\e[30m"
set -gx FMT_COLOR_RED "\e[31m"
set -gx FMT_COLOR_GREEN "\e[32m"
set -gx FMT_COLOR_YELLOW "\e[33m"
set -gx FMT_COLOR_BLUE "\e[34m"
set -gx FMT_COLOR_MAGENTA "\e[35m"
set -gx FMT_COLOR_CYAN "\e[36m"
set -gx FMT_COLOR_WHITE "\e[37m"
# Bright/Light versions
set -gx FMT_COLOR_BRIGHT_BLACK "\e[90m" # Often appears as gray
set -gx FMT_COLOR_BRIGHT_RED "\e[91m"
set -gx FMT_COLOR_BRIGHT_GREEN "\e[92m"
set -gx FMT_COLOR_BRIGHT_YELLOW "\e[93m"
set -gx FMT_COLOR_BRIGHT_BLUE "\e[94m"
set -gx FMT_COLOR_BRIGHT_MAGENTA "\e[95m"
set -gx FMT_COLOR_BRIGHT_CYAN "\e[96m"
set -gx FMT_COLOR_BRIGHT_WHITE "\e[97m"

# --- Background Colors ---
set -gx FMT_BG_BLACK "\e[40m"
set -gx FMT_BG_RED "\e[41m"
set -gx FMT_BG_GREEN "\e[42m"
set -gx FMT_BG_YELLOW "\e[43m"
set -gx FMT_BG_BLUE "\e[44m"
set -gx FMT_BG_MAGENTA "\e[45m"
set -gx FMT_BG_CYAN "\e[46m"
set -gx FMT_BG_WHITE "\e[47m"
# Bright/Light versions
set -gx FMT_BG_BRIGHT_BLACK "\e[100m"
set -gx FMT_BG_BRIGHT_RED "\e[101m"
set -gx FMT_BG_BRIGHT_GREEN "\e[102m"
set -gx FMT_BG_BRIGHT_YELLOW "\e[103m"
set -gx FMT_BG_BRIGHT_BLUE "\e[104m"
set -gx FMT_BG_BRIGHT_MAGENTA "\e[105m"
set -gx FMT_BG_BRIGHT_CYAN "\e[106m"
set -gx FMT_BG_BRIGHT_WHITE "\e[107m"

# --- Text Formatting ---
set -gx FMT_BOLD "\e[1m"
set -gx FMT_DIM "\e[2m"           # Often not well supported or looks like normal text
set -gx FMT_ITALIC "\e[3m"        # Not universally supported
set -gx FMT_UNDERLINE "\e[4m"
set -gx FMT_BLINK "\e[5m"         # Often annoying and not well supported
set -gx FMT_REVERSE "\e[7m"       # Swaps foreground and background colors
set -gx FMT_HIDDEN "\e[8m"        # Text is not visible (but can be copied)
set -gx FMT_STRIKETHROUGH "\e[9m" # Not universally supported

# --- Reset specific formatting ---
set -gx FMT_RESET_BOLD_DIM "\e[22m"    # Resets both bold and dim
set -gx FMT_RESET_ITALIC "\e[23m"
set -gx FMT_RESET_UNDERLINE "\e[24m"
set -gx FMT_RESET_BLINK "\e[25m"
set -gx FMT_RESET_REVERSE "\e[27m"
set -gx FMT_RESET_HIDDEN "\e[28m"
set -gx FMT_RESET_STRIKETHROUGH "\e[29m"

function titleecho
    set -l input_string $argv[1]
    set -l string_length (string length -- "$input_string")
    set -l terminal_width (tput cols)

    # Calculate the number of '=' characters for one side based on original script's logic
    set -l num_chars_for_one_bar (math "($terminal_width - $string_length) / 2 - 1")

    # Ensure num_chars_for_one_bar is not negative
    if test $num_chars_for_one_bar -lt 0
        set num_chars_for_one_bar 0
    end

    set -l equals_string (string repeat -n $num_chars_for_one_bar "=")
    set -l bar "$FMT_COLOR_CYAN$FMT_BOLD$equals_string"

    echo -e "$bar $input_string $bar"
end

# Error message
function errecho
    echo -e "$FMT_COLOR_RED$FMT_BOLD""ERROR:"$FMT_RESET" $argv[1]"
    exit 1
end

# Warning message
function warnecho
    echo -e "$FMT_COLOR_YELLOW$FMT_BOLD""WARNING:"$FMT_RESET" $argv[1]"
end

# Log message
function logecho
    echo -e "$FMT_COLOR_GREEN$FMT_BOLD""INFO:"$FMT_RESET" $argv[1]"
end

