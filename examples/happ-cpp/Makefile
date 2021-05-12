TOPTARGETS := all

all: clean build

# -----

build:
		mkdir -p build
		cd build && cmake .. && make

clean:
		rm -rf build

# -----

PHONY: $(TOPTARGETS)

.DEFAULT_GOAL := all