local cb_hdr = {}

function cb_hdr.content_1(MACRO_STRING, includes_str)
    return "#ifndef "..MACRO_STRING._CB_HEADDEF.."\n"..
           "#define "..MACRO_STRING._CB_HEADDEF.."\n\n"..
           includes_str..
           "void "..MACRO_STRING._CB_FUNC_DECL.."("..MACRO_STRING._CB_ARGS..");\n"..
           "void "..MACRO_STRING._SET_CB_DECL.."(void (*"..MACRO_STRING._CB_DECL..")("..MACRO_STRING._CB_ARGS.."));\n\n"
end

function cb_hdr.content_2(MACRO_STRING, f)
    return "#define "..MACRO_STRING._CB_GET_ARGS_PREFIX..f.name.."(data) { \\\n"
end

function cb_hdr.content_3(MACRO_STRING, name, arg, arg_type)
    return "\tdata.args."..name.."."..arg.." = ("..arg_type..")"..arg.."; \\\n"
end

function cb_hdr.content_4()
    return "};\n\n"
end

function cb_hdr.content_5()
    return "#endif"
end

return cb_hdr