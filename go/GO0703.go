package main

import "fmt"
import "math"

// �f�[�^�_�̐�
const N = 7 

func main() {
    var x [N]float64
    var y [N]float64

    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    for i := 0; i < N; i++ {
        var d float64 = float64(i) * 1.5 - 4.5
        x[i] = d
        y[i] = f(d)
    }

    // �������̕\�����
    var d[N][N] float64
    for j := 0; j < N; j++ {
        d[0][j] = y[j]
    }
    for i := 1; i < N; i++ {
        for j := 0; j < N - i; j++ {
            d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (x[j+i] - x[j])
        }
    }

    // ���K������
    var a [N]float64
    for j := 0; j < N; j++ {
        a[j] = d[j][0]
    }

    // 0.5���݂� �^�����Ă��Ȃ��l���� 
    for i := 0; i <= 18; i++ {
        var d  float64 = float64(i) * 0.5 - 4.5
        var d1 float64 = f(d)
        var d2 float64 = newton(d, x[:], a[:])

        // ���̊֐��Ɣ�r
        fmt.Printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d, d1, d2, d1 - d2)
    }
}

// ���̊֐�
func f(x float64) float64 {
    return x - math.Pow(x,3) / (3 * 2) + math.Pow(x,5) / (5 * 4 * 3 * 2)
}

// Newton (�j���[�g��) ���
func newton(d float64, x []float64, a []float64) float64 {
    var sum float64 = a[0]
    for i := 1; i < N; i++ {
        var prod float64 = a[i]
        for j := 0; j < i; j++ {
            prod *= (d - x[j])
        }
        sum += prod
    }
    return sum
}
