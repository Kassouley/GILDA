local common = require("common")

local gilda_parse = {}

local function cleanContent(content)
    local inCommentBlock = false
    local cleanContent = ""

    for line in content:lines() do  -- Use gmatch to iterate over lines
        local trimmedLine = common.trim(line)  -- Trim leading and trailing spaces

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


local function process_header(content)
    -- Split the content by ";" to get complete function prototypes
    functions = {}
    for prototype in content:gmatch("[^;]+") do
        local returnType, funcName, args = parseFunctionPrototype(common.trim(prototype))
        if args == "void" then
            args = ""
        end
        if returnType and funcName then
            table.insert(functions, {
                returnType = returnType,
                funcName = funcName,
                args = common.split_outside_scope(args,",","(",")")
            })
        end
    end

    return functions
end

local function get_csv_content(functions)
    local content = ""
    for _, func in ipairs(functions) do
        for _, f in ipairs(func) do
            local line = { "AUTOGEN", f.returnType, f.funcName }
            for _, arg in ipairs(f.args) do
                table.insert(line, arg)
            end
            content = content..table.concat(line, ";").."\n"
        end
    end
    return content
end


-- COMMAND --
function gilda_parse.command(domain, header_files, output_dir, options)
    if #header_files == 0 then
        print("Error: At least one header file must be specified for the 'parse' command.")
        return
    end
    common.mkdir(output_dir.."/"..domain)
    os.execute("python3 script/header_parser.py "..domain.." "..output_dir.."/"..domain.." "..table.concat(header_files, " "))
    -- local functions = {}
    -- for _, header_file in pairs(header_files) do
    --     if common.has_extension(header_file, ".h")
    --     or common.has_extension(header_file, ".hpp") then
    --         local file = io.open(header_file, "r")
    --         if not file then
    --             print("Error: Unable to open file " .. header_file)
    --             return
    --         end
    --         local file_functions = process_header(cleanContent(file))
    --         table.insert(functions, file_functions)
           
    --         file:close()
    --     else
    --         print("Warning: Skipping non-header file " .. header_file)
    --     end
    -- end

    -- local content = get_csv_content(functions)
    -- common.write_n_close(output_csv_file, content)
    -- print("CSV file generated: " .. output_csv_file)
end

return gilda_parse
