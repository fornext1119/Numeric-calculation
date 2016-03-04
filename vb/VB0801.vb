Option Explicit

Module VB0801
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
		Dim vx(1) As Double
		vx(0) = v * Math.Cos(radian)
		'���������̑��x
		Dim vy(1) As Double
		vy(0) = v * Math.Sin(radian)
		'�o�ߕb��
		Dim t As Double = 0.0
		'�ʒu
		Dim x As Double = 0.0
		Dim y As Double = 0.0

		'Euler�@
		Dim i As Integer = 1
		Do While (y >= 0.0)
		    '�o�ߕb��
		    t = i * h

		    '�ʒu
		    x += h * vx(0)
		    y += h * vy(0)

            Console.WriteLine(string.Format("{0,4:F2}{5}{1,8:F5}{5}{2,9:F5}{5}{3,9:F5}{5}{4,8:F5}", t, vx(0), vy(0), x, y, vbTab))

		    '���x
		    vx(1) = vx(0) + h * fx(vx(0), vy(0))
		    vy(1) = vy(0) + h * fy(vx(0), vy(0))
		    vx(0) = vx(1)
		    vy(0) = vy(1)

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
