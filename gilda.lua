-- Set up the script directory and package paths
script_dir = debug.getinfo(1, "S").source:match("@(.*[\\/]?.*)") or ""
script_dir = script_dir:gsub('\\', '/'):match("(.*[\\/])") or ""
local paths = {
    '',
    'script/',
    'script/Class/',
    'script/utils/',
    'script/utils/json/',
    'script/utils/Lua_INI_Parser/',
    'script/commands/',
    'script/commands/check/',
    'script/commands/gen/',
    'script/commands/parse/',
    'script/commands/preprocess/'
}

for _, path in ipairs(paths) do
    package.path = package.path .. ';' .. script_dir .. path .. '?.lua'
end

local common = require("common")
local lfs = require("lfs")
local Script = require("Script")

-- Main script logic
local function main(arg)

    local attribute = {
        name = "gilda",
        version = "1.0",
    }
    local script = Script:new(attribute)

    script:set_usage("gilda [<options>] <command> <command args>")
    script:set_desc([[GILDA (Generated Interception Library with Dynamic Adaptation).]])

    script:add_command("parse", require("gilda_parse"))
    script:add_command("gen", require("gilda_gen"))
    script:add_command("check", require("gilda_check"))
    script:add_command("pre", require("gilda_preprocess"))

    script:execute(arg)
end

-- Run the main function
main(arg)