local interceptor_clean = {}

function interceptor_clean.command(interceptors)
    if #interceptors == 0 then
        os.execute("rm -ir "..AUTOGENDIR)
    else
        for _, interceptor_name in ipairs(interceptors) do
            os.execute("rm -ir "..AUTOGENDIR.."/"..interceptor_name.."_interceptor")
            -- os.execute("rm -irf "..MANGENDIR.."/"..interceptor_name.."_interceptor")
        end
    end
end

return interceptor_clean
