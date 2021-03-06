Option Explicit

Module VB0803
	'重力加速度
	Private Const g As Double = -9.8
	'空気抵抗係数
	Private Const k As Double = -0.01
	'時間間隔(秒)
	Private Const h As Double = 0.01

    Public Sub Main()
		'角度
		Const degree As Double = 45
		Dim radian As Double = degree * Math.PI / 180.0
		'初速 250 km/h -> 秒速に変換
		Dim v As Double = 250 * 1000 \ 3600
		'水平方向の速度
		Dim vx(1) As Double
		vx(0) = v * Math.Cos(radian)
		'鉛直方向の速度
		Dim vy(1) As Double
		vy(0) = v * Math.Sin(radian)
		'経過秒数
		Dim t As Double = 0.0
		'位置
		Dim x(1) As Double
		x(0) = 0.0
		Dim y(1) As Double
		y(0) = 0.0

		'中点法
		Dim i As Integer = 1
		Do While (y(0) >= 0.0)
		    '経過秒数
		    t = i * h

		    '位置・速度
		    vx(1) = h * fx(vx(0), vy(0))
		    vy(1) = h * fy(vx(0), vy(0))
		    
		    Dim wx As Double = vx(0) + vx(1) / 2.0
		    Dim wy As Double = vy(0) + vy(1) / 2.0
		    vx(0) = vx(0) + h * fx(wx, wy)
		    vy(0) = vy(0) + h * fy(wx, wy)
		    x(0)  = x(0)  + h *    wx
		    y(0)  = y(0)  + h *    wy

            Console.WriteLine(string.Format("{0,4:F2}{5}{1,8:F5}{5}{2,9:F5}{5}{3,9:F5}{5}{4,9:F5}", t, vx(0), vy(0), x(0), y(0), vbTab))

		    i += 1
		Loop
    End Sub

	'空気抵抗による水平方向の減速分
	Private Function fx(ByVal vx As Double, ByVal vy As Double) As Double
	    Return k * Math.Sqrt(vx * vx + vy * vy) * vx
	End Function

	'重力と空気抵抗による鉛直方向の減速分
	Private Function fy(ByVal vx As Double, ByVal vy As Double) As Double
	    Return g + (k * Math.Sqrt(vx * vx + vy * vy) * vy)
	End Function
End Module
