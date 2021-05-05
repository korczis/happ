TOPTARGETS := all

all: clean build

# -----

SRC_DIR := .

SRC := $(shell find $(SRC_DIR) -type f -name '*.toml' -o -name '*.rs')

build:
		cargo build

clean:
		cargo clean

# -----

PHONY: $(TOPTARGETS)