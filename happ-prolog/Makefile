TOPTARGETS := all

all: clean build

# -----

build: family-tree-build hello-world-build

clean: family-tree-clean hello-world-clean

# -----

FAMILY_TREE_SRC_DIR := hello-world

FAMILY_TREE_SRC := $(shell find $(FAMILY_TREE_SRC_DIR) -type f -name '*.pl')

family-tree-all: family-tree-clean hello-world-clean

family-tree-build: $(FAMILY_TREE_SRC)
		swipl -o ../bin/family-tree-pl -g main -c $(FAMILY_TREE_SRC)

family-tree-clean:
		rm -rf ../bin/family-tree-pl

# -----

HELLO_WORLD_SRC_DIR := hello-world

HELLO_WORLD_SRC := $(shell find $(HELLO_WORLD_SRC_DIR) -type f -name '*.pl')

hello-world-all: hello-world-clean hello-world-build

hello-world-build: $(HELLO_WORLD_SRC)
		swipl -o ../bin/hello-world-pl -g main -c $(HELLO_WORLD_SRC)

hello-world-clean:
		rm -rf ../bin/hello-world-pl

# -----

PHONY: $(TOPTARGETS)

.DEFAULT_GOAL := all
