# Directories
CORE_DIR = ./core
BUILD_DIR = ./build
LIB_DIR = ./lib

# Compiler and flags
CC = hipcc
CXX = hipcc
CFLAGS = -fPIC -Wall $(INC_FLAGS) -Wno-deprecated-declarations -D __HIP_PLATFORM_AMD__
LDFLAGS = -shared
INC_DIRS   := $(shell find $(CORE_DIR) -type d)
INC_FLAGS  := $(INC) $(addprefix -I,$(INC_DIRS)) -I./core


# Source files
C_SOURCES = $(shell find $(CORE_DIR) -name '*.c')
CPP_SOURCES = $(shell find $(CORE_DIR) -name '*.cpp')

# Generate corresponding object files paths in the build directory
OBJECTS = $(C_SOURCES:$(CORE_DIR)/%.c=$(BUILD_DIR)/%.o)
OBJECTS += $(CPP_SOURCES:$(CORE_DIR)/%.cpp=$(BUILD_DIR)/%.o)

# Tools object
TOOLS_SRC = $(CORE_DIR)/tools/tools.cpp
TOOLS_OBJ = $(patsubst $(CORE_DIR)/tools/%.cpp,$(BUILD_DIR)/tools/%.o,$(TOOLS_SRC))

# Libraries
LIBINTERCEPTOR = libinterceptor.so
LIBTOOLS = libtools.so

# Default target
all: $(LIBINTERCEPTOR) $(LIBTOOLS)

# Rule to compile .c files to .o
$(BUILD_DIR)/%.o: $(CORE_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to compile .cpp files to .o
$(BUILD_DIR)/%.o: $(CORE_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to create libinterceptor.so
$(LIBINTERCEPTOR): $(TOOLS_OBJ) $(OBJECTS)
	@mkdir -p $(LIB_DIR)
	$(CC) $(LDFLAGS) -o $(LIB_DIR)/$@ $^

# # Rule to create libtools.so
# $(LIBTOOLS): $(LIBINTERCEPTOR) $(TOOLS_OBJ)
# 	$(CC) $(LDFLAGS) -o $(LIB_DIR)/$@ $(TOOLS_OBJ) -L$(LIB_DIR) -linterceptor

# Clean up build artifacts
clean:
	rm -rf $(BUILD_DIR) $(LIB_DIR)/$(LIBINTERCEPTOR) $(LIB_DIR)/$(LIBTOOLS)

.PHONY: all clean
