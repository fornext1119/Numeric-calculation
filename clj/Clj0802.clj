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

; Heun�@
(defn heun[i vx vy x y]
    ; �o�ߕb��
    (def t (* i h))

    ; �ʒu�E���x
    (def wx2  (+  x (* h     vx                             )))
    (def wy2  (+  y (* h     vy                             )))
    (def wvx2 (+ vx (* h (fx vx vy)                         )))
    (def wvy2 (+ vy (* h (fy vx vy)                         )))

    (def wx   (+  x (* h (/ (+     vx         wvx2      ) 2))))
    (def wy   (+  y (* h (/ (+     vy         wvy2      ) 2))))
    (def wvx  (+ vx (* h (/ (+ (fx vx vy) (fx wvx2 wvy2)) 2))))
    (def wvy  (+ vy (* h (/ (+ (fy vx vy) (fy wvx2 wvy2)) 2))))

    (println (format "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%9.5f" t wvx wvy wx wy))

    (if (>= wy 0.0)
        (heun (+ i 1) wvx wvy wx wy)
        nil))

(heun 1 vx vy x y)
