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

;���_�@
(defn midpoint[i vx vy x y]
    ; �o�ߕb��
    (def t (* i h))

    ; �ʒu�E���x
    (def wvx1 (* h (fx vx vy)))
    (def wvy1 (* h (fy vx vy)))
    (def wvx2 (+ vx (/ wvx1 2.0)))
    (def wvy2 (+ vy (/ wvy1 2.0)))
              
    (def wvx  (+ vx (* h (fx wvx2 wvy2))))
    (def wvy  (+ vy (* h (fy wvx2 wvy2))))
    (def wx   (+ x  (* h     wvx2)))
    (def wy   (+ y  (* h     wvy2)))

    (println (format "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%9.5f" t wvx wvy wx wy))

    (if (>= wy 0.0)
        (midpoint (+ i 1) wvx wvy wx wy)
        nil))

(midpoint 1 vx vy x y)
