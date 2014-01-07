// �f�[�^�_�̐�
var N = 7

var x = []
var y = []

// 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
for (var i = 0; i < N; i++)
{
    var d = i * 1.5 - 4.5
    x[i] = d
    y[i] = f(d)
}

// 0.5���݂� �^�����Ă��Ȃ��l����
for (var i = 0; i <= 18; i++)
{
    var d1  = i * 0.5 - 4.5
    var d2 = f(d1)
    var d3 = lagrange(d1, x, y)

    // ���̊֐��Ɣ�r
    WScript.StdOut.Write(("     "    + d1.toFixed(2)       ).slice(-5) + "\t")
    WScript.StdOut.Write(("        " + d2.toFixed(5)       ).slice(-8) + "\t")
    WScript.StdOut.Write(("        " + d3.toFixed(5)       ).slice(-8) + "\t")
    WScript.StdOut.Write(("        " + (d2 - d3).toFixed(5)).slice(-8) + "\n")
}

// ���̊֐�
function f(x) 
{
    return x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2)
}

// Lagrange (���O�����W��) ���
function lagrange(d, x, y)
{
    var sum = 0;
    for (var i = 0; i < N; i++)
	{
        prod = y[i]
        for (var j = 0; j < N; j++) 
		{
            if (j != i)
                prod *= (d - x[j]) / (x[i] - x[j])
        }
        sum += prod
    }
    return sum
}
