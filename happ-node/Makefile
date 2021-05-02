all: nan napi node-addon-api

#----------

build: build-nan build-napi build-node-addon-api

clean: clean-nan clean-napi clean-node-addon-api

#----------

nan: clean-nan build-nan

build-nan: nan/package.json nan/src-cpp/addon.cc
		cd nan && \
			npm install && \
			node-gyp build

clean-nan: # nan/build
	rm -rf nan/build

#----------

napi: clean-napi build-napi

build-napi: napi/package.json napi/src-c/addon.c
		cd napi && \
			npm install && \
			node-gyp build

clean-napi: # napi/build
	rm -rf napi/build

#----------

node-addon-api: clean-node-addon-api build-node-addon-api

build-node-addon-api: node-addon-api/package.json node-addon-api/src-cpp/addon.cc
		cd node-addon-api && \
			npm install && \
			node-gyp build

clean-node-addon-api: # node-addon-api/build
	rm -rf node-addon-api/build