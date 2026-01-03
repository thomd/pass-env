# pass env

An extension for [pass(1)](https://www.passwordstore.org/) - the standard Unix password manager - to copy a string `export NAME="VALUE"` into clipboard.

Because scripts run in a subshell, it is not possible to export environment variables from a script. Paste the export string into your shell.

Typical use case is to export API keys of AI service providers for authentication.

## Install

    make install

The extension is installed into `~/.password-store/.extensions/` and must be enabled with (you might need add this into your `.bashrc`):

    export PASSWORD_STORE_ENABLE_EXTENSIONS=true

This extension is only tested for **macOS**.

### Uninstall

    make uninstall

## Usage

Store `VALUE` in the first line and `NAME` in the second line, e.g.

    AIz***NzU
    GEMINI_API_KEY
    

Then run

    pass env api/gemini

and paste into your shell

