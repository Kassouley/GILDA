--- Content class for managing and formatting code content with indentation.
-- This class provides methods to manage content with customizable indentation, including adding lines, 
-- appending to lines, and saving the content to a file.
-- @classmod Content

local Content = {}
Content.__index = Content

--- Constructor for the Content class.
-- Initializes a new Content object with an optional default indentation level.
-- @param default_indent The default indentation level (in tabs) for the content. Defaults to 0.
-- @return A new instance of the Content class.
function Content:new(default_indent)
    local default_indent = default_indent or 0
    local obj = {
        content = {},                                       -- Table to store the lines of code
        current_indent = string.rep("\t", default_indent),  -- Current indentation level
    }
    setmetatable(obj, self)
    return obj
end

--- Sets the current indentation level.
-- Adjusts the indentation level by setting the number of leading tabs for future lines.
-- @param level The number of tabs to set for indentation.
function Content:setIndent(level)
    self.current_indent = string.rep("\t", level)
end

--- Increases the current indentation by a specified number of levels.
-- Adds additional tabs to the current indentation level.
-- @param levels The number of indentation levels to add. Defaults to 1.
function Content:increaseIndent(levels)
    levels = levels or 1  -- Default to increasing by 1 level
    self.current_indent = self.current_indent .. string.rep("\t", levels)
end

--- Decreases the current indentation by a specified number of levels.
-- Removes tabs from the current indentation level, preventing negative indentation.
-- @param levels The number of indentation levels to remove. Defaults to 1.
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

--- Appends text to the last line of content.
-- Adds additional text to the most recent line without affecting indentation.
-- If there are no lines yet, it treats the text as the first line.
-- @param text The text to append to the last line.
function Content:appendToLine(text)
    if #self.content > 0 then
        self.content[#self.content] = self.content[#self.content] .. text
    else
        -- If there's no content, treat it as the first line with indentation
        self:addLine(text)
    end
end

--- Appends formatted text to the last line of content.
-- Uses a format string and additional arguments to create formatted text and append it to the last line.
-- @param format_str The format string.
-- @param ... Additional arguments to format the string.
function Content:appendfToLine(format_str, ...)
    local formatted_line = string.format(format_str, ...)
    self:appendToLine(formatted_line)
end

--- Adds a new line of content with the current indentation.
-- Inserts a new line with the current indentation level into the content.
-- @param line The line of text to add.
function Content:addLine(line)
    table.insert(self.content, self.current_indent .. line)
end

--- Adds a formatted line of content with the current indentation.
-- Uses a format string and additional arguments to create a formatted line and adds it to the content.
-- @param format_str The format string.
-- @param ... Additional arguments to format the string.
function Content:addfLine(format_str, ...)
    local formatted_line = string.format(format_str, ...)
    self:addLine(formatted_line)
end

--- Retrieves the full content as a single string.
-- Concatenates all lines of content into a single string, separated by newlines.
-- @return A string containing the entire content.
function Content:getContent()
    return table.concat(self.content, "\n")
end

--- Define the __tostring metamethod to use getContent() when the object is printed.
-- @return The result of getContent().
function Content:__tostring()
    return self:getContent()
end

--- Define the __concat metamethod to concatenate the content with a string.
-- @param a The first operand (can be a string or a Content object).
-- @param b The second operand (can be a string or a Content object).
-- @return The concatenated result as a string.
function Content:__concat(other)
    if type(other) == "string" then
        return self:getContent() .. other
    elseif type(self) == "string" and getmetatable(other) == Content then
        return self .. other:getContent()
    elseif getmetatable(other) == Content then
        return self:getContent() .. other:getContent()
    else
        error("Attempt to concatenate Content with unsupported type")
    end
end

--- Saves the content to a file.
-- Writes the content to a specified file.
-- @param filename The name of the file to save the content to.
function Content:saveToFile(filename)
    local file = io.open(filename, "w")
    file:write(self:getContent())
    file:close()
end

--- Clears the content.
-- Resets the content and the current indentation level to their initial states.
function Content:clear()
    self.content = {}
    self.current_indent = ""
end

return Content
