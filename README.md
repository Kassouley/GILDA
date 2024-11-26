# GILDA (Generated Interception Library with Dynamic Adaptation)

## Introduction

GILDA is a Lua-based tool designed to streamline the process of generating source code, build scripts, and run scripts for an LD_PRELOAD C library. The generated library by GILDA hooks into functions, allowing for the addition of callbacks before and after each function call. GILDA simplifies the development of interception libraries by automating the creation of necessary components.

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
    "details" : {
        "string": "$PWD/strings.ini",
        "output_dir": "$PWD/results",
        "template_path" : "$PWD/template"
    }, 
    "domain_list" : {
        "math" : {
            "function_csv" : "$PWD/sample_csv/functions_sample.csv",
            "struct_csv" : "",
            "typedef_csv" : "$PWD/sample_csv/types_sample.csv",
            "includes" : ["math.h"],
            "lib" : "/lib/x86_64-linux-gnu/libm.so.6",
            "is_preload" : true
        }
    }
}
```
output_dir is the directory where the tools directory will be created.

**Example:**
```sh
lua gilda.lua gen config.json
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