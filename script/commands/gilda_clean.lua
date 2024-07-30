local interceptor_clean = {}

function interceptor_clean.command(directory, interceptors, opt)
    local force = ""
    if opt.force == true then
        force = "-f "
    end
    -- self._WORKDIR.."/gen/"..directory
    if #interceptors == 0 then
        os.execute("rm -ir "..force..S._AUTOGENDIR)
        if opt.all == true then
            os.execute("rm -ir "..force..S._MANGENDIR)
        end
    else
        for _, interceptor_name in ipairs(interceptors) do
            os.execute("rm -ir "..force..S._AUTOGEN_DOMAIN_DIR)
            if opt.all == true then
                os.execute("rm -ir "..force..S._MANGEN_DOMAIN_DIR)
            end
        end
    end
end

return interceptor_clean
