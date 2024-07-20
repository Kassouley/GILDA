local io_interceptor = require("io_interceptor")
local StringGenerator = require("string_generator")

local files = {
    f1 = require("content_intercept_table_mgr_source"),
    f2 = require("content_intercept_table_mgr_header"),
    f3 = require("content_intercepted_functions_source"),
    f4 = require("content_intercepted_functions_header"),
    f5 = require("content_callback_source"),
    f6 = require("content_callback_header"),
    f7 = require("content_interceptor_source"),
    f8 = require("content_interceptor_header")
}

local interceptor_generate = {}

-- COMMON --

local function scandir(dir)
    local p = io.popen('ls "' .. dir .. '"')
    local files = {}
    for file in p:lines() do
        table.insert(files, file)
    end
    p:close()
    return files
end

local function generate_file(filepath, content)
    io_interceptor.write_n_close(filepath, content)
end

local function get_include_str(includes_table)
    return "\n#include \""..table.concat(includes_table, "\"\n#include \"") .. "\"\n"
end

-- COMMON --

local function generate_contents(interceptor_data, function_to_intercept)
    local function add_contents(content_name, contents, content)
        if contents[content_name] == nil then
            contents[content_name] = ""
        end
        contents[content_name] = contents[content_name]..content
    end

    local includes_str = get_include_str(interceptor_data.includes)
    local handler = interceptor_data.lib

    local subcontents = {
        f1 = {}, -- Intercept_table_manager source
        f2 = {}, -- Intercept_table_manager header
        f3_auto = {}, -- Intercepted_functions source autogen
        f3_man = {}, -- Intercepted_functions source mangen
        f4 = {}, -- Intercepted_functions header
        f5 = {}, -- Callback source
        f6 = {} -- Callback header
    }
    
    for i, f in ipairs(function_to_intercept) do
        local names_param = {}
        local types_param = {}
        local api_data_t_lines = {}
        local cb_get_args_lines = {}
        
        for _, arg in ipairs(f.args) do
            local type_param, name_param = io_interceptor.parse_variable_declaration(arg)
            table.insert(types_param, type_param)
            table.insert(names_param, name_param)

            table.insert(api_data_t_lines, files.f4.api_data_t_line(arg))
            table.insert(cb_get_args_lines, files.f6.cb_get_args_line(f.name, name_param, type_param))
        end
        local names_param_str = table.concat(names_param, ", ")

        add_contents("load_table_block", subcontents.f1, files.f1.handle_line(f.name))
        
        add_contents("typedef_block", subcontents.f2, files.f2.typedef_line(f))
        add_contents("intercept_table_block", subcontents.f2, files.f2.itcp_tbl_line(f.name))
        
        if f.gen == "AUTOGEN" then
            add_contents("func_blk", subcontents.f3_auto, files.f3.func_blk(f, names_param_str))
        else
            add_contents("func_blk", subcontents.f3_man, files.f3.func_blk(f, names_param_str))
        end

        add_contents("api_data_t_block", subcontents.f4, files.f4.api_data_t_block(f.name, table.concat(api_data_t_lines,"\n")))
        add_contents("api_id_enum_block", subcontents.f4, files.f4.api_id_enum_block(f.name, i))
        add_contents("get_funame_block", subcontents.f4, files.f4.get_funame_block(f.name))

        add_contents("get_args_block", subcontents.f6, files.f6.cb_get_args_block(f.name, table.concat(cb_get_args_lines,"\n")))
    end

    return {
        file1_content = files.f1.content(includes_str, handler, subcontents.f1),
        file2_content = files.f2.content(includes_str, subcontents.f2),
        file3_content_auto = files.f3.content(includes_str, subcontents.f3_auto),
        file3_content_man = subcontents.f3_man.func_blk and files.f3.content(includes_str, subcontents.f3_man) or "",
        file4_content = files.f4.content(includes_str, subcontents.f4),
        file5_content = files.f5.content(),
        file6_content = files.f6.content(includes_str, subcontents.f6)
    }
end

-- COMMAND --
function interceptor_generate.command(config_data, domain_list)
    S = StringGenerator.new(config_data)

    io_interceptor.mkdir(S._GENDIR)
    io_interceptor.mkdir(S._COREDIR)

    for _, domain in ipairs(domain_list) do
        local interceptor_data = config_data[domain]
        if interceptor_data == nil then
            print("Warning: Skipping "..domain..", doesn't exist in config file")
        elseif interceptor_data.input_csv == "" or interceptor_data.lib == "" then
            print("Warning: Skipping "..domain..", config file not complete")
        else
            local function_to_intercept = io_interceptor.parseCSV(interceptor_data.input_csv)
            S._CURRENT_DOMAIN = domain
            local contents = generate_contents(interceptor_data, function_to_intercept)
            io_interceptor.mkdir(S:_AUTOGEN_DOMAIN_DIR(domain))
            generate_file(S:_ITM_SRC_PATH(domain), contents.file1_content)
            generate_file(S:_ITM_HEAD_PATH(domain), contents.file2_content)
            generate_file(S:_IF_AUTO_SRC_PATH(domain), contents.file3_content_auto)
            generate_file(S:_IF_HEAD_PATH(domain), contents.file4_content)
            generate_file(S:_CB_SRC_PATH(domain), contents.file5_content)
            generate_file(S:_CB_HEAD_PATH(domain), contents.file6_content)
            if contents.file3_content_man ~= "" then
                io_interceptor.mkdir(S:_MANGEN_DOMAIN_DIR(domain))
                generate_file(S:_IF_MAN_SRC_PATH(domain), contents.file3_content_man)
            end
        end                  
    end

    local domain_list = scandir(S._AUTOGENDIR)
    local enum_block = {}
    local case_block = {}
    local include_block = {}
    for _, domain in ipairs(domain_list) do
        domain = domain:sub(1, -#("_"..S._TOOLS_NAME)-1)
        S._CURRENT_DOMAIN = domain
        table.insert(case_block, files.f7.case_line())
        table.insert(include_block, files.f8.include_line())
        table.insert(enum_block, files.f8.enum_line())
    end
    generate_file(S:_INTERCEPTOR_SRC_PATH(), files.f7.content(table.concat(case_block, "\n")))
    generate_file(S:_INTERCEPTOR_HEAD_PATH(), files.f8.content(table.concat(enum_block, ",\n"), table.concat(include_block, "\n")))

end

return interceptor_generate
