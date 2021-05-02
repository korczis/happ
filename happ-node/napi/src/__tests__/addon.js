const addon = require('../addon.js');

describe("Calculator tests", () => {
    test('adding 1 + 2 should return 3', () => {
        expect(addon.add(1, 2)).toBe(3);
    });

    test('dividing 10 / 2 should return 5', () => {
        expect(addon.div(10, 2)).toBe(5);
    })

    test('multiplying 2 * 3 should return 6', () => {
        expect(addon.mul(2, 3)).toBe(6);
    })

    test('substracting 5 - 2 should return 3', () => {
        expect(addon.sub(5, 2)).toBe(3);
    });
})
