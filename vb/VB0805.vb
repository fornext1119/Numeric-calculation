Option Explicit

Module VB0805
	'�d�͉����x
	Private Const g As Double = -9.8
	'��C��R�W��
	Private Const k As Double = -0.01
	'���ԊԊu(�b)
	Private Const h As Double = 0.01

    Public Sub Main()
		'�p�x
		Const degree As Double = 45
		Dim radian As Double = degree * Math.PI / 180.0
		'���� 250 km/h -> �b���ɕϊ�
		Dim v As Double = 250 * 1000 \ 3600
		'���������̑��x
		Dim vx(5) As Double
		vx(0) = v * Math.Cos(radian)
		'���������̑��x
		Dim vy(5) As Double
		vy(0) = v * Math.Sin(radian)
		'�o�ߕb��
		Dim t As Double = 0.0
		'�ʒu
		Dim x(5) As Double
		x(0) = 0.0
		Dim y(5) As Double
		y(0) = 0.0

		'Runge-Kutta-Gill�@
		Dim i As Integer = 1
		Do While (y(0) >= 0.0)
		    '�o�ߕb��
		    t = i * h

		    '�ʒu�E���x
		    x(1)  = h *    vx(0)
		    y(1)  = h *    vy(0)
		    vx(1) = h * fx(vx(0), vy(0))
		    vy(1) = h * fy(vx(0), vy(0))
		    
		    Dim wx As Double = vx(0) + vx(1) / 2.0
		    Dim wy As Double = vy(0) + vy(1) / 2.0
		    x(2)  = h *    wx
		    y(2)  = h *    wy
		    vx(2) = h * fx(wx, wy)
		    vy(2) = h * fy(wx, wy)

		    wx    = vx(0) + vx(1) * ((Math.Sqrt(2.0) - 1) / 2) + vx(2) * (1 - 1 / Math.Sqrt(2.0))
		    wy    = vy(0) + vy(1) * ((Math.Sqrt(2.0) - 1) / 2) + vy(2) * (1 - 1 / Math.Sqrt(2.0))
		    x(3)  = h *    wx
		    y(3)  = h *    wy
		    vx(3) = h * fx(wx, wy)
		    vy(3) = h * fy(wx, wy)

		    wx    = vx(0) - vx(2) / Math.Sqrt(2.0) + vx(3) * (1 + 1 / Math.Sqrt(2.0))
		    wy    = vy(0) - vy(2) / Math.Sqrt(2.0) + vy(3) * (1 + 1 / Math.Sqrt(2.0))
		    x(4)  = h *    wx
		    y(4)  = h *    wy
		    vx(4) = h * fx(wx, wy)
		    vy(4) = h * fy(wx, wy)

		    x(0)  += ( x(1) +  x(2) * (2 - Math.Sqrt(2.0)) +  x(3) * (2 + Math.Sqrt(2.0)) +  x(4)) / 6
		    y(0)  += ( y(1) +  y(2) * (2 - Math.Sqrt(2.0)) +  y(3) * (2 + Math.Sqrt(2.0)) +  y(4)) / 6
		    vx(0) += (vx(1) + vx(2) * (2 - Math.Sqrt(2.0)) + vx(3) * (2 + Math.Sqrt(2.0)) + vx(4)) / 6
		    vy(0) += (vy(1) + vy(2) * (2 - Math.Sqrt(2.0)) + vy(3) * (2 + Math.Sqrt(2.0)) + vy(4)) / 6

            Console.WriteLine(string.Format("{0,4:F2}{5}{1,8:F5}{5}{2,9:F5}{5}{3,9:F5}{5}{4,9:F5}", t, vx(0), vy(0), x(0), y(0), vbTab))

		    i += 1
		Loop
    End Sub

	'��C��R�ɂ�鐅�������̌�����
	Private Function fx(ByVal vx As Double, ByVal vy As Double) As Double
	    Return k * Math.Sqrt(vx * vx + vy * vy) * vx
	End Function

	'�d�͂Ƌ�C��R�ɂ�鉔�������̌�����
	Private Function fy(ByVal vx As Double, ByVal vy As Double) As Double
	    Return g + (k * Math.Sqrt(vx * vx + vy * vy) * vy)
	End Function
End Module