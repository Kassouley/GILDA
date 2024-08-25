-- Define the Content class
local Content = {}
Content.__index = Content

-- Constructor to initialize the content and indentation
function Content:new(default_indent)
    local default_indent = default_indent or 0
    local obj = {
        content = {},                                       -- Table to store the lines of code
        current_indent = string.rep("\t", default_indent),  -- Current indentation level
    }
    setmetatable(obj, self)
    return obj
end

-- Method to set indentation level (number of tabs)
function Content:setIndent(level)
    self.current_indent = string.rep("\t", level)
end

-- Method to increase indentation by a specified number of levels
function Content:increaseIndent(levels)
    levels = levels or 1  -- Default to increasing by 1 level
    self.current_indent = self.current_indent .. string.rep("\t", levels)
end

-- Method to decrease indentation by a specified number of levels
function Content:decreaseIndent(levels)
    levels = levels or 1  -- Default to decreasing by 1 level
    local current_length = #self.current_indent
    local decrease_by = levels * 1
    if current_length >= decrease_by then
        self.current_indent = self.current_indent:sub(1, current_length - decrease_by)
    else
        self.current_indent = ""  -- Prevent negative indentation
    end
end

-- Method to append content to the last line
function Content:appendToLine(text)
    if #self.content > 0 then
        self.content[#self.content] = self.content[#self.content] .. text
    else
        -- If there's no content, treat it as the first line with indentation
        self:addLine(text)
    end
end

-- Method to append formatted content to the last line
function Content:appendfToLine(format_str, ...)
    local formatted_line = string.format(format_str, ...)
    self:appendToLine(formatted_line)
end

-- Method to add a line to the content with the current indentation
function Content:addLine(line)
    table.insert(self.content, self.current_indent .. line)
end

-- Method to add a formatted line to the content with the current indentation
function Content:addfLine(format_str, ...)
    local formatted_line = string.format(format_str, ...)
    self:addLine(formatted_line)
end

-- Method to retrieve the full content as a string
function Content:getContent()
    return table.concat(self.content, "\n")
end

-- Method to save the content to a file
function Content:saveToFile(filename)
    local file = io.open(filename, "w")
    file:write(self:getContent())
    file:close()
end

-- Method to clear the content
function Content:clear()
    self.content = {}
    self.current_indent = ""
end

return Content