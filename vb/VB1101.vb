Option Explicit

Module VB1101
    Private Const N As Integer = 3

    'ベキ乗法で最大固有値を求める
    Public Sub Main()
        Dim a(,) As Double = {{5.0, 4.0, 1.0, 1.0}, _
                              {4.0, 5.0, 1.0, 1.0}, _
                              {1.0, 1.0, 4.0, 2.0}, _
                              {1.0, 1.0, 2.0, 4.0}}
        Dim x()  As Double =  {1.0 ,0.0 ,0.0 ,0.0}

        'ベキ乗法
        Dim lambda As Double = power(a, x)

        Console.WriteLine()
        Console.WriteLine("eigenvalue")
        Console.WriteLine(string.Format("{0,14:F10}", lambda))

        Console.WriteLine("eigenvector")
        disp_vector(x)
    End Sub

    'ベキ乗法
    Private Function power(ByVal a(,) As Double, ByRef x0() As Double) As Double
        Dim lambda As Double = 0.0

        '正規化 (ベクトル x0 の長さを１にする)
        normarize(x0)
        Dim e0 As Double = 0.0
        For i As Integer = 0 To N
            e0 += x0(i)
        Next

        For k As Integer = 1 To 100
            '１次元配列を表示
            Console.Write(string.Format("{0,3:D}{1}", k, vbTab))
            disp_vector(x0)

            '行列の積 x1 = A × x0 
            Dim x1() As Double = {0.0, 0.0, 0.0, 0.0}
            For i As Integer = 0 To N
                For j As Integer = 0 To N
                    x1(i) += a(i, j) * x0(j)
                Next
            Next

            '内積
            Dim p0 As Double = 0.0
            Dim p1 As Double = 0.0
            For i As Integer = 0 To N
                p0 += x1(i) * x1(i)
                p1 += x1(i) * x0(i)
            Next
            '固有値
            lambda = p0 / p1

            '正規化 (ベクトル x1 の長さを１にする)
            normarize(x1)
            '収束判定
            Dim e1 As Double = 0.0
            For i As Integer = 0 To N
                e1 += x1(i)
            Next
            If Math.Abs(e1 - e0) < 0.00000000001 Then Exit For

            For i As Integer = 0 To N
                x0(i) = x1(i)
            Next
            e0 = e1
        Next

        Return lambda
    End Function

    '１次元配列を表示
    Private Sub disp_vector(ByVal row() As Double)
        For Each col As Double In row
            Console.Write(string.Format("{0,14:F10}{1}", col, vbTab))
        Next
        Console.WriteLine()
    End Sub

    '正規化 (ベクトルの長さを１にする)
    Private Sub normarize(ByRef x() As Double)
        Dim s As Double = 0.0

        For i As Integer = 0 To N
            s += x(i) * x(i)
        Next
        s = Math.Sqrt(s)
        
        For i As Integer = 0 To N
            x(i) /= s
        Next
    End Sub

End Module
