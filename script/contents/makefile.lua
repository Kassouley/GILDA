local makefile = {}

function makefile.content(subcontent)
    return string.format([[
# Directories
CORE_DIR = %s
BUILD_DIR = %s
LIB_DIR = %s

# Libraries
LIB%s = lib%s.so

# Compiler and flags
CC 			= hipcc
CXX			= hipcc
CFLAGS 		= -fPIC -Wall $(INC_FLAGS) -Wno-deprecated-declarations %s
LDFLAGS		= -shared
INC_DIRS   := $(shell find $(CORE_DIR) -type d)
INC_FLAGS  := $(addprefix -I,$(INC_DIRS)) -I$(CORE_DIR) %s


# Source files
C_SOURCES = $(shell find $(CORE_DIR) -name '*.c')
CPP_SOURCES = $(shell find $(CORE_DIR) -name '*.cpp')

# Generate corresponding object files paths in the build directory
OBJECTS = $(C_SOURCES:$(CORE_DIR)/%.c=$(BUILD_DIR)/%.o)
OBJECTS += $(CPP_SOURCES:$(CORE_DIR)/%.cpp=$(BUILD_DIR)/%.o)

# Default target
all: $(LIB%s)

# Rule to compile .c files to .o
$(BUILD_DIR)/%.o: $(CORE_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to compile .cpp files to .o
$(BUILD_DIR)/%.o: $(CORE_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to create lib%s.so
$(LIB%s): $(OBJECTS)
	@mkdir -p $(LIB_DIR)
	$(CC) $(LDFLAGS) -o $(LIB_DIR)/$@ $^

# Clean up build artifacts
clean:
	rm -rf $(BUILD_DIR) $(LIB_DIR)/$(LIB%s)

.PHONY: all clean
]]	
		S._COREDIR,
		S._BUILDDIR,
		S._LIBDIR,
		S._TOOLS_NAME,
		subcontent.compil_flag,
		subcontent.include_flag,
		S._TOOLS_NAME_UPPER,
		S._TOOLS_NAME,
		S._TOOLS_NAME_UPPER,
		S._TOOLS_NAME_UPPER
	)
end

return makefile