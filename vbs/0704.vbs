Option Explicit

'データ点の数 - 1
Private Const N   =  6
Private Const Nx2 = 13

Dim x():  ReDim x(N)
Dim y():  ReDim y(N)
Dim yd(): ReDim yd(N)

'1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
Dim i
For i = 0 To N
    Dim d1: d1 = i * 1.5 - 4.5
    x(i)  = d1
    y(i)  = f(d1)
    yd(i) = fd(d1)
Next

'差分商の表を作る
Dim z(): ReDim z(Nx2)
Dim d(): ReDim d(Nx2, Nx2)
For i = 0 To Nx2
    Dim j: j = i \ 2
    z(i)   = x(j)
    d(0,i) = y(j)
Next

For i = 1 To Nx2
    For j = 0 To (Nx2 - i)
        If i = 1 And j mod 2 = 0 Then
            d(i,j) = yd(j \ 2)
        Else
        	d(i,j) = (d(i-1,j+1) - d(i-1,j)) / (z(j+i) - z(j))
		End If
    Next
Next

'ｎ階差分商
Dim a(): ReDim a(Nx2)
For j = 0 To Nx2
    a(j) = d(j,0)
Next

'0.5刻みで 与えられていない値を補間 
For i = 0 To 18
    d1 = i * 0.5 - 4.5
    Dim d2: d2 = f(d1)
    Dim d3: d3 = hermite(d1, z, a)

    '元の関数と比較
    WScript.StdOut.Write     Right(Space(5) & FormatNumber(d1,      2, -1, 0, 0), 5) & vbTab
    WScript.StdOut.Write     Right(Space(8) & FormatNumber(d2,      5, -1, 0, 0), 8) & vbTab
    WScript.StdOut.Write     Right(Space(8) & FormatNumber(d3,      5, -1, 0, 0), 8) & vbTab
    WScript.StdOut.WriteLine Right(Space(8) & FormatNumber(d2 - d3, 5, -1, 0, 0), 8)
Next

'元の関数
Private Function f(ByVal x)
    f = x - (x ^ 3) / (3 * 2) + (x ^ 5) / (5 * 4 * 3 * 2)
End Function
'導関数
Private Function fd(ByVal x)
    fd = 1 - (x ^ 2) / 2 + (x ^ 4) / (4 * 3 * 2)
End Function

'Hermite (エルミート) 補間
Private Function hermite(ByVal d, ByVal z(), ByVal a())
    Dim sum: sum = a(0)
	Dim i, j
    For i = 1 To Nx2
        Dim prod: prod = a(i)
        For j = 0 To (i - 1)
            If j <> i Then
                prod = prod * (d - z(j))
            End If
        Next
        sum = sum + prod
    Next
    hermite = sum
End Function
