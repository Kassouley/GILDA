local script_sh = {}

function script_sh.content(subcontent)
    return string.format([[
%s

#!/bin/bash

function export_filter_var() {
    local file="$1"
    local file_content

    if [[ ! -f "$file" ]].."]]"..[[; then
        echo "File not found!"
        return 1
    fi

    file_content=$(cat "$file")
    file_content=$(echo "$file_content" | tr '\n' ' ')
    file_content=$(echo "$file_content" | tr -s '[:space:]' ' ')
    file_content=$(echo "$file_content" | sed 's/, \+/,/g')
    file_content=$(echo "$file_content" | sed 's/ : \+/:/g')
    file_content=$(echo "$file_content" | tr ' ' '\n')

    # For debugging, let's print the cleaned content
    while IFS=: read -r key value; do
        key_upper=$(echo "$key" | tr '[:lower:]' '[:upper:]')
        var_name="%s_DOMAIN_${key_upper}_FUNCTIONS"
        eval "export $var_name=$value"
    done <<< "$file_content"
}

# Function to display help message
function display_help() {
    echo "Usage: $0 [options] -- application [application_args]"
    echo
    echo "Options:"
    echo "  -h, --help                       Display this help message"
    echo "  -f, --filter FILE                Specify the input file with functions to intercept"
%s
    exit 0
}

# Variables to store script options
filter_file=""
%s
app_args=()
preload_lib="./lib/lib%s.so"

# Parse script arguments
while [[ $# -gt 0 ]].."]]"..[[; do
    case $1 in
        -h|--help)
            display_help
            ;;
        -f|--filter)
            shift
            filter_file=$1
            ;;
%s
        --)
            shift
            app_args=("$@")
            break
            ;;
        -*)
            echo "Unknown option: $1"
            display_help
            ;;
        *)
            app_args+=("$1")
            ;;
    esac
    shift
done

# Check if application arguments are provided
if [ ${#app_args[@]} -eq 0 ]; then
    echo "Error: No application specified."
    display_help
fi

# Check if preload library exists
if [ ! -f "$preload_lib" ]; then
    echo "Error: Preload library '$preload_lib' not found."
    exit 1
fi

# Handle the input file for function interception
if [ -n "$filter_file" ]; then
    export_filter_var "$filter_file"
fi

# Handle library interception
%s

# Preload the library and launch the application
LD_PRELOAD=$preload_lib "${app_args[@]}"

]],
		S._SAMPLE_MSG_2,
        S._TOOLS_NAME_UPPER,
        subcontent.help_block,
        subcontent.init_opt_block,
        S._TOOLS_NAME,
        subcontent.case_opt,
        subcontent.enabled_block
    )
end

function script_sh.case_opt()
    return string.format([[
        --%s-%s)
            %s_%s_enabled=1
            ;;]], 
        S:_DOMAIN(), S._TOOLS_NAME_ABR,
        S:_DOMAIN(), S._TOOLS_NAME_ABR
    )
end

function script_sh.init_opt_block()
    return string.format([[
%s_%s_enabled=0
]],     
        S:_DOMAIN(), S._TOOLS_NAME_ABR
    )
end

function script_sh.enabled_block()
    return string.format([[
if [ $%s_%s_enabled -eq 1 ]; then
    export %s=1
fi
]],     
        S:_DOMAIN(), S._TOOLS_NAME_ABR,
        S:_DOMAIN_ID()
    )
end

function script_sh.help_block()
    return string.format([[    echo "  --%s-%s                       Enable %s of %s library functions"]],     
        S:_DOMAIN(), S._TOOLS_NAME_ABR,
        S._TOOLS_NAME_VERB, S:_DOMAIN_UPPER()
    )
end



return script_sh