var a = 1
var b = 2
WScript.StdOut.Write(("            " + bisection(a, b).toFixed(10) ).slice(-12) + "\n")

function bisection(a, b) {
	var c
	while (true) {
	    // 区間 (a, b) の中点 c = (a + b) / 2
	    c = (a + b) / 2
	    WScript.StdOut.Write(("            " + c.toFixed(10)                  ).slice(-12) + "\t")
	    WScript.StdOut.Write(("            " + (c - Math.sqrt(2)).toFixed(10) ).slice(-12) + "\n")

	    var fc = f(c)
	    if (Math.abs(fc) < 0.0000000001) break

	    if (fc < 0){
	        // f(c) < 0 であれば, 解は区間 (c, b) の中に存在
	        a = c
	    } else {
	        // f(c) > 0 であれば, 解は区間 (a, c) の中に存在
	        b = c
	    }
	}
	return c
}

function f(x) {
    return x * x - 2
}
