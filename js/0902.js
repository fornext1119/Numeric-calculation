var a = 1
var b = 2
WScript.StdOut.Write(("            " + falseposition(a, b).toFixed(10) ).slice(-12) + "\n")

function falseposition(a, b) {
	var c
	while (true) {
	    // 点 (a,f(a)) と 点 (b,f(b)) を結ぶ直線と x軸の交点
	    c  = (a * f(b) - b * f(a)) / (f(b) - f(a))
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
