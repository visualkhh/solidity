// exports.wow = 'z';
// module.exports = {
//     add(a, b) { return a + b }
// }

module.exports = function (r) {
    return {
        area() {
            return PI * r * r;
        },
        circumference() {
            return 2 * PI * r
        }
    };
}