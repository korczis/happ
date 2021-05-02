var addon = require('bindings')('addon.node')

function add(a, b) {
    return addon.add(a, b);
}

function sub(a, b) {
    return addon.sub(a, b);
}

module.exports = {
    add,
    sub
}
