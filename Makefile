# See https://stackoverflow.com/questions/17834582/run-make-in-each-subdirectory/17845120

TOPTARGETS := all clean

SUBDIRS = happ-cpp \
	      happ-elixir \
	      happ-haskell \
	      happ-node \
          happ-prolog \
          happ-rust \
	      happ-swift

# -----

$(TOPTARGETS): $(SUBDIRS)

$(SUBDIRS):
		$(MAKE) -C $@ $(MAKECMDGOALS)

# -----

.PHONY: $(TOPTARGETS) $(SUBDIRS)