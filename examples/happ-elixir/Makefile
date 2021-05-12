TOPTARGETS := all

all: clean build

# -----

build: deps-build assets-build app-build

clean: assets-clean deps-clean app-clean

# ----

app-all: app-clean app-build

app-build: deps-build assets-build
	mix do compile

app-clean:
	rm -rf _build
	rm -rf priv/native

# -----

assets-all: assets-clean assets-deps-get assets-build

assets-build: assets-build-development

assets-build-development: assets-deps-get
		cd assets && yarn run build --mode development
		mix phx.digest

assets-build-production: assets-deps-get
		cd assets && yarn run build
		mix phx.digest

assets-clean:
		rm -rf assets/node_modules
		rm -rf priv/static

assets-deps-get:
		cd assets && yarn

# -----

deps-all: deps-clean deps-get deps-build

deps-build: deps-get
		mix deps.compile

deps-clean:
		rm -rf deps

deps-get:
		mix deps.get

# -----

PHONY: $(TOPTARGETS)

.DEFAULT_GOAL := all