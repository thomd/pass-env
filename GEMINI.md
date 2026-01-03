# GEMINI.md: Pass CLI Extension

## Description

This project is a custom extension for the `pass` command-line utility, enhancing its functionality for password management by providing a way to export environment variables from `pass` entries. Typical use case is to export API keys of AI service providers for authentication.

## Features

- **Environment Variable Export:** Exports values from `pass` entries as environment variables in the current shell.
- **Configurable:** The environment variable name and its value are read directly from the `pass` entry.

## Installation

To install this extension, follow these steps:

1.  **Prerequisites:** Ensure you have `pass` installed and configured.
2.  **Enable `pass` extensions:** Add the following to your shell's configuration file (e.g., `~/.bashrc`, `~/.zshrc`):
    ```bash
    export PASSWORD_STORE_ENABLE_EXTENSIONS=true
    ```
    Then, reload your shell configuration (e.g., `source ~/.bashrc`).
3.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```
4.  **Install the extension:** Create a symlink to the `pass-env.bash` script in your `pass` extensions directory.
    ```bash
    mkdir -p ~/.password-store/.extensions
    ln -s "$(pwd)/pass-env.bash" ~/.password-store/.extensions/env.bash
    ```
    This makes the `env` subcommand available to `pass`.

## Usage

This extension provides a `pass env` subcommand.

1.  **Store a new API key:** Create a `pass` entry where the first line is the secret value and the second line is the environment variable name. For example, to store "My API Key" as `GEMINI_API_KEY`:
    ```bash
    pass insert -m api/gemini
    ```
    When prompted, enter:
    ```
    My API Key
    GEMINI_API_KEY
    ```
    (Press `Ctrl+D` to finish)

2.  **Export into environment:** To export the value as an environment variable in your current shell, run:
    ```bash
    pass env api/gemini
    ```
    This command will execute `export GEMINI_API_KEY="My API Key"`, making `GEMINI_API_KEY` available in your current shell.

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to get involved.

## License

This project is licensed under the [MIT License](LICENSE).

