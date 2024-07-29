local io_interceptor = require("io_interceptor")

-- FileManager.lua
local FileManager = {}
FileManager.__index = FileManager

function FileManager:new(path_callback, getter_name)
    local instance = {
        path_callback = path_callback,
        getter = require(getter_name),
        subcontents = {}
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

function FileManager:add_subcontent(subcontent_name, sep, ...)
    local content = self.getter[subcontent_name](...)
    if not self.subcontents[subcontent_name] then
        self.subcontents[subcontent_name] = content
    else
        sep = sep or ""
        self.subcontents[subcontent_name] = self.subcontents[subcontent_name] .. sep .. content
    end
end

function FileManager:generate_file(...)
    local content = self.getter.content(self.subcontents, ...)
    if content ~= "" then
        io_interceptor.write_n_close(self:get_path(), content)
        print("Content generated in '" .. self:get_path() .. "'")
    end
end

return FileManager
