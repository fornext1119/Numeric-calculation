Option Explicit

Module VB1101
    Private Const N As Integer = 3

    '�x�L��@�ōő�ŗL�l�����߂�
    Public Sub Main()
        Dim a(,) As Double = {{5.0, 4.0, 1.0, 1.0}, _
                              {4.0, 5.0, 1.0, 1.0}, _
                              {1.0, 1.0, 4.0, 2.0}, _
                              {1.0, 1.0, 2.0, 4.0}}
        Dim x()  As Double =  {1.0 ,0.0 ,0.0 ,0.0}

        '�x�L��@
        Dim lambda As Double = power(a, x)

        Console.WriteLine()
        Console.WriteLine("eigenvalue")
        Console.WriteLine(string.Format("{0,14:F10}", lambda))

        Console.WriteLine("eigenvector")
        disp_vector(x)
    End Sub

    '�x�L��@
    Private Function power(ByVal a(,) As Double, ByRef x0() As Double) As Double
        Dim lambda As Double = 0.0

        '���K�� (�x�N�g�� x0 �̒������P�ɂ���)
        normarize(x0)
        Dim e0 As Double = 0.0
        For i As Integer = 0 To N
            e0 += x0(i)
        Next

        For k As Integer = 1 To 100
            '�P�����z���\��
            Console.Write(string.Format("{0,3:D}{1}", k, vbTab))
            disp_vector(x0)

            '�s��̐� x1 = A �~ x0 
            Dim x1() As Double = {0.0, 0.0, 0.0, 0.0}
            For i As Integer = 0 To N
                For j As Integer = 0 To N
                    x1(i) += a(i, j) * x0(j)
                Next
            Next

            '����
            Dim p0 As Double = 0.0
            Dim p1 As Double = 0.0
            For i As Integer = 0 To N
                p0 += x1(i) * x1(i)
                p1 += x1(i) * x0(i)
            Next
            '�ŗL�l
            lambda = p0 / p1

            '���K�� (�x�N�g�� x1 �̒������P�ɂ���)
            normarize(x1)
            '��������
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

    '�P�����z���\��
    Private Sub disp_vector(ByVal row() As Double)
        For Each col As Double In row
            Console.Write(string.Format("{0,14:F10}{1}", col, vbTab))
        Next
        Console.WriteLine()
    End Sub

    '���K�� (�x�N�g���̒������P�ɂ���)
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
