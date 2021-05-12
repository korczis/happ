# Happ for Node.JS

## Prerequisites

- node.js
- node-gyp

## Building

    # Install required packages
    $ npm install
    
    # Build native build
    node-gyp build
    
## Usage

    # Run node REPL
    $ node
    >

    # Load addon
    > h = require('./addon.js')
    { add: [Function: add] }

    # Call addon function
    > h.add(1, 2)
    3