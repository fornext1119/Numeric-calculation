var a = 1
var b = 2
WScript.StdOut.Write(("            " + falseposition(a, b).toFixed(10) ).slice(-12) + "\n")

function falseposition(a, b) {
	var c
	while (true) {
	    // �_ (a,f(a)) �� �_ (b,f(b)) �����Ԓ����� x���̌�_
	    c  = (a * f(b) - b * f(a)) / (f(b) - f(a))
	    WScript.StdOut.Write(("            " + c.toFixed(10)                  ).slice(-12) + "\t")
	    WScript.StdOut.Write(("            " + (c - Math.sqrt(2)).toFixed(10) ).slice(-12) + "\n")

	    var fc = f(c)
	    if (Math.abs(fc) < 0.0000000001) break

	    if (fc < 0){
	        // f(c) < 0 �ł����, ���͋�� (c, b) �̒��ɑ���
	        a = c
	    } else {
	        // f(c) > 0 �ł����, ���͋�� (a, c) �̒��ɑ���
	        b = c
	    }
	}
	return c
}

function f(x) {
    return x * x - 2
}
