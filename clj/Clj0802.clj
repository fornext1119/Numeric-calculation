; d—Í‰Á‘¬“x
(def g -9.8)
; ‹ó‹C’ïRŒW”
(def k -0.01)
; ŽžŠÔŠÔŠu(•b)
(def h 0.01)

; Šp“x
(def degree 45.0)
(def radian (* degree (/ (. Math PI) 180.0)))
; ‰‘¬ 250 km/h -> •b‘¬‚É•ÏŠ·
(def v (quot (* 250 1000) 3600))
; …•½•ûŒü‚Ì‘¬“x
(def vx (* v (. Math cos radian)))
; ‰”’¼•ûŒü‚Ì‘¬“x
(def vy (* v (. Math sin radian)))
; ˆÊ’u
(def x 0.0)
(def y 0.0)

; ‹ó‹C’ïR‚É‚æ‚é…•½•ûŒü‚ÌŒ¸‘¬•ª
(defn fx[vx vy]
    (* k (* (. Math sqrt (+ (* vx vx) (* vy vy))) vx)))
; d—Í‚Æ‹ó‹C’ïR‚É‚æ‚é‰”’¼•ûŒü‚ÌŒ¸‘¬•ª
(defn fy[vx vy]
    (+ g (* k (* (. Math sqrt (+ (* vx vx) (* vy vy))) vy))))

; Heun–@
(defn heun[i vx vy x y]
    ; Œo‰ß•b”
    (def t (* i h))

    ; ˆÊ’uE‘¬“x
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
