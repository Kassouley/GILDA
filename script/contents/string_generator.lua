StringGenerator = {}
StringGenerator.__index = StringGenerator

function StringGenerator.new(config_data)
    local self = setmetatable({}, StringGenerator)

    self._TOOLS_NAME = config_data.tools_name
    self._TOOLS_NAME_VERB = config_data.tools_name_verb
    self._TOOLS_NAME_ADJ = config_data.tools_name_adj
    
    self._TOOLS_NAME_UPPER = string.upper(self._TOOLS_NAME)
    self._TOOLS_NAME_UPPER_VERB = string.upper(self._TOOLS_NAME_VERB)
    self._TOOLS_NAME_UPPER_ADJ = string.upper(self._TOOLS_NAME_ADJ)
    self._FUNCTION_FILTER = self._TOOLS_NAME_UPPER.."_FUNCTION_FILTER"

    self._CURRENT_DOMAIN = ""

    self._WORKDIR = os.getenv("PWD")
    self._GENDIR = self._WORKDIR.."/gen/"..self._TOOLS_NAME
    self._COREDIR = self._GENDIR.."/core"
    self._LIBDIR = self._GENDIR.."/lib"
    self._BUILDDIR = self._GENDIR.."/build"
    self._AUTOGENDIR = self._COREDIR.."/autogen"
    self._MANGENDIR = self._COREDIR.."/mangen"
    self._UTILSDIR = self._COREDIR.."/utils"
    self._TOOLSDIR = self._COREDIR.."/tools"

    self._HANDLER_MGR = "handler_manager"
    self._ENV = "env"
    self._TOOL = "tool"
    self._LOGGER = "logger"

    return self
end
function StringGenerator:_DOMAIN()
    return self._CURRENT_DOMAIN
end
function StringGenerator:_DOMAIN_UPPER()
    return string.upper(self._CURRENT_DOMAIN)
end
function StringGenerator:_DOMAIN_ID()
    return S._TOOLS_NAME_UPPER.."_DOMAIN_"..self:_DOMAIN_UPPER()
end

-- TOOLS FILE STRING
function StringGenerator:_INTERCEPTOR_SRC()
    return self._TOOLS_NAME..".c"
end
function StringGenerator:_INTERCEPTOR_HEAD()
    return self._TOOLS_NAME..".h"
end
function StringGenerator:_INTERCEPTOR_SRC_PATH()
    return self._TOOLSDIR.."/"..self:_INTERCEPTOR_SRC()
end
function StringGenerator:_INTERCEPTOR_HEAD_PATH()
    return self._TOOLSDIR.."/"..self:_INTERCEPTOR_HEAD()
end

-- ENV FILE STRING
function StringGenerator:_ENV_SRC()
    return self._ENV..".c"
end
function StringGenerator:_ENV_HEAD()
    return self._ENV..".h"
end
function StringGenerator:_ENV_SRC_PATH()
    return self._UTILSDIR.."/"..self:_ENV_SRC()
end
function StringGenerator:_ENV_HEAD_PATH()
    return self._UTILSDIR.."/"..self:_ENV_HEAD()
end

-- LOGGER FILE STRING
function StringGenerator:_LOGGER_SRC()
    return self._LOGGER..".c"
end
function StringGenerator:_LOGGER_HEAD()
    return self._LOGGER..".h"
end
function StringGenerator:_LOGGER_SRC_PATH()
    return self._UTILSDIR.."/"..self:_LOGGER_SRC()
end
function StringGenerator:_LOGGER_HEAD_PATH()
    return self._UTILSDIR.."/"..self:_LOGGER_HEAD()
end

-- HANDLER MGR FILE STRING
function StringGenerator:_HANDLER_MGR_SRC()
    return self._HANDLER_MGR..".c"
end
function StringGenerator:_HANDLER_MGR_HEAD()
    return self._HANDLER_MGR..".h"
end
function StringGenerator:_HANDLER_MGR_SRC_PATH()
    return self._UTILSDIR.."/"..self:_HANDLER_MGR_SRC()
end
function StringGenerator:_HANDLER_MGR_HEAD_PATH()
    return self._UTILSDIR.."/"..self:_HANDLER_MGR_HEAD()
end

-- DOMAIN API FILE STRING
function StringGenerator:_DOMAIN_DIR()
    return self._CURRENT_DOMAIN.."_"..self._TOOLS_NAME
end
function StringGenerator:_AUTOGEN_DOMAIN_DIR()
    return self._AUTOGENDIR.."/"..self:_DOMAIN_DIR()
end
function StringGenerator:_MANGEN_DOMAIN_DIR()
    return self._MANGENDIR.."/"..self:_DOMAIN_DIR()
end

