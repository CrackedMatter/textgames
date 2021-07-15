SH = sh
PREFIX = /usr/local
BIN = /bin
MAN = /share/man/man6


all:
	@echo Run \'make install\'
.PHONY: all


clean:
	$(RM) textgames
.PHONY: clean


install:
	@cp src/textgames.sh textgames
	@sed -i 's/bash/$(SH)/g' textgames
	@test -d $(PREFIX)/$(BIN) || mkdir -p $(PREFIX)/$(BIN)
	@test -d $(PREFIX)/$(MAN) || mkdir -p $(PREFIX)/$(MAN)
	@install textgames $(PREFIX)/$(BIN)
	@install -m 0644 man/textgames.6 $(PREFIX)/$(MAN)
.PHONY: install


uninstall:
	$(RM) $(PREFIX)/$(BIN)/textgames
	$(RM) $(PREFIX)/$(MAN)/textgames.6
.PHONY: uninstall
