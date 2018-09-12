include mk/Erlanglib.mk

PREFIX = usr/local

BINDIR = bin
BINPATH = $(DESTDIR)/$(PREFIX)/$(BINDIR)

BIN_PATH = $(BASE_PATH)/bin
ERL_PATH = $(BASE_PATH)/erl

clean::
	rm -f $(BIN_PATH)/$(PROJECT)

install:
	mkdir -p $(BINPATH)
	install -p $(BIN_PATH)/$(PROJECT) $(BINPATH)

uninstall:
	rm -f $(BINPATH)/$(PROJECT)
	rmdir -p $(BINPATH) 2>/dev/null || true

run:
	$(BIN_PATH)/$(PROJECT) run

join:
	erl \
		-start_epmd false \
		-remsh $(PROJECT)@localhost \
		-sname $(PROJECT)-$$RANDOM \
		-setcookie $(PROJECT)

erlang: compile
	$(REBAR) erlang
	$(REBAR) unlock

erlang-clean:
	rm -rf $(ERL_PATH)

erlang-install:
	$(MAKE) -C $(ERL_PATH) install DESTDIR=$(DESTDIR) PREFIX=$(PREFIX)

package-ready: clean erlang-clean erlang install erlang-install
