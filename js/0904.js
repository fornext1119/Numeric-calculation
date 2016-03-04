var x = 2
WScript.StdOut.Write(("            " + newton(x).toFixed(10) ).slice(-12) + "\n")

function newton(x0) {
    var x1
	while (true) {
	    x1 = x0 - (f0(x0) / f1(x0))
	    WScript.StdOut.Write(("            " + x1.toFixed(10)                  ).slice(-12) + "\t")
	    WScript.StdOut.Write(("            " + (x1 - Math.sqrt(2)).toFixed(10) ).slice(-12) + "\n")

	    if (Math.abs(x1 - x0) < 0.0000000001) break
	    x0 = x1
	}
	return x1
}

function f0(x) {
    return x * x - 2
}

function f1(x) {
    return 2 * x
}
