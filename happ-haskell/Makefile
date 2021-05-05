TOPTARGETS := all

all: clean build

# -----

build: ffi-build app-build

clean: ffi-clean app-clean

# -----

app-all: app-clean app-build

app-build:
		stack build

app-clean:
		stack clean

# -----

ffi-all: ffi-clean ffi-build

ffi-build:
		cd src-cpp/haskell-ffi && make

ffi-clean:
		rm -rf src-cpp/haskell-ffi/build
		rm -rf src-cpp/haskell-ffi/stub

# -----

PHONY: $(TOPTARGETS)