-- Update the package path to include your Lua INI Parser
require("string_ext")
local LIP = require("LIP")
local lfs = require("lfs")

local string_config = {}
string_config.__index = string_config

-- Function to replace placeholders in a given string
local function replace_placeholders(str, config)
    local function resolve(key)
        local parts = {}
        for part in string.gmatch(key, "[^|]+") do
            table.insert(parts, part)
        end
        local replacement = nil
        for _, section in pairs(config) do
            if section[parts[1]] then 
                replacement = section[parts[1]]
            break
            end
        end
        
        local result = "{"..parts[1].."}"
        if replacement then
            result = (replacement:trim():gsub("{(.-)}", function(inner_key)
                return resolve(inner_key)
            end))
        end
        -- Handle any transformation, like 'upper' or 'lower'
        if parts[2] == "upper" then
            return string.upper(result):trim()
        elseif parts[2] == "lower" then
            return string.lower(result):trim()
        else
            return result:trim()
        end
    end

    return resolve(str)
    
end

-- Constructor for the string_config object
function string_config.new(config_file)
    local self = setmetatable({}, string_config)

    -- Load the INI file into the config table
    self.config = LIP.load(lfs.get_cleaned_path(config_file))
    self.config.STRING.CURRENT_DOMAIN = "N/A"   
    self.config.STRING.HANDLE = "RTLD_NEXT" 
    self.config.STRING.HANDLE_PATH = "N/A" 
    self.config.STRING.INCLUDE_STR = "N/A" 
    return self
end

function string_config:set_current_domain(d)
    self.config.STRING.CURRENT_DOMAIN = d
end

function string_config:set_handle(h)
    self.config.STRING.HANDLE = h
end

function string_config:set_handle_path(hp)
    self.config.STRING.HANDLE_PATH = hp
end

function string_config:set_include_str(is)
    self.config.STRING.INCLUDE_STR = is
end

function string_config:STRING(id)
    local res = replace_placeholders(id, self.config):gsub("\\n","\n")
    return res
end

function string_config:STATUS(id)
    return replace_placeholders(id, self.config)
end

return string_config
