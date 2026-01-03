PASSWORDSTORE := $(or ${PASSWORD_STORE_DIR},$(HOME)/.password-store)
EXTENSIONS_DIR = ${PASSWORDSTORE}/.extensions
BASH_COMPLETIONS_DIR = ${PASSWORDSTORE}/.bash-completions
BASHCOMPDIR ?= ${HOME}/etc/bash_completion.d

install:
	@install -v -d "$(EXTENSIONS_DIR)/"
	@install -v -m 0755 env.bash "$(EXTENSIONS_DIR)/env.bash"
	@install -v -d "$(BASH_COMPLETIONS_DIR)/"
	@install -v -m 0755 pass-env.bash.completion "$(BASH_COMPLETIONS_DIR)/pass-env.bash.completion"
	@ln -f -s "$(BASH_COMPLETIONS_DIR)/pass-env.bash.completion" "$(BASHCOMPDIR)/pass-env"
	@echo
	@echo "to finish installation, add"
	@echo
	@echo "   export PASSWORD_STORE_ENABLE_EXTENSIONS=true"
	@echo
	@echo "into your ~/.bashrc file"
	@echo

uninstall:
	@rm -vrf "$(EXTENSIONS_DIR)/env.bash"
	@rm -vrf "$(BASH_COMPLETIONS_DIR)/pass-env.bash.completion"
	@rm -vrf "$(DESTDIR)$(BASHCOMPDIR)/pass-env"

lint:
	shellcheck -s bash env.bash

.PHONY: install uninstall lint
