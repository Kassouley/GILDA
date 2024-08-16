local common = require("common")

-- ContentManager.lua
local ContentManager = {}
ContentManager.__index = ContentManager

function ContentManager:new(getter_path, default_gen)
    local getters = common.require_from_path(getter_path)
    local instances = {}
    for key, getter in pairs(getters) do
        local instance = {
            getter = getter,
            subcontents = {},
            do_generate = default_gen
        }
        setmetatable(instance, ContentManager)
        instances[key] = instance
    end
    return instances
end

function ContentManager:reset_subcontent()
    for subcontent_name in pairs(self.subcontents) do
        self.subcontents[subcontent_name] = nil
    end
end

function ContentManager:get_path()
    if type(S[self.getter.kpath]) == "function" then
        return S[self.getter.kpath](S)
    end
    return S[self.getter.kpath]
end

function ContentManager:set_do_generate(do_gen)
    self.do_generate = do_gen
end

function ContentManager:add_single_subcontent(subcontent_name, content)
    if self.do_generate then
        self.subcontents[subcontent_name] = content
    end
end

function ContentManager:add_subcontent(subcontent_name, sep, ...)
    if self.do_generate then
        local content = self.getter[subcontent_name](...)
        if not self.subcontents[subcontent_name] then
            self.subcontents[subcontent_name] = content
        else
            sep = sep or ""
            self.subcontents[subcontent_name] = self.subcontents[subcontent_name] .. sep .. content
        end
    end
end

function ContentManager:generate_file()
    if self.do_generate then
        local content = self.getter.content(self.subcontents)
        if content ~= "" then
            common.write_n_close(self:get_path(), content)
            print("Content generated in '" .. self:get_path() .. "'")
        end
    end
end

return ContentManager
