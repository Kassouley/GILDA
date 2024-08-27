local ContentManager = require("ContentManager")
local Content = require("Content")
local common = require("common")

local function finalize_subcontent(arg) 
    return arg:getContent()
end

local src_auto = ContentManager:new({path = S._F_AUTO_SRC_PATH, do_gen = true, finalize_callback = finalize_subcontent})
local src_man = ContentManager:new({path = S._F_MAN_SRC_PATH, do_gen = false, finalize_callback = finalize_subcontent})

-----------------------------
-- SOURCE CONTENT
-----------------------------

local function generate_content(self, data)
    local content = Content:new()
    content:addfLine("%s\n", S._WARNING_MSG)
    content:addfLine("#include \"%s\"", S._ATM_HDR)
    content:addfLine("%s\n", data.include)
    content:addfLine("extern %s %s;\n", S._ATM_INTERCEPT_TABLE_T, S._ATM_INTERCEPT_TABLE_VAR)
    content:addfLine("%s\n", self.subcontents.func_blk)
    return content:getContent()
end

function src_auto:generate_content(data) return generate_content(self, data) end
function src_man:generate_content(data) return generate_content(self, data) end

-----------------------------
-- SOURCE SUBCONTENT
-----------------------------

src_auto:init_subcontent("func_blk", Content:new())
src_man:init_subcontent("func_blk", Content:new())

function src_man:generate_subcontents(f, concat_param, _)
    local concat_pname = table.concat(f.pname, ", ")
    local return_stmt = ftype ~= "void" and "return " or ""
    if f.gen == "MANGEN" then
        self.subcontents["func_blk"]:addfLine("%s %s(%s) {", f.ftype, f.fname, concat_param) 
        self.subcontents["func_blk"]:addfLine("\t%s%s.ptr_%s(%s);", return_stmt, S._ATM_INTERCEPT_TABLE_VAR, f.fname, concat_pname)
        self.subcontents["func_blk"]:addLine("};\n")
    end
end

function src_auto:generate_subcontents(f, concat_param, _)
    local concat_pname = table.concat(f.pname, ", ")
    local return_stmt = ftype ~= "void" and "return " or ""
    if f.gen == "AUTOGEN" then
        self.subcontents["func_blk"]:addfLine("%s %s(%s) {", f.ftype, f.fname, concat_param) 
        self.subcontents["func_blk"]:addfLine("\t%s%s.ptr_%s(%s);", return_stmt, S._ATM_INTERCEPT_TABLE_VAR, f.fname, concat_pname)
        self.subcontents["func_blk"]:addLine("};\n")
    end
end


return {auto=src_auto, man=src_man}
