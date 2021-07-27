SH = sh
PREFIX = /usr
BIN = /bin
MAN = /share/man/man6


all:
	@echo Run \'make install\'
.PHONY: all


clean:
	$(RM) textgames
	$(RM) txget
	$(RM) txgc
.PHONY: clean


install:
	@cp src/textgames.sh textgames
	@cp src/txget.sh txget
	@cp src/txgc.sh txgc
	@sed -i 's/dash/$(SH)/g' textgames
	@sed -i 's/dash/$(SH)/g' txget
	@sed -i 's/dash/$(SH)/g' txgc
	@test -d $(PREFIX)/$(BIN) || mkdir -p $(PREFIX)/$(BIN)
	@test -d $(PREFIX)/$(MAN) || mkdir -p $(PREFIX)/$(MAN)
	@install textgames $(PREFIX)/$(BIN)
	@install txget $(PREFIX)/$(BIN)
	@install txgc $(PREFIX)/$(BIN)
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
