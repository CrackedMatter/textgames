PREFIX = /usr/local
BIN = /bin
MAN = /share/man/man6


all:
	@echo Run \'make install\'
.PHONY: all


install:
	@test -d $(PREFIX)/$(BIN) || mkdir -p $(PREFIX)/$(BIN)
	@test -d $(PREFIX)/$(MAN) || mkdir -p $(PREFIX)/$(MAN)
	@install src/textgames $(PREFIX)/$(BIN)
	@install src/txget $(PREFIX)/$(BIN)
	@install src/txgc $(PREFIX)/$(BIN)
	@install -m 0644 man/*.6 $(PREFIX)/$(MAN)
.PHONY: install


uninstall:
	$(RM) $(PREFIX)/$(BIN)/textgames
	$(RM) $(PREFIX)/$(BIN)/txget
	$(RM) $(PREFIX)/$(BIN)/txgc
	$(RM) $(PREFIX)/$(MAN)/textgames.6
	$(RM) $(PREFIX)/$(MAN)/txget.6
	$(RM) $(PREFIX)/$(MAN)/txgc.6
.PHONY: uninstall
