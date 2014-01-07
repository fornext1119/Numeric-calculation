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

    // 0.5���݂� �^�����Ă��Ȃ��l���� 
    for i := 0; i <= 18; i++ {
        var d  float64 = float64(i) * 0.5 - 4.5
        var d1 float64 = f(d)
        var d2 float64 = lagrange(d, x[:], y[:])

        // ���̊֐��Ɣ�r
        fmt.Printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d, d1, d2, d1 - d2)
    }
}

// ���̊֐�
func f(x float64) float64 {
    return x - math.Pow(x,3) / (3 * 2) + math.Pow(x,5) / (5 * 4 * 3 * 2)
}

// Lagrange (���O�����W��) ���
func lagrange(d float64, x []float64, y []float64) float64 {
    var sum float64 = 0
    for i := 0; i < N; i++ {
        var prod float64 = y[i]
        for j := 0; j < N; j++ {
            if (j != i) {
                prod *= (d - x[j]) / (x[i] - x[j])
            }
        }
        sum += prod
    }
    return sum
}
