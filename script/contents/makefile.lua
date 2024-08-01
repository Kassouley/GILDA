local makefile = {}

function makefile.content(subcontent)
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
CFLAGS 		= -fPIC -Wall $(INC_FLAGS) -Wno-uninitialized -Wno-deprecated-declarations ]]..subcontent.compile_flag..[[ 
LDFLAGS		= -shared
INC_DIRS   := $(shell find $(CORE_DIR) -type d)
INC_FLAGS  := $(addprefix -I,$(INC_DIRS)) -I$(CORE_DIR) ]]..subcontent.include_flag..[[


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

# Clean up build artifacts
clean:
	rm -rf $(BUILD_DIR) $(LIB_DIR)/$(LIB]]..S._TOOLS_NAME_UPPER..[[)

.PHONY: all clean
]]
end

function makefile.compile_flag(compile_flag)
    return compile_flag
end

function makefile.include_flag(include_flag)
    return "-I"..include_flag
end

return makefile