local ContentManager = require("ContentManager")
local Content = require("Content")
local common = require("common")

intercepted_functions_h = setmetatable({}, ContentManager)
intercepted_functions_h.__index = intercepted_functions_h

function intercepted_functions_h:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("DOMAIN").."_domain/"..S:STRING("IF_HDR"),
        subcontents = {
            ["typedef_block"] = Content:new(),
            ["api_data_t_block"] = Content:new(),
            ["api_id_enum_block"] = Content:new(1),
            ["func_proto_block"] = Content:new(),
            ["get_funame_block"] = Content:new(2),
            ["get_funaddr_block"] = Content:new(2),
            ["get_pointed_args_block_before"] = Content:new(3),
            ["get_pointed_args_block_after"] = Content:new(3),
            ["get_funid_block"] = Content:new(1),
            ["args_data_block"] = Content:new()
        } 
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, intercepted_functions_h)
    return instance
end

function intercepted_functions_h:generate_content()
    function typedef_block(self)
        return [[     
// ]]..S:STRING("DOMAIN|upper")..[[ Functions Types
]]..self.subcontents.typedef_block
    end

    function api_id_enum_block(self)
        return [[     
// ]]..S:STRING("DOMAIN|upper")..[[ API ID enum
typedef enum {
]]..self.subcontents.api_id_enum_block..[[ 
    ]]..S:STRING("IF_API_ID_PREFIX")..[[NB_FUNCTION,
    ]]..S:STRING("IF_API_ID_PREFIX")..[[UNKNOWN,
} ]]..S:STRING("IF_API_ID_T")..[[;
]]
    end

    function get_funame_block(self)
        return [[     
// Return ]]..S:STRING("DOMAIN|upper")..[[ API function name for a given ID
]]..S:STRING("IF_GET_FUNAME_FUNC_DECL")..[[ 
{
    switch(id) {
]]..self.subcontents.get_funame_block..[[ 
        default : return NULL;
    }
    return NULL;
}
]]
    end

    function get_funaddr_block(self)
        return [[     
// Return ]]..S:STRING("DOMAIN|upper")..[[ API function adress for a given ID
]]..S:STRING("IF_GET_FUNADDR_FUNC_DECL")..[[ 
{
    switch(id) {
]]..self.subcontents.get_funaddr_block..[[ 
        default : return NULL;
    }
    return NULL;
}
]]
    end
    
    function get_funid_block(self)
        return [[     
// Return ]]..S:STRING("DOMAIN|upper")..[[ API function ID for a given name
]]..S:STRING("IF_GET_FUNID_FUNC_DECL")..[[ 
{
    if (name == NULL) return ]]..S:STRING("IF_API_ID_PREFIX")..[[UNKNOWN;
]]..self.subcontents.get_funid_block..[[ 
    return ]]..S:STRING("IF_API_ID_PREFIX")..[[UNKNOWN;
}
]]
    end

    function args_data_block(self)
        return [[     
// ]]..S:STRING("DOMAIN|upper")..[[ API Args Data
]]..self.subcontents.args_data_block
    end

    function func_proto_block(self)
        return [[     
// ]]..S:STRING("DOMAIN|upper")..[[ API Function Prototype
]]..self.subcontents.func_proto_block
    end

    function api_data_t_block(self)
        return [[     
// ]]..S:STRING("DOMAIN|upper")..[[ API args
typedef union ]]..S:STRING("IF_API_ARGS_S")..[[ {
]]..self.subcontents.api_data_t_block..[[ 
} ]]..S:STRING("IF_API_ARGS_T")..[[;
]]
    end
    
    function get_pointed_args_block(self)
        return [[     
// Get ]]..S:STRING("DOMAIN|upper")..[[ API function pointed arguments values
]]..S:STRING("IF_GET_POINTED_ARGS_DECL")..[[ 
{
    if (!is_enter) {
        switch(id) {
]]..self.subcontents.get_pointed_args_block_after..[[ 
            default : break;
        }
    } else {
        switch(id) {
]]..self.subcontents.get_pointed_args_block_before..[[ 
            default : break;
        }
    }
}
]]
    end

    local def_header = S:STRING("DOMAIN|upper").."_"..S:STRING("TOOLS_NAME_ADJ|upper").."_FUNCTIONS_H"
    return S:STRING("WARNING_MSG")..[[ 

#ifndef ]]..def_header..[[ 
#define ]]..def_header..[[ 

]]..S:STRING("INCLUDE_STR")..[[ 
#include <string.h>
#include <stdbool.h>


#define ]]..S:STRING("STRING_SIZE_MAX")..[[ 128

#define ]]..S:STRING("DOMAIN|upper")..[[_FUNCTION_CALL(func, ...) { \
	clock_gettime(CLOCK_MONOTONIC, &]]..S:STRING("CB_API_DATA_VAR")..[[->start_time); \
	((__##func##_t)]]..S:STRING("DOMAIN_API_TABLE_VAR")..[[.api_fn[]]..S:STRING("IF_API_ID_PREFIX")..[[##func])(__VA_ARGS__); \
	clock_gettime(CLOCK_MONOTONIC, &]]..S:STRING("CB_API_DATA_VAR")..[[->stop_time); \
};

#define ]]..S:STRING("DOMAIN|upper")..[[_FUNCTION_CALL_RET(ret_type, func, ...) \
	clock_gettime(CLOCK_MONOTONIC, &]]..S:STRING("CB_API_DATA_VAR")..[[->start_time); \
	ret_type ]]..S:STRING("CB_API_RET_VAR")..[[ = ((__##func##_t)]]..S:STRING("DOMAIN_API_TABLE_VAR")..[[.api_fn[]]..S:STRING("IF_API_ID_PREFIX")..[[##func])(__VA_ARGS__); \
	clock_gettime(CLOCK_MONOTONIC, &]]..S:STRING("CB_API_DATA_VAR")..[[->stop_time); \
	]]..S:STRING("CB_API_DATA_VAR")..[[->]]..S:STRING("DOMAIN")..[[_args.func.retval = (ret_type)]]..S:STRING("CB_API_RET_VAR")..[[; \

]]..func_proto_block(self)..[[ 

]]..api_id_enum_block(self)..[[ 

]]..get_funame_block(self)..[[ 

]]..get_funid_block(self)..[[ 

]]..get_funaddr_block(self)..[[ 

]]..args_data_block(self)..[[ 

]]..api_data_t_block(self)..[[ 

]]..get_pointed_args_block(self)..[[ 

]]..typedef_block(self)..[[ 

#endif // ]]..def_header
end

-----------------------------
-- HEADER SUBCONTENT
-----------------------------

local function struct_args_line(signature)
    local api_data_t_lines = Content:new(1)
    for _, param in pairs(signature) do
        if param.ctype == "function" then
            api_data_t_lines:addfLine("%s;", param.pdecl)
        elseif param:is_pointer() then
            api_data_t_lines:addfLine(
                "%s%s %s;", 
                param:get_cleaned_vtype(), string.rep("*", param.dyn_ref_cnt), param.name)
        else
            api_data_t_lines:addfLine(
                "%s %s;", 
                param:get_cleaned_vtype():gsub("const%s+", ""), param.name)
        end
        if param:is_pointer() and not param:is_generic_ptr() then
            api_data_t_lines:addfLine("struct { // %s", param.vtype)
            for j = 1, param.dyn_ref_cnt-1 do
                api_data_t_lines:addfLine("\t%s* ptr%d;", param:get_cleaned_vtype(), j)
            end
            if param.ctype == "string" then
                api_data_t_lines:addfLine("\tchar val[%s];", S:STRING("STRING_SIZE_MAX"))
            elseif param.ctype ~= "void" and param.ctype ~= "string" then
                api_data_t_lines:addfLine("\t%s val;", param:get_cleaned_vtype():gsub("const%s+", ""))
            end
            api_data_t_lines:addfLine("} %s__ref;", param.name)
        end
    end
    return api_data_t_lines:getContent()
end

local function get_args_values_lines(f)
    local get_args_values_line = Content:new(1)
    for _, param in pairs(f.fparam) do
        get_args_values_line:addfLine(
            "%s->%s_args.%s.%s = (%s%s)%s; \\",
            S:STRING("CB_API_DATA_VAR"), S:STRING("DOMAIN"), f.fname, param.name, param:get_cleaned_vtype(), string.rep("*", param.dyn_ref_cnt), param.name
        )
    end
    return get_args_values_line:getContent()
end

local function get_ptrs_values_content(fname, cvar_list)
    local get_ptrs_values_lines = Content:new(1)
    
    for _, cvar in pairs(cvar_list) do
        local var = string.format(
            "args->%s.%s", fname, cvar.name)
        local opened_if = 0

        for nb_ptr = 1, cvar.dyn_ref_cnt do
            local ref_suffix = nb_ptr == 1 and "" or "__ref.ptr" .. nb_ptr - 1

            if cvar.ctype ~= "void" then
                opened_if = opened_if + 1
                get_ptrs_values_lines:addfLine("if (%s%s != NULL) { \\", var, ref_suffix)
                get_ptrs_values_lines:increaseIndent()

                if nb_ptr == cvar.dyn_ref_cnt then
                    if cvar.ctype == "string" then
                        get_ptrs_values_lines:addfLine("strncpy(%s__ref.val, %s%s, %s-1); \\", var, var, ref_suffix, S:STRING("STRING_SIZE_MAX"))
                    else
                        get_ptrs_values_lines:addfLine("%s__ref.val = *%s%s; \\", var, var, ref_suffix)
                    end
                else
                    get_ptrs_values_lines:addfLine("%s__ref.ptr%d = (void*)*%s%s; \\", var, nb_ptr, var, ref_suffix)
                end
            elseif cvar.ctype == "void" and nb_ptr ~= cvar.dyn_ref_cnt then
                opened_if = opened_if + 1
                get_ptrs_values_lines:addfLine("if (%s%s != NULL) { \\", var, ref_suffix)
                get_ptrs_values_lines:increaseIndent()
                get_ptrs_values_lines:addfLine("%s__ref.ptr%d = (void*)*%s%s; \\", var, nb_ptr, var, ref_suffix)
            end
        end

        -- Close all opened if statements
        for _ = 1, opened_if do
            get_ptrs_values_lines:decreaseIndent()
            get_ptrs_values_lines:addLine("} \\")
        end
    end

    return get_ptrs_values_lines:getContent()
end


function intercepted_functions_h:generate_subcontents(f)
    self.subcontents.typedef_block:addfLine("typedef %s (*__%s_t)(%s);", f.ftype.vtype, f.fname, f.fdecl)

    -- API data type block
    self.subcontents.api_data_t_block:addfLine("\tstruct args_%s_t %s;", f.fname, f.fname)

    -- API ID enum block
    self.subcontents.api_id_enum_block:addfLine("%s%s,", S:STRING("IF_API_ID_PREFIX"), f.fname)

    -- Function prototype block
    self.subcontents.func_proto_block:addfLine("%s i_%s(%s);", f.ftype.vtype, f.fname, f.fdecl)

    -- Get function name block
    self.subcontents.get_funame_block:addfLine("case %s%s : return \"%s\";", S:STRING("IF_API_ID_PREFIX"), f.fname, f.fname)
    
    -- Get function address block
    self.subcontents.get_funaddr_block:addfLine("case %s%s : return i_%s;", S:STRING("IF_API_ID_PREFIX"), f.fname, f.fname)

    -- Get function ID block
    self.subcontents.get_funid_block:addfLine("else if (strcmp(name, \"%s\") == 0) return %s%s;", f.fname, S:STRING("IF_API_ID_PREFIX"), f.fname)
       

    -- Struct args data block
    local struct_args_block = Content:new()
    struct_args_block:addfLine("struct args_%s_t {", f.fname)
    struct_args_block:addfLine("%s", struct_args_line(common.get_function_signature(f)))
    struct_args_block:addLine("};\n")

    -- Get args value block
    local get_args_values_block = Content:new()
    local get_args_values_lines = get_args_values_lines(f)
    if get_args_values_lines ~= "" then
        get_args_values_block:addfLine("#define GET_ARGS_VALUE_%s(%s) { \\", f.fname, S:STRING("CB_API_DATA_VAR"))
        get_args_values_block:addLine(get_args_values_lines)
        get_args_values_block:addLine("};\n")
    end

    local get_ptrs_values_block = Content:new()
    local get_ptrs_values_lines = get_ptrs_values_content(f.fname, f.fparam)
    
    local get_ptrs_ret_values_block = Content:new()
    local get_ptrs_ret_values_lines = get_ptrs_values_content(f.fname, {f.ftype})

    if get_ptrs_values_lines ~= "" or get_ptrs_ret_values_lines ~= "" then


        if f.get_arg_after == true then
            self.subcontents.get_pointed_args_block_after:addfLine("case %s%s : ", S:STRING("IF_API_ID_PREFIX"), f.fname)
        elseif f.get_arg_before == true then
            self.subcontents.get_pointed_args_block_before:addfLine("case %s%s : ", S:STRING("IF_API_ID_PREFIX"), f.fname)
        end

        if get_ptrs_values_lines ~= "" then
            -- Get ptrs value block
            get_ptrs_values_block:addfLine("#define GET_PTRS_VALUE_%s(args) { \\", f.fname)
            get_ptrs_values_block:addLine(get_ptrs_values_lines)
            get_ptrs_values_block:addLine("};\n")
            
            -- Get pointed args block
            if f.get_arg_after == true then
                self.subcontents.get_pointed_args_block_after:addfLine("\tGET_PTRS_VALUE_%s(args);", f.fname)
            elseif f.get_arg_before == true then
                self.subcontents.get_pointed_args_block_before:addfLine("\tGET_PTRS_VALUE_%s(args);", f.fname)
            end
        end
        
        if get_ptrs_ret_values_lines ~= "" then
            -- Get ptrs value block
            get_ptrs_ret_values_block:addfLine("#define GET_PTRS_RET_VALUE_%s(args) { \\", f.fname)
            get_ptrs_ret_values_block:addLine(get_ptrs_ret_values_lines)
            get_ptrs_ret_values_block:addLine("};\n")
            
            -- Get pointed args block
            if f.get_arg_after == true then
                self.subcontents.get_pointed_args_block_after:addfLine("\tGET_PTRS_RET_VALUE_%s(args);", f.fname)
            elseif f.get_arg_before == true then
                self.subcontents.get_pointed_args_block_before:addfLine("\tGET_PTRS_RET_VALUE_%s(args);", f.fname)
            end
        end

        if f.get_arg_after == true then
            self.subcontents.get_pointed_args_block_after:addLine("\treturn;")
        elseif f.get_arg_before == true then
            self.subcontents.get_pointed_args_block_before:addLine("\treturn;")
        end
    end

    

    -- API args data block
    self.subcontents["args_data_block"]:addfLine("// %s", f.ftype.vtype)
    self.subcontents["args_data_block"]:addfLine("// %s (", f.fname)
    for _, p in pairs(f.fparam) do
        self.subcontents["args_data_block"]:addfLine("// \t\t%s %s (%s)", p.vtype, p.name, p.ctype)
    end  
    self.subcontents["args_data_block"]:addLine("// )")
    self.subcontents["args_data_block"]:addfLine("%s", struct_args_block:getContent())
    self.subcontents["args_data_block"]:addfLine("%s", get_args_values_block:getContent())
    self.subcontents["args_data_block"]:addfLine("%s\n", get_ptrs_values_block:getContent())
    self.subcontents["args_data_block"]:addfLine("%s\n", get_ptrs_ret_values_block:getContent())
end

return intercepted_functions_h, "DOMAIN"
