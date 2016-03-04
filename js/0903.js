var x = 1
WScript.StdOut.Write(("            " + iterative(x).toFixed(10) ).slice(-12) + "\n")

function iterative(x0) {
    var x1
	while (true) {
	    x1 = g(x0)
	    WScript.StdOut.Write(("            " + x1.toFixed(10)                  ).slice(-12) + "\t")
	    WScript.StdOut.Write(("            " + (x1 - Math.sqrt(2)).toFixed(10) ).slice(-12) + "\n")

	    if (Math.abs(x1 - x0) < 0.0000000001) break
	    x0 = x1
	}
	return x1
}

function g(x) {
    return (x / 2) + (1 / x)
}
