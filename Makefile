# Compiler and compilation flags
CC = gcc
# -Wall enables all warnings, -g adds debugging info, -Iinclude tells gcc where to find headers
CFLAGS = -Wall -g -Iinclude

# Linker flags (initially empty, will be modified for Release 2)
# For v4, this will become: LDFLAGS = -lreadline
LDFLAGS = 

# --- Project Structure ---
# Define directory variables for easy maintenance
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

# --- File Definitions ---
# Automatically find all .c files in the source directory
SRCS = $(wildcard $(SRC_DIR)/*.c)

# Generate the list of object file names by replacing 'src/' with 'obj/' and '.c' with '.o'
# e.g., src/main.c becomes obj/main.o
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

# Define the final executable file name
TARGET = $(BIN_DIR)/psh

# --- Build Rules ---

# Phony targets are not actual files. 'all' is the default goal.
.PHONY: all clean

# The 'all' rule depends on the final executable.
all: $(TARGET)

# Rule to link the final executable.
# This rule depends on all the object files.
$(TARGET): $(OBJS)
	@echo "Linking executable: $@"
	@mkdir -p $(BIN_DIR)  # Ensure the bin directory exists before linking
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
	@echo "Build complete. Run with: ./$(TARGET)"

# Pattern rule to compile source files into object files.
# This says "to create a file like obj/something.o, you need src/something.c"
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c include/shell.h
	@echo "Compiling $<  -->  $@"
	@mkdir -p $(OBJ_DIR)  # Ensure the obj directory exists before compiling
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to clean up all generated files.
clean:
	@echo "Cleaning up build artifacts..."
	rm -rf $(OBJ_DIR)/* $(BIN_DIR)/*