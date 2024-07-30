StringGenerator = {}
StringGenerator.__index = StringGenerator

function StringGenerator.new(config_data)
    local self = setmetatable({}, StringGenerator)

    self._TOOLS_NAME = config_data.tools_name
    self._TOOLS_NAME_VERB = config_data.tools_name_verb
    self._TOOLS_NAME_ADJ = config_data.tools_name_adj
    self._TOOLS_NAME_ABR = config_data.tools_name_abr
    self._TOOLS_NAME_NOUN = config_data.tools_name_noun
    
    self._TOOLS_NAME_UPPER = string.upper(self._TOOLS_NAME)
    self._TOOLS_NAME_UPPER_VERB = string.upper(self._TOOLS_NAME_VERB)
    self._TOOLS_NAME_UPPER_ADJ = string.upper(self._TOOLS_NAME_ADJ)

    self._CURRENT_DOMAIN = "NO_DOMAIN_SET"

    self._WORKDIR = os.getenv("PWD")
    self._GENDIR = self._WORKDIR.."/gen/"..self._TOOLS_NAME
    self._COREDIR = "core"
    self._LIBDIR = "lib"
    self._BUILDDIR = "build"
    self._AUTOGENDIR = "autogen"
    self._MANGENDIR = "mangen"
    self._UTILSDIR = "utils"
    self._TOOLSDIR = "tools"
    self._MAKEFILE_PATH = self._GENDIR.."/Makefile"
    self._SCRIPT_PATH = self._GENDIR.."/"..self._TOOLS_NAME..".sh"

    self._HANDLER_MGR = "handler_manager"
    self._ENV = "env"
    self._TOOL = "tool"
    self._LOGGER = "logger"

    return self
end

-- DIR STRING
function StringGenerator:_COREDIR_PATH()
    return self._GENDIR.."/"..self._COREDIR
end
function StringGenerator:_TOOLSDIR_PATH()
    return self:_COREDIR_PATH().."/"..self._TOOLSDIR
end
function StringGenerator:_BUILDDIR_PATH()
    return self:_COREDIR_PATH().."/"..self._BUILDDIR
end
function StringGenerator:_AUTOGENDIR_PATH()
    return self:_COREDIR_PATH().."/"..self._AUTOGENDIR
end
function StringGenerator:_MANGENDIR_PATH()
    return self:_COREDIR_PATH().."/"..self._MANGENDIR
end
function StringGenerator:_UTILSDIR_PATH()
    return self:_COREDIR_PATH().."/"..self._UTILSDIR
end
function StringGenerator:_TOOLSDIR_PATH()
    return self:_COREDIR_PATH().."/"..self._TOOLSDIR
end

-- DOMAIN STRING
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
function StringGenerator:_TOOL_SRC()
    return self._TOOL..".c"
end
function StringGenerator:_TOOL_SRC_PATH()
    return self:_TOOLSDIR_PATH().."/"..self:_TOOL_SRC()
end

-- INTERCEPTOR FILE STRING
function StringGenerator:_INTERCEPTOR_SRC()
    return self._TOOLS_NAME..".c"
end
function StringGenerator:_INTERCEPTOR_HEAD()
    return self._TOOLS_NAME..".h"
end
function StringGenerator:_INTERCEPTOR_SRC_PATH()
    return self:_COREDIR_PATH().."/"..self:_INTERCEPTOR_SRC()
end
function StringGenerator:_INTERCEPTOR_HEAD_PATH()
    return self:_COREDIR_PATH().."/"..self:_INTERCEPTOR_HEAD()
end

-- ENV FILE STRING
function StringGenerator:_ENV_SRC()
    return self._ENV..".c"
end
function StringGenerator:_ENV_HEAD()
    return self._ENV..".h"
end
function StringGenerator:_ENV_SRC_PATH()
    return self:_UTILSDIR_PATH().."/"..self:_ENV_SRC()
end
function StringGenerator:_ENV_HEAD_PATH()
    return self:_UTILSDIR_PATH().."/"..self:_ENV_HEAD()
end

-- LOGGER FILE STRING
function StringGenerator:_LOGGER_SRC()
    return self._LOGGER..".c"
end
function StringGenerator:_LOGGER_HEAD()
    return self._LOGGER..".h"
end
function StringGenerator:_LOGGER_SRC_PATH()
    return self:_UTILSDIR_PATH().."/"..self:_LOGGER_SRC()
end
function StringGenerator:_LOGGER_HEAD_PATH()
    return self:_UTILSDIR_PATH().."/"..self:_LOGGER_HEAD()
end

-- HANDLER MGR FILE STRING
function StringGenerator:_HANDLER_MGR_SRC()
    return self._HANDLER_MGR..".c"
end
function StringGenerator:_HANDLER_MGR_HEAD()
    return self._HANDLER_MGR..".h"
end
function StringGenerator:_HANDLER_MGR_SRC_PATH()
    return self:_UTILSDIR_PATH().."/"..self:_HANDLER_MGR_SRC()
end
function StringGenerator:_HANDLER_MGR_HEAD_PATH()
    return self:_UTILSDIR_PATH().."/"..self:_HANDLER_MGR_HEAD()
end

-- DOMAIN API FILE STRING
function StringGenerator:_DOMAIN_DIR()
    return self._CURRENT_DOMAIN.."_"..self._TOOLS_NAME
end
function StringGenerator:_AUTOGEN_DOMAIN_DIR()
    return self:_AUTOGENDIR_PATH().."/"..self:_DOMAIN_DIR()
end
function StringGenerator:_MANGEN_DOMAIN_DIR()
    return self:_MANGENDIR_PATH().."/"..self:_DOMAIN_DIR()
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
function StringGenerator:_ATM()
    return self._CURRENT_DOMAIN.."_api_table_mgr"
end
function StringGenerator:_ATM_SRC()
    return self:_ATM()..".c"
end
function StringGenerator:_ATM_HEAD()
    return self:_ATM()..".h"
end
function StringGenerator:_ATM_SRC_PATH()
    return self:_AUTOGEN_DOMAIN_DIR() .. "/" .. self:_ATM_SRC()
end
function StringGenerator:_ATM_HEAD_PATH()
    return self:_AUTOGEN_DOMAIN_DIR() .. "/" .. self:_ATM_HEAD()
end

function StringGenerator:_ATM_ENABLE_DOMAIN_FUNC()
    return "enable_"..self._CURRENT_DOMAIN.."_api_domain"
end
function StringGenerator:_ATM_DISABLE_DOMAIN_FUNC()
    return "disable_"..self._CURRENT_DOMAIN.."_api_domain"
end
function StringGenerator:_ATM_LOAD_TABLE_FUNC()
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
function StringGenerator:_F_MAN_SRC_PATH()
    return self:_MANGEN_DOMAIN_DIR() .. "/" .. self:_F_SRC()
end
function StringGenerator:_F_AUTO_SRC_PATH()
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
function StringGenerator:_IF_SRC_PATH()
    return self:_AUTOGEN_DOMAIN_DIR() .. "/" .. self:_IF_SRC()
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


