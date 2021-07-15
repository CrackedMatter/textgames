PREFIX = /usr/local/bin
SH = sh


all:
	@echo Run \'make install\'
.PHONY: all


clean:
	$(RM) textgames
.PHONY: clean


install:
	@cp textgames.sh textgames
	@sed -i 's/bash/$(SH)/g' textgames
	@test -d $(PREFIX) || mkdir -p $(PREFIX)
	@install textgames $(PREFIX)
.PHONY: install


uninstall:
	$(RM) $(PREFIX)/textgames
.PHONY: uninstall
