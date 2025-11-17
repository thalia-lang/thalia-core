AS := yasm
ASFLAGS := -felf32 -g dwarf2

SRC_DIR := src
BUILD_DIR := build
PUBLIC_DIR := public
INSTALL_PREFIX ?= /usr/local
INSTALL_LIB_DIR := $(INSTALL_PREFIX)/lib
INSTALL_INC_DIR := $(INSTALL_PREFIX)/include

LIBS := system string

SOURCES := $(addprefix $(SRC_DIR)/, $(addsuffix .asm, $(LIBS)))
OBJECTS := $(addprefix $(BUILD_DIR)/, $(addsuffix .o, $(LIBS)))

.PHONY: all clean install uninstall help setup test

all: $(OBJECTS)

help:
	@echo "Thalia Standard Library"
	@echo ""
	@echo "Available targets:"
	@echo "  all        - Build all library objects (default)"
	@echo "  setup      - Create build directory"
	@echo "  clean      - Remove build artifacts"
	@echo "  install    - Install library to system (requires sudo)"
	@echo "  uninstall  - Remove library from system (requires sudo)"
	@echo "  test       - Build and run tests"
	@echo "  help       - Display this help message"
	@echo ""
	@echo "Variables:"
	@echo "  INSTALL_PREFIX - Installation prefix (default: /usr/local)"

setup:
	@mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | setup
	@echo "AS $<"
	@$(AS) $(ASFLAGS) $< -o $@

clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(BUILD_DIR)
	@rm -f test/build/CMakeCache.txt
	@rm -rf test/build/CMakeFiles
	@rm -f test/build/Makefile
	@rm -f test/build/cmake_install.cmake
	@rm -f test/build/test
	@rm -f test/compile_commands.json
	@echo "Clean complete."

install: all
	@echo "Installing Thalia Core Library..."
	@install -d $(INSTALL_LIB_DIR)
	@install -d $(INSTALL_INC_DIR)
	@install -m 644 $(OBJECTS) $(INSTALL_LIB_DIR)
	@cp -r $(PUBLIC_DIR)/cxx/thalia-core $(INSTALL_INC_DIR)/
	@chmod -R 644 $(INSTALL_INC_DIR)/thalia-core/*.h
	@echo "Installation complete."
	@echo "Library objects installed to: $(INSTALL_LIB_DIR)"
	@echo "Headers installed to: $(INSTALL_INC_DIR)/thalia-core"

uninstall:
	@echo "Uninstalling Thalia Core Library..."
	@rm -f $(addprefix $(INSTALL_LIB_DIR)/, $(notdir $(OBJECTS)))
	@rm -rf $(INSTALL_INC_DIR)/thalia-core
	@echo "Uninstall complete."

test: all
	@echo "Building tests..."
	@cd test/build && cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && $(MAKE)
	@echo "===== < TEST > ====="
	@cd test/build && ./test; \
	EXIT_CODE=$$?; \
	printf "===== < %04d > =====\n" $$EXIT_CODE

-include $(OBJECTS:.o=.d)

