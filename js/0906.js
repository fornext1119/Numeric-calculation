var x0 = 1
var x1 = 2
WScript.StdOut.Write(("            " + secant(x0, x1).toFixed(10) ).slice(-12) + "\n")

function secant(x0, x1) {
    var x2
	while (true) {
		x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
	    WScript.StdOut.Write(("            " + x2.toFixed(10)                  ).slice(-12) + "\t")
	    WScript.StdOut.Write(("            " + (x2 - Math.sqrt(2)).toFixed(10) ).slice(-12) + "\n")

	    if (Math.abs(x2 - x1) < 0.0000000001) break
	    x0 = x1
	    x1 = x2
	}
	return x2
}

function f(x) {
    return x * x - 2
}
