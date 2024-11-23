local ContentManager = require("ContentManager")
local Content = require("Content")

script_sh = setmetatable({}, ContentManager)
script_sh.__index = script_sh

function script_sh:new(options, template_path, output_path)
    local attribute = {
        file_name = S:STRING("TOOLS_NAME")..".sh",
        is_sample = true,
        do_not_gen = not options.force_script_gen and true,
        subcontents = {
            ["case_opt"] = Content:new(2),
            ["init_opt_block"] = Content:new(),
            ["enabled_block"] = Content:new(),
            ["help_block"] = Content:new(1)
        } 
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    if instance then setmetatable(instance, script_sh) end
    return instance
end

function script_sh:generate_content()
    return S:STRING("SAMPLE_MSG_2")..[[ 
#!/bin/bash

function export_filter_var() {
    local file="$1"
    local file_content

    if ]].."[[ ! -f \"$file\" ]]"..[[; then
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
        var_name="]]..S:STRING("TOOLS_NAME|upper")..[[_DOMAIN_${key_upper}_FUNCTIONS"
        eval "export $var_name=$value"
    done <<< "$file_content"
}

# Function to display help message
function display_help() {
    echo "Usage: $0 [options] -- application [application_args]"
    echo
    echo "Options:"
    echo -e "  -h, --help \t\t\t Display this help message"
    echo -e "  -f, --filter FILE \t\t\t Specify the input file with functions to intercept"
    echo -e "  --plugin PATH \t\t\t Specify the plugin path (options: stdout or custom path)"
]]..self.subcontents.help_block..[[ 
    exit 0
}

# Variables to store script options
filter_file=""
]]..self.subcontents.init_opt_block..[[ 
app_args=()
INSTALL_DIR="./build/lib"
preload_lib="$INSTALL_DIR/lib]]..S:STRING("PROJECT_NAME|lower")..[[.so"
plugin_path="$INSTALL_DIR/libplugin_stdout.so"

# Parse script arguments
while ]].."[[ $# -gt 0 ]]"..[[; do
    case $1 in
        -h|--help)
            display_help
            ;;
        -f|--filter)
            shift
            filter_file=$1
            ;;
        --plugin)
            shift
            case $1 in
                stdout)
                    plugin_path="$INSTALL_DIR/libplugin_stdout.so"
                    ;;
                *)
                    plugin_path="$1"
                    ;;
            esac
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

export ]]..S:STRING("TOOLS_NAME|upper")..[[_PLUGIN_PATH="$plugin_path"

# Preload the library and launch the application
LD_PRELOAD=$preload_lib "${app_args[@]}"
]]
end


function script_sh:generate_subcontents()
    self.subcontents.case_opt:addfLine("--%s-%s)", S:STRING("DOMAIN"), S:STRING("TOOLS_NAME_ABR"))
    self.subcontents.case_opt:addfLine("\t%s_%s_enabled=1", S:STRING("DOMAIN"), S:STRING("TOOLS_NAME_ABR"))
    self.subcontents.case_opt:addLine("\t;;")

    self.subcontents.init_opt_block:addfLine("%s_%s_enabled=0", S:STRING("DOMAIN"), S:STRING("TOOLS_NAME_ABR"))
    
    self.subcontents.enabled_block:addfLine("if [ $%s_%s_enabled -eq 1 ]; then", S:STRING("DOMAIN"), S:STRING("TOOLS_NAME_ABR"))
    self.subcontents.enabled_block:addfLine("\texport %s=1", S:STRING("DOMAIN_ID"))
    self.subcontents.enabled_block:addLine("fi")

    self.subcontents.help_block:addfLine("echo -e \"  --%s-%s \t\t\t Enable %s of %s library functions\"", 
                                            S:STRING("DOMAIN"), S:STRING("TOOLS_NAME_ABR"), S:STRING("TOOLS_NAME_VERB"), S:STRING("DOMAIN|upper"))

end

return script_sh, "COMMON"
