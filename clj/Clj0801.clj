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

; Euler–@
(defn euler[i vx vy x y]
    ; Œo‰ß•b”
    (def t (* i h))

    ; ˆÊ’u
    (def wx (+ x (* h vx)))
    (def wy (+ y (* h vy)))

    (println (format "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f" t vx vy wx wy))

    ; ‘¬“x
    (def wvx (+ vx (* h (fx vx vy))))
    (def wvy (+ vy (* h (fy vx vy))))

    (if (>= wy 0.0)
        (euler (+ i 1) wvx wvy wx wy)
        nil))

(euler 1 vx vy x y)
