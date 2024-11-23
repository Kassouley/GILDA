local ContentManager = require("ContentManager")
local Content = require("Content")

functions_c = setmetatable({}, ContentManager)
functions_c.__index = functions_c

function functions_c:new(_, template_path, output_path)
    local attribute = {
        file_name = S:STRING("DOMAIN").."_wrapper/"..S:STRING("F_SRC"),
        subcontents = {
            ["func_blk"] = Content:new()
        } 
    }
    local instance = ContentManager:new(attribute, template_path, output_path)
    setmetatable(instance, functions_c)
    return instance
end

function functions_c:generate_content()
    local content = Content:new()
    content:addfLine("%s\n", S:STRING("WARNING_MSG"))
    content:addfLine("#include \"%s\"", S:STRING("INTERCEPTOR_HDR"))
    content:addfLine("%s\n", S:STRING("INCLUDE_STR"))
    content:addfLine("%s\n", self.subcontents.func_blk:getContent())
    return content:getContent()
end

function functions_c:generate_subcontents(f)
    local return_stmt = (f.ftype.ctype ~= "void" or f.ftype:is_generic_ptr()) and "return " or ""
    self.subcontents["func_blk"]:addfLine("%s %s(%s) {", f.ftype.vtype, f.fname, f.fdecl)
    self.subcontents["func_blk"]:addfLine("\t%s((__%s_t)%s.api_ptr[%s%s])(%s);", return_stmt, f.fname, S:STRING("DOMAIN_API_TABLE_VAR"), S:STRING("IF_API_ID_PREFIX"), f.fname, f.fargs)
    self.subcontents["func_blk"]:addLine("};\n")
end

return functions_c, "DOMAIN"
