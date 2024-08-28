local common = require("common")

--- ContentManager class for managing content generation and file writing.
-- This class provides methods for initializing, managing, and generating content,
-- as well as handling subcontent and finalization callbacks.
-- @classmod ContentManager

local ContentManager = {}
ContentManager.__index = ContentManager

--- Constructor for the ContentManager class.
-- Initializes a new ContentManager instance with a set of attributes.
-- @param attribute A table containing attributes such as `path`, `do_gen`, and `finalize_callback`.
-- @return A new instance of the ContentManager class.
function ContentManager:new(attribute)
    if type(attribute) ~= "table" then 
        error("ContentManager Constructor need a table as argument")
    end
    local instance = {}
    instance.path = attribute.path                           -- The file path where content will be generated.
    instance.do_gen = attribute.do_gen                       -- A flag indicating whether content should be generated.
    instance.finalize_callback = attribute.finalize_callback -- A callback function to finalize content.
    instance.subcontents = {}                                -- A table to hold subcontent related to this manager.
    
    return setmetatable(instance, ContentManager)
end

--- Initializes subcontent with a key-value pair.
-- Adds a subcontent entry to the `subcontents` table.
-- @param key The key for the subcontent.
-- @param value The value associated with the key.
function ContentManager:init_subcontent(key, value)
    self.subcontents[key] = value
end

--- Retrieves the file path associated with this ContentManager.
-- @return The file path where content will be generated.
function ContentManager:get_path()
    return self.path
end

--- Sets the flag indicating whether content should be generated.
-- @param do_gen A boolean flag to set the content generation status.
function ContentManager:set_do_gen(do_gen)
    self.do_gen = do_gen
end

--- Generates content for the file.
-- This method should be overridden in a subclass or extended instance.
-- By default, it prints a warning indicating no content generator is set.
function ContentManager:generate_content()
    print("Warning : No content generator has been set for the file '"..self.path.."' : Pass")
end

--- Generates subcontent for the file.
-- This method should be overridden in a subclass or extended instance.
-- By default, it prints a warning indicating no subcontent generator is set.
function ContentManager:generate_subcontent()
    print("Warning : No subcontent generator has been set for the file '"..self.path.."' : Pass")
end

--- Generates the file content and writes it to the specified path.
-- If content generation is enabled and a finalize callback is provided, it finalizes the subcontent
-- before writing the content to the file.
-- @param data Optional data to be passed to the content generator function.
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
