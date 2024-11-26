local lfs = require("lfs")

--- ContentManager class for managing content generation and file writing.
-- This class provides methods for initializing, managing, and generating content,
-- as well as handling subcontent and finalization callbacks.
-- @classmod ContentManager

local ContentManager = {}
ContentManager.__index = ContentManager

--- Constructor for the ContentManager class.
-- Initializes a new ContentManager instance with a set of attributes.
-- @param attribute A table containing attributes such as `file_name`, `do_not_gen`, `is_sample` and `subcontents`.
-- @return A new instance of the ContentManager class.
function ContentManager:new(attribute, template_path, output_path)
    if type(attribute) ~= "table" then 
        error("ContentManager Constructor need a table as argument")
    end

    local script_path = lfs.get_script_path(2)
    local script_dir, script_name = lfs.split_path(script_path)
    local tmp = string.gsub(script_dir, template_path, "")
    local output_file = attribute.file_name
    local output_dir = lfs.concat_path(output_path, tmp)

    local instance = {}
    instance.output_file = output_file  -- The file name where the file will be generated.
    instance.output_dir = output_dir
    instance.output_path = lfs.concat_path(output_dir, output_file)
    instance.script_name = script_name
    instance.script_dir = script_dir
    instance.subcontents = attribute.subcontents or {}       -- A table to hold subcontent related to this manager.
    instance.do_not_gen = attribute.do_not_gen or false      -- A flag indicating whether content should be generated.
    instance.is_sample = attribute.is_sample or false

    local filename = instance.output_path
    if instance.is_sample and lfs.file_exists(filename) and instance.do_not_gen then 
        print("Warning : Sample file '" .. filename .. "' already exists : Pass")
        return nil
    elseif instance.is_sample and not lfs.file_exists(filename) then
        instance.do_not_gen = false
    end
    return setmetatable(instance, ContentManager)
end

--- Generates content for the file.
-- This method should be overridden in a subclass or extended instance.
-- By default, it prints a warning indicating no content generator is set.
function ContentManager:generate_content()
    print("Warning : No content generator has been set for the file '"..self.script_name.."' : Pass")
    return ""
end

--- Generates subcontent for the file.
-- This method should be overridden in a subclass or extended instance.
-- By default, it prints a warning indicating no subcontent generator is set.
function ContentManager:generate_subcontents()
    return ""
end

--- Generates the file content and writes it to the specified path.
-- If content generation is enabled and a finalize callback is provided, it finalizes the subcontent
-- before writing the content to the file.
-- @param data Optional data to be passed to the content generator function.
function ContentManager:generate_file(data)
    for key, subcontent in pairs(self.subcontents) do
        if self.subcontents[key] == "" then self.do_not_gen = true end
    end
    if self.do_not_gen == false then
        local filename = self.output_path
        local content = self:generate_content(data)
        if content ~= "" then
            local dirname = lfs.split_path(filename)
            lfs.mkdir(dirname)
            local file = lfs.open_file(filename, "w")
            file:write(content)
            file:close()
            print("Success: Content generated in '" .. filename .. "'")
        end
    end
end

return ContentManager
