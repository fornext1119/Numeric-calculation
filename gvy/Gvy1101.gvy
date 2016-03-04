N = 3

// �x�L��@�ōő�ŗL�l�����߂�
main()

def main() {
    def a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]] as double[][]
    def x =  [1.0 ,0.0 ,0.0 ,0.0]  as double[]

    // �x�L��@
    lambda = power(a, x)

    println()
    println("eigenvalue")
    printf("%14.10f\n" , lambda)

    println("eigenvector")
    disp_vector(x)
}

// �x�L��@
def power(a, x0) {
    lambda = 0.0

    // ���K�� (�x�N�g�� x0 �̒������P�ɂ���)
    normarize(x0)
    e0 = 0.0
    for (i in 0..N)
        e0 += x0[i]

    for (k in 1..200) {
        // �P�����z���\��
        printf("%3d\t" , k)
        disp_vector(x0)

        // �s��̐� x1 = A �~ x0
        x1 = [0.0 ,0.0 ,0.0 ,0.0]
        for (i in 0..N)
            for (j in 0..N)
                x1[i] += a[i][j] * x0[j]

        // ����
        p0 = 0.0
        p1 = 0.0
        for (i in 0..N) {
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        }
        // �ŗL�l
        lambda = p0 / p1

        // ���K�� (�x�N�g�� x1 �̒������P�ɂ���)
        normarize(x1)
        // ��������
        e1 = 0.0
        for (i in 0..N)
            e1 += x1[i]
        if (Math.abs(e0 - e1) < 0.00000000001) break

        for (i in 0..N)
            x0[i] = x1[i]
        e0 = e1
    }
    lambda
}

// �P�����z���\��
def disp_vector(row) {
    for (col in row) {
        printf("%14.10f\t" , col)
    }
    println()
}
// ���K�� (�x�N�g���̒������P�ɂ���)
def normarize(x) {
    s = 0.0

    for (i in 0..N)
        s += x[i] * x[i]
    s = Math.sqrt(s)

    for (i in 0..N)
        x[i] /= s
}
