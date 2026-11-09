.PHONY: all help check install

help:
	@echo "Usage:"
	@echo "  make check    Check dependencies (packages and compilers)"
	@echo "  make install  Install dotfiles"
	@echo "  make all      Check dependencies and install dotfiles"

check:
	./check-deps.sh
install:
	./install.sh

all: check install
