all:  remove-old-stubs generate-stub create-output-dir build

PROJECT_NAME="haskell-ffi"

create-output-dir:
		mkdir -p ./build || true

remove-old-stubs:
		rm -rf ./stub || true

generate-stub:
		ghc -c -O -odir ./stub -outputdir ./stub ../../src/Safe.hs

build: ./stub/Safe.hi ./stub/Safe.o ./stub/Safe_stub.h
		ghc -optc-O -no-hs-main main.c stub/Safe.o -odir ./build -outputdir ./build -o build/call-haskell