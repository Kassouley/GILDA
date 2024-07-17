local interceptor_build = {}

function interceptor_build.command(config_data, interceptors)
    for _, interceptor_name in ipairs(interceptors) do
        local interceptor_data = config_data[interceptor_name]
        if interceptor_data == nil then
            print("Warning: Skipping "..interceptor_name..", doesn't exist in config file")
        else
            local INC = "-I"..interceptor_data.include_path
            local CFLAGS = "-I"..interceptor_data.include_path..
                          " -I"..AUTOGENDIR.."/"..interceptor_name.."_interceptor"..
                          " -I"..MANGENDIR.."/"..interceptor_name.."_interceptor"..
                          " -I"..COREDIR
            print("make libinterceptor.so -B -C "..GENDIR.." INC="..INC)
            os.execute("make libinterceptor.so -B -C "..GENDIR.." INC="..INC)
        end                  
    end
end

return interceptor_build
