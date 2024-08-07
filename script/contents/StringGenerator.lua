StringGenerator = {}
StringGenerator.__index = StringGenerator

function StringGenerator.new(data)
    local self = setmetatable({}, StringGenerator)

    self.config_data = data

    self._WARNING_MSG = [[
/* # THIS FILE HAS BEEN AUTOMATICALLY GENERATED BY THE GILDA TOOL.
 * # DO NOT MODIFY UNLESS YOU KNOW WHAT YOU ARE DOING.
 * # ANY CHANGES MAY BE OVERWRITTEN BY SUBSEQUENT RUNS OF GILDA.
 */]]

    self._SAMPLE_MSG = [[
/* # THIS FILE IS A SAMPLE GENERATED ONLY ONCE DURING THE FIRST RUN OF GILDA.
 * # IT WILL NOT BE GENERATED AGAIN ON SUBSEQUENT RUNS OR IF THE GEN DIR ALREADY EXIST.
 * # YOU CAN USE THIS FILE AS A TEMPLATE AND MODIFY IT AS NEEDED.
 */]]
    self._SAMPLE_MSG_2 = [[
# THIS FILE IS A SAMPLE GENERATED ONLY ONCE DURING THE FIRST RUN OF GILDA.
# IT WILL NOT BE GENERATED AGAIN ON SUBSEQUENT RUNS OR IF THE GEN DIR ALREADY EXIST.
# YOU CAN USE THIS FILE AS A TEMPLATE AND MODIFY IT AS NEEDED.
]]
    
    self._CURRENT_DOMAIN = "NO_DOMAIN_SET"

    self._WORKDIR = os.getenv("PWD")

    -- Directories
    self._COREDIR = "core"
    self._LIBDIR = "lib"
    self._BUILDDIR = "build"
    self._AUTOGENDIR = "autogen"
    self._MANGENDIR = "mangen"
    self._UTILSDIR = "utils"
    self._TOOLSDIR = "tools"

    -- Files
    self._HANDLER_MGR = "handler_manager"
    self._ENV = "env"
    self._TOOL = "tool"
    self._LOGGER = "logger"
    self._CID = "correlation_id"

    -- Setup metatable for dynamic concatenation
    setmetatable(self, {
        __index = function(table, key)
            if key == "_GENDIR_NAME" then                   return self.config_data and self.config_data.gen_dir or "not set"
            -- Tools string
            elseif key == "_TOOLS_NAME" then                return self.config_data and self.config_data.tools_name or "not set"
            elseif key == "_TOOLS_NAME_VERB" then           return self.config_data and self.config_data.tools_name_verb or "not set"
            elseif key == "_TOOLS_NAME_ADJ" then            return self.config_data and self.config_data.tools_name_adj or "not set"
            elseif key == "_TOOLS_NAME_ABR" then            return self.config_data and self.config_data.tools_name_abr or "not set"
            elseif key == "_TOOLS_NAME_NOUN" then           return self.config_data and self.config_data.tools_name_noun or "not set"
            elseif key == "_TOOLS_NAME_GERUND" then         return self.config_data and self.config_data.tools_name_gerund or "not set"
            elseif key == "_TOOLS_NAME_UPPER" then          return string.upper(table._TOOLS_NAME)
            elseif key == "_TOOLS_NAME_UPPER_VERB" then     return string.upper(table._TOOLS_NAME_VERB)
            elseif key == "_TOOLS_NAME_UPPER_ADJ" then      return string.upper(table._TOOLS_NAME_ADJ)
            elseif key == "_TOOLS_NAME_UPPER_ABR" then      return string.upper(table._TOOLS_NAME_ABR)
            elseif key == "_TOOLS_NAME_UPPER_NOUN" then     return string.upper(table._TOOLS_NAME_NOUN)
            elseif key == "_TOOLS_NAME_UPPER_GERUND" then   return string.upper(table._TOOLS_NAME_GERUND)
            -- Directory string
            elseif key == "_GENDIR" then                    return table._GENDIR_NAME.."/"..table._TOOLS_NAME
            elseif key == "_COREDIR_PATH" then              return table._GENDIR.."/"..table._COREDIR
            elseif key == "_TOOLSDIR_PATH" then             return table._COREDIR_PATH.."/"..table._TOOLSDIR
            elseif key == "_BUILDDIR_PATH" then             return table._COREDIR_PATH.."/"..table._BUILDDIR
            elseif key == "_AUTOGENDIR_PATH" then           return table._COREDIR_PATH.."/"..table._AUTOGENDIR
            elseif key == "_MANGENDIR_PATH" then            return table._COREDIR_PATH.."/"..table._MANGENDIR
            elseif key == "_UTILSDIR_PATH" then             return table._COREDIR_PATH.."/"..table._UTILSDIR
            -- Makefile and script path
            elseif key == "_MAKEFILE_PATH" then             return table._GENDIR.."/Makefile"
            elseif key == "_SCRIPT_PATH" then               return table._GENDIR.."/"..table._TOOLS_NAME..".sh"
            -- Domain string
            elseif key == "_DOMAIN" then                    return table._CURRENT_DOMAIN
            elseif key == "_DOMAIN_UPPER" then              return string.upper(table._CURRENT_DOMAIN)
            elseif key == "_DOMAIN_ID" then                 return table._TOOLS_NAME_UPPER.."_DOMAIN_"..table._DOMAIN_UPPER
            -- Tool source and path
            elseif key == "_TOOL_SRC" then                  return table._TOOL..".c"
            elseif key == "_TOOL_SRC_PATH" then             return table._TOOLSDIR_PATH.."/"..table._TOOL_SRC
            -- Interceptor source and path
            elseif key == "_INTERCEPTOR_SRC" then           return table._TOOLS_NAME..".c"
            elseif key == "_INTERCEPTOR_HEAD" then          return table._TOOLS_NAME..".h"
            elseif key == "_INTERCEPTOR_SRC_PATH" then      return table._COREDIR_PATH.."/"..table._INTERCEPTOR_SRC
            elseif key == "_INTERCEPTOR_HEAD_PATH" then     return table._COREDIR_PATH.."/"..table._INTERCEPTOR_HEAD
            -- Env source and path
            elseif key == "_ENV_SRC" then                   return table._ENV..".c"
            elseif key == "_ENV_HEAD" then                  return table._ENV..".h"
            elseif key == "_ENV_SRC_PATH" then              return table._UTILSDIR_PATH.."/"..table._ENV_SRC
            elseif key == "_ENV_HEAD_PATH" then             return table._UTILSDIR_PATH.."/"..table._ENV_HEAD
            -- Logger source and path
            elseif key == "_LOGGER_SRC" then                return table._LOGGER..".c"
            elseif key == "_LOGGER_HEAD" then               return table._LOGGER..".h"
            elseif key == "_LOGGER_SRC_PATH" then           return table._UTILSDIR_PATH.."/"..table._LOGGER_SRC
            elseif key == "_LOGGER_HEAD_PATH" then          return table._UTILSDIR_PATH.."/"..table._LOGGER_HEAD
            -- Handler manager source and path
            elseif key == "_HANDLER_MGR_SRC" then           return table._HANDLER_MGR..".c"             
            elseif key == "_HANDLER_MGR_HEAD" then          return table._HANDLER_MGR..".h"             
            elseif key == "_HANDLER_MGR_SRC_PATH" then      return table._UTILSDIR_PATH.."/"..table._HANDLER_MGR_SRC
            elseif key == "_HANDLER_MGR_HEAD_PATH" then     return table._UTILSDIR_PATH.."/"..table._HANDLER_MGR_HEAD
            -- Domain directories
            elseif key == "_DOMAIN_DIR" then                return table._CURRENT_DOMAIN.."_"..table._TOOLS_NAME
            elseif key == "_AUTOGEN_DOMAIN_DIR" then        return table._AUTOGENDIR_PATH.."/"..table._DOMAIN_DIR
            elseif key == "_MANGEN_DOMAIN_DIR" then         return table._MANGENDIR_PATH.."/"..table._DOMAIN_DIR
            -- Var and types strings
            elseif key == "_API_ID_T" then                  return table._CURRENT_DOMAIN.."_api_id_t"
            elseif key == "_API_ID_PREFIX" then             return table._DOMAIN_UPPER.."_API_ID_"
            elseif key == "_API_DATA_S" then                return table._TOOLS_NAME.."_"..table._CURRENT_DOMAIN.."_api_activity_s"
            elseif key == "_API_DATA_T" then                return table._TOOLS_NAME.."_"..table._CURRENT_DOMAIN.."_api_activity_t"
            elseif key == "_API_ARGS_S" then                return table._CURRENT_DOMAIN.."_api_args_s"
            elseif key == "_API_ARGS_T" then                return table._CURRENT_DOMAIN.."_api_args_t"
            elseif key == "_API_DATA_VAR" then              return "__"..table._CURRENT_DOMAIN.."_data__"
            elseif key == "_INTERCEPT_TABLE_T" then         return table._CURRENT_DOMAIN.."_api_table_t"
            elseif key == "_INTERCEPT_TABLE_VAR" then       return table._CURRENT_DOMAIN.."_api_table"
            -- Api table manager source and path
            elseif key == "_ATM" then                       return table._CURRENT_DOMAIN.."_api_table_mgr"
            elseif key == "_ATM_SRC" then                   return table._ATM..".c"
            elseif key == "_ATM_HEAD" then                  return table._ATM..".h"
            elseif key == "_ATM_SRC_PATH" then              return table._AUTOGEN_DOMAIN_DIR .. "/" .. table._ATM_SRC
            elseif key == "_ATM_HEAD_PATH" then             return table._AUTOGEN_DOMAIN_DIR .. "/" .. table._ATM_HEAD
            -- Api table manager functions string
            elseif key == "_ATM_ENABLE_DOMAIN_FUNC" then    return "enable_"..table._CURRENT_DOMAIN.."_api_domain"
            elseif key == "_ATM_DISABLE_DOMAIN_FUNC" then   return "disable_"..table._CURRENT_DOMAIN.."_api_domain"
            elseif key == "_ATM_LOAD_TABLE_FUNC" then       return "load_"..table._CURRENT_DOMAIN.."_api_table"
            -- Functions source and path
            elseif key == "_F" then                         return table._CURRENT_DOMAIN.."_functions"
            elseif key == "_F_SRC" then                     return table._F..".c"
            elseif key == "_F_HEAD" then                    return table._F..".h"
            elseif key == "_F_MAN_SRC_PATH" then            return table._MANGEN_DOMAIN_DIR .. "/" .. table._F_SRC
            elseif key == "_F_AUTO_SRC_PATH" then           return table._AUTOGEN_DOMAIN_DIR .. "/" .. table._F_SRC
            elseif key == "_F_HEAD_PATH" then               return table._AUTOGEN_DOMAIN_DIR .. "/" .. table._F_HEAD
            -- Intercepted Functions source and path
            elseif key == "_IF" then                        return table._CURRENT_DOMAIN.."_"..table._TOOLS_NAME_ADJ.."_functions"
            elseif key == "_IF_SRC" then                    return table._IF..".c"
            elseif key == "_IF_HEAD" then                   return table._IF..".h"
            elseif key == "_IF_SRC_PATH" then               return table._AUTOGEN_DOMAIN_DIR .. "/" .. table._IF_SRC
            elseif key == "_IF_HEAD_PATH" then              return table._AUTOGEN_DOMAIN_DIR .. "/" .. table._IF_HEAD
            -- Correlation ID source and path
            elseif key == "_CID_SRC" then                    return table._CID..".c"
            elseif key == "_CID_HEAD" then                   return table._CID..".h"
            elseif key == "_CID_SRC_PATH" then               return table._UTILSDIR_PATH .. "/" .. table._CID_SRC
            elseif key == "_CID_HEAD_PATH" then              return table._UTILSDIR_PATH .. "/" .. table._CID_HEAD
            -- Callback source and path
            elseif key == "_CB" then                        return table._CURRENT_DOMAIN.."_callback"
            elseif key == "_CB_SRC" then                    return table._CB..".c"
            elseif key == "_CB_HEAD" then                   return table._CB..".h"
            elseif key == "_CB_SRC_PATH" then               return table._AUTOGEN_DOMAIN_DIR .. "/" .. table._CB_SRC
            elseif key == "_CB_HEAD_PATH" then              return table._AUTOGEN_DOMAIN_DIR .. "/" .. table._CB_HEAD
            -- Callback function and var string
            elseif key == "_CALLBACK" then                  return table._CURRENT_DOMAIN.."_callback"
            elseif key == "_SET_CALLBACK" then              return "set_"..table._CURRENT_DOMAIN.."_"..table._TOOLS_NAME_VERB.."_callback"
            elseif key == "_CB_ARGS" then                   return "bool is_enter, "..table._API_DATA_T.."* activity"
            elseif key == "_CALLBACK_FUNCTION" then         return table._CURRENT_DOMAIN.."_callback_function"
            else
                return rawget(table, key)
            end
        end
    })

    return self
end

return StringGenerator
