local interceptor_build = {}

function interceptor_build.command(config_data, interceptors, opt)
    local INC = ""
    local all = ""
    if opt.all == true then
        all = " -B "
    end
    for _, interceptor_name in ipairs(interceptors) do
        local interceptor_data = config_data[interceptor_name]
        if interceptor_data == nil then
            print("Warning: Skipping "..interceptor_name..", doesn't exist in config file")
        elseif interceptor_data.input_csv == "" or interceptor_data.lib == "" then
            print("Warning: Skipping "..interceptor_name..", config file not complete")
        else
            INC = INC.." -I"..interceptor_data.include_path
        end                  
    end
    os.execute("make libinterceptor.so -C "..GENDIR..all.." INC=\""..INC.."\"")
end

return interceptor_build
