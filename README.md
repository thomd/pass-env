# pass env

An extension for [pass(1)](https://www.passwordstore.org/) - the standard Unix password manager - to copy an export string `export NAME="VALUE"` into clipboard. Because shell scripts run in a subshell, it is not possible to export environment variables from within a script like `pass`. So the best workaround for  me is to copy-paste the export string into your shell.

Typical use case for me is to manage all my API keys of service providers for authentication.

## Install

    make install

The extension is installed into `~/.password-store/.extensions/` and must be enabled with (you might need add this into your `.bashrc`):

    export PASSWORD_STORE_ENABLE_EXTENSIONS=true

This extension is only tested for **macOS**.

## Usage

Store `VALUE` in the first line and `NAME` in the second line, e.g.

    AIz***NzU
    GEMINI_API_KEY

Store everything else starting with the third line. Any non-empty lines from the third line on will be printed to standard output.

Then run

    pass env api/gemini

This will copy a string, e.g. `export GEMINI_API_KEY="AIz***NzU"` into clipboard.

Then just paste it into your shell.

