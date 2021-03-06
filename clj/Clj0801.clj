; 重力加速度
(def g -9.8)
; 空気抵抗係数
(def k -0.01)
; 時間間隔(秒)
(def h 0.01)

; 角度
(def degree 45.0)
(def radian (* degree (/ (. Math PI) 180.0)))
; 初速 250 km/h -> 秒速に変換
(def v (quot (* 250 1000) 3600))
; 水平方向の速度
(def vx (* v (. Math cos radian)))
; 鉛直方向の速度
(def vy (* v (. Math sin radian)))
; 位置
(def x 0.0)
(def y 0.0)

; 空気抵抗による水平方向の減速分
(defn fx[vx vy]
    (* k (* (. Math sqrt (+ (* vx vx) (* vy vy))) vx)))
; 重力と空気抵抗による鉛直方向の減速分
(defn fy[vx vy]
    (+ g (* k (* (. Math sqrt (+ (* vx vx) (* vy vy))) vy))))

; Euler法
(defn euler[i vx vy x y]
    ; 経過秒数
    (def t (* i h))

    ; 位置
    (def wx (+ x (* h vx)))
    (def wy (+ y (* h vy)))

    (println (format "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f" t vx vy wx wy))

    ; 速度
    (def wvx (+ vx (* h (fx vx vy))))
    (def wvy (+ vy (* h (fy vx vy))))

    (if (>= wy 0.0)
        (euler (+ i 1) wvx wvy wx wy)
        nil))

(euler 1 vx vy x y)
