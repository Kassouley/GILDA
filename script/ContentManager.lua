local common = require("common")

-- ContentManager.lua
local ContentManager = {}
ContentManager.__index = ContentManager

function ContentManager:new(attribute)
    if type(attribute) ~= "table" then 
        error("ContentManager Construction need a table as argument")
    end
    local instance = {}
    instance.path = attribute.path
    instance.do_gen = attribute.do_gen
    instance.finalize_callback = attribute.finalize_callback
    instance.subcontents = {}
    
    return setmetatable(instance, ContentManager)
end

function ContentManager:init_subcontent(key, value)
    self.subcontents[key] = value
end

function ContentManager:get_path()
    return self.path
end

function ContentManager:set_do_gen(do_gen)
    self.do_gen = do_gen
end

function ContentManager:generate_content()
    print("Warning : No content generator has been set for the file '"..self.path.."' : Pass")
end

function ContentManager:generate_subcontent()
    print("Warning : No subcontent generator has been set for the file '"..self.path.."' : Pass")
end

function ContentManager:generate_file(data)
    if self.do_gen then
        if self.finalize_callback ~= nil then
            for key, subcontent in pairs(self.subcontents) do
                self.subcontents[key] = self.finalize_callback(subcontent)
            end
        end
        local content = self:generate_content(data)
        if content ~= "" then
            common.write_n_close(self.path, content)
            print("Content generated in '" .. self.path .. "'")
        end
    end
end

return ContentManager
