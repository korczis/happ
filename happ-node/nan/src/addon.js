var addon = require('bindings')('addon.node')

function add(a, b) {
    return addon.add(a, b);
}

function div(a, b) {
    return addon.div(a, b);
}

function mul(a, b) {
    return addon.mul(a, b);
}

function sub(a, b) {
    return addon.sub(a, b);
}

module.exports = {
    add,
    div,
    mul,
    sub
}