-- STRUCT AND VAR STRING
function StringGenerator:_API_ID_T()
    return self._CURRENT_DOMAIN.."_api_id_t"
end
function StringGenerator:_API_ID_PREFIX()
    return self:_DOMAIN_UPPER().."_API_ID_"
end
function StringGenerator:_API_DATA_S()
    return self._CURRENT_DOMAIN.."_api_data_s"
end
function StringGenerator:_API_DATA_T()
    return self._CURRENT_DOMAIN.."_api_data_t"
end
function StringGenerator:_API_DATA_VAR()
    return "__"..self._CURRENT_DOMAIN.."_data__"
end

function StringGenerator:_INTERCEPT_TABLE_T()
    return self._CURRENT_DOMAIN.."_api_table_t"
end
function StringGenerator:_INTERCEPT_TABLE_VAR()
    return self._CURRENT_DOMAIN.."_api_table"
end

-- INTERCEPT TABLE MANAGER FILE STRING
function StringGenerator:_ITM()
    return self._CURRENT_DOMAIN.."_api_table_mgr"
end
function StringGenerator:_ITM_SRC()
    return self:_ITM()..".c"
end
function StringGenerator:_ITM_HEAD()
    return self:_ITM()..".h"
end
function StringGenerator:_ITM_SRC_PATH()
    return self:_AUTOGEN_DOMAIN_DIR() .. "/" .. self:_ITM_SRC()
end
function StringGenerator:_ITM_HEAD_PATH()
    return self:_AUTOGEN_DOMAIN_DIR() .. "/" .. self:_ITM_HEAD()
end

function StringGenerator:_ITM_ENABLE_DOMAIN_FUNC()
    return "enable_"..self._CURRENT_DOMAIN.."_api_domain"
end
function StringGenerator:_ITM_DISABLE_DOMAIN_FUNC()
    return "disable_"..self._CURRENT_DOMAIN.."_api_domain"
end
function StringGenerator:_ITM_LOAD_TABLE_FUNC()
    return "load_"..self._CURRENT_DOMAIN.."_api_table"
end

-- FUNCTIONS FILE STRING
function StringGenerator:_F()
    return self._CURRENT_DOMAIN.."_functions"
end
function StringGenerator:_F_SRC()
    return self:_F()..".c"
end
function StringGenerator:_F_HEAD()
    return self:_F()..".h"
end
function StringGenerator:_F_SRC_PATH()
    return self:_AUTOGEN_DOMAIN_DIR() .. "/" .. self:_F_SRC()
end
function StringGenerator:_F_HEAD_PATH()
    return self:_AUTOGEN_DOMAIN_DIR() .. "/" .. self:_F_HEAD()
end

-- INTERCEPTED FUNCTIONS FILE STRING
function StringGenerator:_IF()
    return self._CURRENT_DOMAIN.."_"..self._TOOLS_NAME_ADJ.."_functions"
end
function StringGenerator:_IF_SRC()
    return self:_IF()..".c"
end
function StringGenerator:_IF_HEAD()
    return self:_IF()..".h"
end
function StringGenerator:_IF_AUTO_SRC_PATH()
    return self:_AUTOGEN_DOMAIN_DIR() .. "/" .. self:_IF_SRC()
end
function StringGenerator:_IF_MAN_SRC_PATH()
    return self:_MANGEN_DOMAIN_DIR() .. "/" .. self:_IF_SRC()
end
function StringGenerator:_IF_HEAD_PATH()
    return self:_AUTOGEN_DOMAIN_DIR() .. "/" .. self:_IF_HEAD()
end

-- CALLBACK FILE STRING
function StringGenerator:_CB()
    return self._CURRENT_DOMAIN.."_callback"
end
function StringGenerator:_CB_SRC()
    return self:_CB()..".c"
end
function StringGenerator:_CB_HEAD()
    return self:_CB()..".h"
end
function StringGenerator:_CB_SRC_PATH()
    return self:_AUTOGEN_DOMAIN_DIR() .. "/" .. self:_CB_SRC()
end
function StringGenerator:_CB_HEAD_PATH()
    return self:_AUTOGEN_DOMAIN_DIR() .. "/" .. self:_CB_HEAD()
end

function StringGenerator:_CALLBACK()
    return self._CURRENT_DOMAIN.."_callback"
end
function StringGenerator:_SET_CALLBACK()
    return "set_"..self._CURRENT_DOMAIN.."_"..self._TOOLS_NAME_VERB.."_callback"
end
function StringGenerator:_CB_ARGS()
    return "bool is_enter, "..self:_API_ID_T().." func_id, "..self:_API_DATA_T().." data"
end
function StringGenerator:_CALLBACK_FUNCTION()
    return self._CURRENT_DOMAIN.."_callback_function"
end

return StringGenerator


