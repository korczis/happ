TOPTARGETS := all clean

all: clean build

# -----

SRC_DIR := Sources

SRC := Package.swift $(shell find $(SRC_DIR) -type f -name '*.swift')

clean:
		rm -rf .build

build: $(SRC)
		swift build

run: swift-build
		swift run

# -----

PHONY: $(TOPTARGETS)