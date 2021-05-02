var addon = require('bindings')('addon.node')

function add(a, b) {
    return addon.add(a, b);
}

module.exports = {
    add
}