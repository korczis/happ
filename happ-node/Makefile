TOPTARGETS := all

all: clean build

# -----

build: nan-build napi-build node-addon-api-build

clean: nan-clean napi-clean node-addon-api-clean

test: build
		npm run test

# -----

nan-all: nan-clean nan-build

nan-build: nan-deps-get nan/src-cpp/addon.cc
		cd nan && node-gyp build

nan-deps-get: nan/package.json
		cd nan && yarn

nan-clean:
		rm -rf nan/build
		rm -rf nan/node_modules

# -----

napi-all: napi-clean napi-build

napi-build: napi-deps-get napi/src-c/addon.c
		cd napi && node-gyp build

napi-deps-get: napi/package.json
		cd napi && yarn

napi-clean:
		rm -rf napi/build
		rm -rf napi/node_modules

# -----

node-addon-api-all: node-addon-api-clean

node-addon-api-build: node-addon-api-build-deps-get node-addon-api/src-cpp/addon.cc
		cd node-addon-api && node-gyp build

node-addon-api-build-deps-get: node-addon-api/package.json
		cd node-addon-api && npm install

node-addon-api-clean: # node-addon-api/build
		rm -rf node-addon-api/build
		rm -rf node-addon-api/node_modules

# -----

PHONY: $(TOPTARGETS)