local ContentManager = require("ContentManager")
local Content = require("Content")

local finalize_subcontent = function(arg) 
    return arg:getContent()
end

local f = ContentManager:new({path = S._SCRIPT_PATH, do_gen = false, finalize_callback = finalize_subcontent})

function f:generate_content()
    return S._SAMPLE_MSG_2..[[ 

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
        var_name="]]..S._TOOLS_NAME_UPPER..[[_DOMAIN_${key_upper}_FUNCTIONS"
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
]]..self.subcontents.help_block..[[ 
    exit 0
}

# Variables to store script options
filter_file=""
]]..self.subcontents.init_opt_block..[[ 
app_args=()
preload_lib="./lib/lib]]..S._TOOLS_NAME..[[.so"

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
]]..self.subcontents.case_opt..[[ 
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
]]..self.subcontents.enabled_block..[[

# Preload the library and launch the application
LD_PRELOAD=$preload_lib "${app_args[@]}"

]]
end


f:init_subcontent("case_opt", Content:new(2))
f:init_subcontent("init_opt_block", Content:new())
f:init_subcontent("enabled_block", Content:new())
f:init_subcontent("help_block", Content:new(1))

function f:generate_subcontents()
    self.subcontents.case_opt:addfLine("--%s-%s)", S._DOMAIN, S._TOOLS_NAME_ABR)
    self.subcontents.case_opt:addfLine("\t%s_%s_enabled=1", S._DOMAIN, S._TOOLS_NAME_ABR)
    self.subcontents.case_opt:addLine("\t;;")

    self.subcontents.init_opt_block:addfLine("%s_%s_enabled=0", S._DOMAIN, S._TOOLS_NAME_ABR)
    
    self.subcontents.enabled_block:addfLine("if [ $%s_%s_enabled -eq 1 ]; then", S._DOMAIN, S._TOOLS_NAME_ABR)
    self.subcontents.enabled_block:addfLine("\texport %s=1", S._DOMAIN_ID)
    self.subcontents.enabled_block:addLine("fi")

    self.subcontents.help_block:addfLine("echo \"  --%s-%s                       Enable %s of %s library functions\"", 
                                            S._DOMAIN, S._TOOLS_NAME_ABR, S._TOOLS_NAME_VERB, S._DOMAIN_UPPER)


end

return {f=f}