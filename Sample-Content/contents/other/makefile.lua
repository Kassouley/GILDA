local ContentManager = require("ContentManager")
local Content = require("Content")

local finalize_subcontent = function(arg) 
    return arg:getContent()
end

local f = ContentManager:new({path = S._MAKEFILE_PATH, do_gen = false, finalize_callback = finalize_subcontent})

function f:generate_content()
    return S._SAMPLE_MSG_2..[[ 

# Directories
CORE_DIR = ]]..S._COREDIR..[[

BUILD_DIR = ]]..S._BUILDDIR..[[

LIB_DIR = ]]..S._LIBDIR..[[


# Libraries
LIB]]..S._TOOLS_NAME_UPPER..[[ = lib]]..S._TOOLS_NAME..[[.so

# Compiler and flags
CC 			= hipcc
CXX			= hipcc
CFLAGS 		= -fPIC -Wall $(INC_FLAGS) -Wno-uninitialized -Wno-deprecated-declarations 
]]..self.subcontents.compile_flag..[[ 
LDFLAGS		= -shared
INC_DIRS   := $(shell find $(CORE_DIR) -type d)
INC_FLAGS  := $(addprefix -I,$(INC_DIRS)) -I$(CORE_DIR) 
]]..self.subcontents.include_flag..[[ 


# Source files
C_SOURCES = $(shell find $(CORE_DIR) -name '*.c')
CPP_SOURCES = $(shell find $(CORE_DIR) -name '*.cpp')

# Generate corresponding object files paths in the build directory
OBJECTS = $(C_SOURCES:$(CORE_DIR)/%.c=$(BUILD_DIR)/%.o)
OBJECTS += $(CPP_SOURCES:$(CORE_DIR)/%.cpp=$(BUILD_DIR)/%.o)

# Default target
all: $(LIB]]..S._TOOLS_NAME_UPPER..[[)

# Rule to compile .c files to .o
$(BUILD_DIR)/%.o: $(CORE_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to compile .cpp files to .o
$(BUILD_DIR)/%.o: $(CORE_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to create lib]]..S._TOOLS_NAME..[[.so
$(LIB]]..S._TOOLS_NAME_UPPER..[[): $(OBJECTS)
	@mkdir -p $(LIB_DIR)
	$(CC) $(LDFLAGS) -o $(LIB_DIR)/$@ $^ 

# Debug target
debug: CFLAGS += $(DEBUG_FLAGS)
debug: CFLAGS += -g 
debug: clean $(LIB]]..S._TOOLS_NAME_UPPER..[[)

# Clean up build artifacts
clean:
	rm -rf $(BUILD_DIR) $(LIB_DIR)/$(LIB]]..S._TOOLS_NAME_UPPER..[[)

.PHONY: all clean
]]
end


f:init_subcontent("compile_flag", Content:new())
f:init_subcontent("include_flag", Content:new())

function f:generate_subcontents(data)
	if data.compile_flag ~= "" then
    	self.subcontents["compile_flag"]:addfLine("CFLAGS     += %s", data.compile_flag)
	end
    self.subcontents["include_flag"]:addfLine("INC_FLAGS  += -I%s", data.include_path)
end


return {f=f}