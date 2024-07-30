# GILDA (Generated Interception Library with Dynamic Adaptation)

## Introduction

GILDA is a Lua-based tool designed to streamline the process of generating source code, Makefiles, and run scripts for an LD_PRELOAD C library. The generated library by GILDA hooks into functions, allowing for the addition of callbacks before and after each function call. GILDA simplifies the development of interception libraries by automating the creation of necessary components.

## Installation

### Prerequisites

Before using GILDA, ensure you have the following installed:

- Lua
- Make

### Installation Instructions

1. Clone the GILDA repository:
    ```sh
    git clone https://github.com/Kassouley/GILDA.git
    cd gilda
    ```
2. Ensure Lua is available in your system.

## Commands and Usage

### GILDA parse

**Description:** Parses the header files to get the function prototypes to hook, saving them to a CSV file.

**Arguments:** Takes an output CSV file and one or more header files.

**Example:**
```sh
lua gilda.lua parse output.csv header1.h header2.h
```

### GILDA gen

**Description:** Generates the source code based on a provided configuration file.

**Arguments:** Takes a configuration file structured as follows:

```json
{
    "gen_dir" : "./gen",
    "tools_name": "hooker",
    "tools_name_verb": "hook",
    "tools_name_adj": "hooked",
    "tools_name_abr": "hook",
    "tools_name_noun": "hook",
    "tools_name_gerund": "hooking",
    "lib_to_intercept1": {
        "input_csv": "path/to/csv/function/list",
        "includes": ["header1.h", "header2.h"],
        "include_path": "path/to/include/dir",
        "compile_flag": "some compile flag",
        "lib": "path/to/the/real/lib/so"
    },
    "lib_to_intercept2": {
        "input_csv": "path/to/csv/function/list",
        "includes": ["header1.h", "header2.h"],
        "include_path": "path/to/include/dir",
        "compile_flag": "some compile flag",
        "lib": "path/to/the/real/lib/so"
    }
}
```
gen_dir is the directory where the tools directory will be created.
The tools name variable are used to rename some variable inside the generated code.

**Example:**
```sh
lua gilda.lua gen config.json
```

### GILDA clean

**Description:** Cleans up the generated source code.

**Arguments:** Takes a directory to clean.

**Example:**
```sh
lua gilda.lua clean ./generated_code
```

## Contribution

We welcome contributions to GILDA! If you have any issues, feature requests, or would like to contribute code, please follow these guidelines:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes with clear and descriptive messages.
4. Submit a pull request.

For any issues or questions, please open an issue on GitHub or contact the maintainer.

## License

GILDA is released under the MIT License. See the LICENSE file for more details.