local function trim(s)
    s = s:match("^%s*(.-)%s*$")
    s = s:gsub("%s+", " ")
    return s
end

function splitOutsideParentheses(str)
    local result = {}
    local bracket_level = 0
    local start_index = 1
    
    for i = 1, #str do
        local char = str:sub(i, i)
        
        if char == '(' then
            bracket_level = bracket_level + 1
        elseif char == ')' then
            bracket_level = bracket_level - 1
        elseif char == ',' and bracket_level == 0 then
            table.insert(result, trim(str:sub(start_index, i-1)))  -- trim spaces
            start_index = i + 1
        end
    end
    
    table.insert(result, trim(str:sub(start_index)))  -- add the last part and trim spaces
    
    return result
end

local function cleanContent(content)
    local inCommentBlock = false
    local cleanContent = ""

    for line in content:lines() do  -- Use gmatch to iterate over lines
        local trimmedLine = trim(line)  -- Trim leading and trailing spaces

        -- Remove single-line comments "//"
        trimmedLine = trimmedLine:gsub("//.-$", "")
        trimmedLine = trimmedLine:gsub("#.-$", "")
        trimmedLine = trimmedLine:gsub("typedef.-$", "")

        if inCommentBlock then
            -- Check if the current line contains the end of a block comment
            local endIndex = trimmedLine:find("%*/")
            if endIndex then
                inCommentBlock = false
                trimmedLine = trimmedLine:sub(endIndex + 2)  -- Exclude the block comment end and anything after it
            else
                trimmedLine = ""  -- Entire line is inside a block comment, skip it
            end
        else
            -- Check if the current line starts a block comment
            local startIndex = trimmedLine:find("/%*")
            if startIndex then
                -- Check if it also ends on the same line
                local endIndex = trimmedLine:find("%*/", startIndex + 2)
                if endIndex then
                    -- Block comment starts and ends on the same line, remove it
                    trimmedLine = trimmedLine:sub(1, startIndex - 1) .. trimmedLine:sub(endIndex + 2)
                else
                    -- Block comment starts but does not end on the same line
                    inCommentBlock = true
                    trimmedLine = trimmedLine:sub(1, startIndex - 1)  -- Remove the block comment start
                end
            end
        end

        -- Append cleaned line to result if not empty
        if trimmedLine ~= "" then
            cleanContent = cleanContent .. trimmedLine
        end
    end

    return cleanContent
end


local function parseFunctionPrototype(line)
    local returnType, funcName, params = line:match("([%w_%s]+)%s+([%w_%s]+)%s*%((.*)%)%s*$")
    if not returnType or not funcName then
        return nil
    end
    return returnType, funcName, params
end


local function processHeaderFile(content)
    -- Split the content by ";" to get complete function prototypes
    functions = {}
    for prototype in content:gmatch("[^;]+") do
        local returnType, funcName, args = parseFunctionPrototype(trim(prototype))
        if args == "void" then
            args = ""
        end
        if returnType and funcName then
            table.insert(functions, {
                returnType = returnType,
                funcName = funcName,
                args = splitOutsideParentheses(args)
            })
        end
    end

    return functions
end

local function writeCSV(functions, outputFilename)
    local file = io.open(outputFilename, "w")
    if not file then
        print("Error: Unable to open output file " .. outputFilename)
        return
    end

    for _, func in ipairs(functions) do
        for _, f in ipairs(func) do
            local line = { "AUTOGEN", f.returnType, f.funcName }
            for _, arg in ipairs(f.args) do
                table.insert(line, arg)
            end
            file:write(table.concat(line, ";"), "\n")
        end
    end

    file:close()
end

-- Check if a file has a specific extension
local function hasExtension(filename, ext)
    return filename:sub(-#ext) == ext
end

-- Main function to handle input and output
local function main()
    if #arg < 2 then
        print("Usage: lua " .. arg[0] .. " <output_csv_file> <header_file1> [<header_file2> ...]")
        return
    end

    local outputFilename = arg[1]
    if not hasExtension(outputFilename, ".csv") then
        print("Error: Output file must have a .csv extension")
        return
    end

    local functions = {}
    for i = 2, #arg do
        local inputFilename = arg[i]
        if hasExtension(inputFilename, ".h") or hasExtension(inputFilename, ".hpp") then
            local file = io.open(inputFilename, "r")
            if not file then
                print("Error: Unable to open file " .. filename)
                return
            end
            local file_functions = processHeaderFile(cleanContent(file))
            table.insert(functions, file_functions)
           
            file:close()
        else
            print("Warning: Skipping non-header file " .. inputFilename)
        end
    end

    writeCSV(functions, outputFilename)
    print("CSV file generated: " .. outputFilename)
end

main()
