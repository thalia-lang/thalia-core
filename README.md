# Thalia Core

> A lightweight standard library implementation for Linux x86 (32-bit), written in assembly

## Features

- **Zero Dependencies**: Pure assembly implementation with no external libraries
- **C-Compatible API**: Easy integration with C/C++ projects

## Prerequisites

Before building Thalia Core, ensure you have the following installed:

- **YASM** - The Yasm Modular Assembler (v1.3.0 or later)
- **GCC** - GNU Compiler Collection with 32-bit support
- **Make** - GNU Make build system
- **CMake** - For building tests (v3.17 or later)

### Installing Prerequisites

**Debian/Ubuntu:**
```bash
sudo apt-get install yasm gcc make cmake
```

**Arch Linux:**
```bash
sudo pacman -S yasm gcc make cmake
```

## Building

### Build All Libraries

```bash
make all
```

This compiles all library modules into object files in the `build/` directory.

## Installation

Install the library system-wide (requires sudo):

```bash
sudo make install
```

By default, this installs to `/usr/local`. To install to a custom location:

```bash
sudo make install INSTALL_PREFIX=/your/custom/path
```

### What Gets Installed

- **Library objects**: `/usr/local/lib/system.o`, `/usr/local/lib/string.o`
- **Header files**: `/usr/local/include/thalia-core/*.h`

## Usage

### Basic Example

```c
#include <thalia-core/system.h>
#include <thalia-core/string.h>

int main(void) {
    char const* message = "Hello Thalia World!";
    int32_t size = core__string__size(message);
    core__system__exit(size);
    return 0;
}
```

### Compiling Your Program

```bash
# Compile your program with Thalia Core
gcc -m32 -o myprogram myprogram.c /usr/local/lib/string.o /usr/local/lib/system.o

# Or if installed system-wide
gcc -m32 -o myprogram myprogram.c -L/usr/local/lib string.o system.o
```

## API Reference

### System Module (`system.h`)

#### `core__system__exit`
```c
void core__system__exit(int32_t exit_code);
```
Terminates the program with the specified exit code.

**Parameters:**
- `exit_code` - The exit status (0 = success, non-zero = error)

### String Module (`string.h`)

#### `core__string__size`
```c
int32_t core__string__size(const char str[]);
```
Calculates the length of a null-terminated string.

**Parameters:**
- `str` - Pointer to null-terminated string

**Returns:**
- Length of the string (excluding null terminator)

**Note:** Undefined behavior if `str` is NULL or not null-terminated.

## Testing

Build and run the test suite:

```bash
make test
```

The test exit code indicates the test result (exit code is printed at the end).

### Manual Testing

```bash
# Build the library
make all

# Build tests
cd test/build
cmake ..
make

# Run tests
./test
echo $?  # Check exit code
```

## Cleaning

Remove all build artifacts:

```bash
make clean
```

## Uninstalling

Remove the library from your system:

```bash
sudo make uninstall
```

## Project Structure

```
thalia-core/
├── src/                    # Assembly source files
│   ├── system.asm         # System operations
│   └── string.asm         # String operations
├── public/cxx/            # Public C/C++ headers
│   └── thalia-core/
│       ├── all.h          # Include all modules
│       ├── system.h       # System API
│       └── string.h       # String API
├── test/                  # Test suite
│   ├── src/
│   │   └── main.c
│   └── CMakeLists.txt
├── build/                 # Build output (generated)
├── Makefile              # Main build system
└── README.md             # This file
```

## Make Targets

| Target      | Description                                      |
|-------------|--------------------------------------------------|
| `all`       | Build all library objects (default)              |
| `setup`     | Create build directory                           |
| `clean`     | Remove build artifacts                           |
| `install`   | Install library to system (requires sudo)        |
| `uninstall` | Remove library from system (requires sudo)       |
| `test`      | Build and run tests                              |
| `help`      | Display help message                             |

## Platform Support

- **Architecture**: x86 (32-bit)
- **Operating System**: Linux
- **Calling Convention**: cdecl
- **Assembler**: YASM

## Contributing

Contributions are welcome. If you have a feature request, or have found a bug, feel free to open a new issue. If you wish to contribute code, see CONTRIBUTING.md for more details.

### Guidelines

1. Follow the existing code style and conventions
2. Add tests for new functionality
3. Update documentation for API changes
4. Ensure all tests pass before submitting

## License

Copyright (C) 2025 Stan Vlad <vstan02@protonmail.com>

Thalia Core is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

## Authors

**Stan Vlad** - [vstan02@protonmail.com](mailto:vstan02@protonmail.com)

