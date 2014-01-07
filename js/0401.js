var a = 5  // ‰€ 5
var d = 3  // Œö· 3
var n = 10 // €” 10
var p = 1  // Ï

for (var i = 1; i <= n; i++) {
    var m = a + (d * (i - 1))
    p *= m
}
WScript.Echo(p)
