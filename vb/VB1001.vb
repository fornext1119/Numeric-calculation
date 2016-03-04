Option Explicit

Module VB1001
    Private Const N As Integer = 3
    
    Public Sub Main()
        Dim a(,) As Double = {{9,2,1,1},{2,8,-2,1},{-1,-2,7,-2},{1,-1,-2,6}}
        Dim b()  As Double = {20,16,8,17}
        Dim c()  As Double = {0,0,0,0}

        'ヤコビの反復法
        jacobi(a,b,c)

        Console.WriteLine("X")
		disp_vector(c)
    End Sub
    
    '１次元配列の表示
    Private Sub disp_vector(ByVal row() As Double)
        For Each col As Double In row
            Console.Write(string.Format("{0,14:F10}{1}", col, vbTab))
        Next
        Console.WriteLine()
    End Sub
    
    'ヤコビの反復法
    Private Sub jacobi(ByVal a(,) As Double, ByVal b() As Double, ByVal x0() As Double)
        Do While(True)
            Dim x1() As Double = {0,0,0,0}
            Dim finish As Boolean = True
            For i As Integer = 0 To N
                x1(i) = 0
                For j As Integer = 0 To N
                    If j <> i Then
                        x1(i) += a(i,j) * x0(j)
                    End If
                Next

                x1(i) = (b(i) - x1(i)) / a(i,i)
                If (Math.Abs(x1(i) - x0(i)) > 0.0000000001) Then finish = False
            Next
            For i As Integer = 0 To N
                x0(i) = x1(i)
            Next
            If finish Then Return

			disp_vector(x0)
        Loop
    End Sub
End Module
