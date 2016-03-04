; �d�͉����x
(def g -9.8)
; ��C��R�W��
(def k -0.01)
; ���ԊԊu(�b)
(def h 0.01)

; �p�x
(def degree 45.0)
(def radian (* degree (/ (. Math PI) 180.0)))
; ���� 250 km/h -> �b���ɕϊ�
(def v (quot (* 250 1000) 3600))
; ���������̑��x
(def vx (* v (. Math cos radian)))
; ���������̑��x
(def vy (* v (. Math sin radian)))
; �ʒu
(def x 0.0)
(def y 0.0)

; ��C��R�ɂ�鐅�������̌�����
(defn fx[vx vy]
    (* k (* (. Math sqrt (+ (* vx vx) (* vy vy))) vx)))
; �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
(defn fy[vx vy]
    (+ g (* k (* (. Math sqrt (+ (* vx vx) (* vy vy))) vy))))

; Euler�@
(defn euler[i vx vy x y]
    ; �o�ߕb��
    (def t (* i h))

    ; �ʒu
    (def wx (+ x (* h vx)))
    (def wy (+ y (* h vy)))

    (println (format "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f" t vx vy wx wy))

    ; ���x
    (def wvx (+ vx (* h (fx vx vy))))
    (def wvy (+ vy (* h (fy vx vy))))

    (if (>= wy 0.0)
        (euler (+ i 1) wvx wvy wx wy)
        nil))

(euler 1 vx vy x y)
