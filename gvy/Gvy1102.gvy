N = 3

// �t�x�L��@�ōŏ��ŗL�l�����߂�
main()

def main() {
    def a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]] as double[][]
    def x =  [1.0 ,0.0 ,0.0 ,0.0]  as double[]

    // LU����
    forward_elimination(a)

    // �t�x�L��@
    lambda = inverse(a, x)

    println()
    println("eigenvalue")
    printf("%14.10f\n" , lambda)

    println("eigenvector")
    disp_vector(x)
}

// �t�x�L��@
def inverse(a, x0) {
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

        // Ly=b ���� y �����߂� (�O�i���)
        b = [0.0,0.0,0.0,0.0]
        y = [0.0,0.0,0.0,0.0]
        for (i in 0..N)
            b[i] = x0[i]
        forward_substitution(a,y,b)

        // Ux=y ���� x �����߂� (��ޑ��)
        x1 = [0.0,0.0,0.0,0.0]
        backward_substitution(a,x1,y)

        // ����
        p0 = 0.0
        p1 = 0.0
        for (i in 0..N) {
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        }
        // �ŗL�l
        lambda = p1 / p0

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

// �O�i����
def forward_elimination(a) {
    for (pivot in 0..(N - 1)) {
        for (row in (pivot + 1)..N) {
            s = a[row][pivot] / a[pivot][pivot]
            for (col in pivot..N)
                a[row][col] -= a[pivot][col] * s // ���ꂪ ��O�p�s��
            a[row][pivot]    = s                 // ���ꂪ ���O�p�s��
        }
    }
}
// Ly=b ���� y �����߂� (�O�i���)
def forward_substitution(a, y, b) {
    for (row in 0..N) {
        for (col in 0..row)
            b[row] -= a[row][col] * y[col]
        y[row] = b[row]
    }
}
// Ux=y ���� x �����߂� (��ޑ��)
def backward_substitution(a, x, y) {
    for (row = N; row >= 0; row--) {
        for (col = N; col > row; col--)
            y[row] -= a[row][col] * x[col]
        x[row] = y[row] / a[row][row]
    }
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
