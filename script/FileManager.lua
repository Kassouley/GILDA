local common = require("common")

-- FileManager.lua
local FileManager = {}
FileManager.__index = FileManager

function FileManager:new(path_callback, getter_name, default_gen, domain)
    local instance = {
        path_callback = path_callback,
        getter = require(getter_name),
        subcontents = {},
        do_generate = default_gen,
        domain = domain
    }
    setmetatable(instance, FileManager)
    return instance
end

function FileManager:reset_subcontent()
    for subcontent_name in pairs(self.subcontents) do
        self.subcontents[subcontent_name] = nil
    end
end

function FileManager:get_path()
    if type(S[self.path_callback]) == "function" then
        return S[self.path_callback](S)
    end
    return S[self.path_callback]
end

function FileManager:set_do_generate(do_gen)
    self.do_generate = do_gen
end

function FileManager:add_single_subcontent(subcontent_name, content)
    if self.do_generate then
        self.subcontents[subcontent_name] = content
    end
end

function FileManager:add_subcontent(subcontent_name, sep, ...)
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

function FileManager:generate_file()
    if self.do_generate then
        local content = self.getter.content(self.subcontents)
        if content ~= "" then
            common.write_n_close(self:get_path(), content)
            print("Content generated in '" .. self:get_path() .. "'")
        end
    end
end

return FileManager
