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

; Runge-Kutta-Gill–@
(defn rungekuttagill[i vx vy x y]
    ; Œo‰ß•b”
    (def t (* i h))

    ; ˆÊ’uE‘¬“x
    (def wx1  (* h     vx))
    (def wy1  (* h     vy))
    (def wvx1 (* h (fx vx vy)))
    (def wvy1 (* h (fy vx vy)))

    (def wvx5 (+ vx (/ wvx1 2.0)))
    (def wvy5 (+ vy (/ wvy1 2.0)))
    (def wx2  (* h     wvx5))
    (def wy2  (* h     wvy5))
    (def wvx2 (* h (fx wvx5 wvy5)))
    (def wvy2 (* h (fy wvx5 wvy5)))

    (def wvx6 (+ vx (* wvx1 (/ (- (. Math sqrt 2.0) 1.0) 2.0)) (* wvx2 (- 1.0 (/ 1.0 (. Math sqrt 2.0))))))
    (def wvy6 (+ vy (* wvy1 (/ (- (. Math sqrt 2.0) 1.0) 2.0)) (* wvy2 (- 1.0 (/ 1.0 (. Math sqrt 2.0))))))
    (def wx3  (* h     wvx6))
    (def wy3  (* h     wvy6))
    (def wvx3 (* h (fx wvx6 wvy6)))
    (def wvy3 (* h (fy wvx6 wvy6)))
              
    (def wvx7 (+ (- vx (/ wvx2 (. Math sqrt 2.0))) (* wvx3 (+ 1.0 (/ 1.0 (. Math sqrt 2.0))))))
    (def wvy7 (+ (- vy (/ wvy2 (. Math sqrt 2.0))) (* wvy3 (+ 1.0 (/ 1.0 (. Math sqrt 2.0))))))
    (def wx4  (* h     wvx7))
    (def wy4  (* h     wvy7))
    (def wvx4 (* h (fx wvx7 wvy7)))
    (def wvy4 (* h (fy wvx7 wvy7)))

    (def wx  (+ x  (/ (+  wx1 (*  wx2 (- 2.0 (. Math sqrt 2.0))) (*  wx3 (+ 2.0 (. Math sqrt 2.0)))  wx4) 6.0)))
    (def wy  (+ y  (/ (+  wy1 (*  wy2 (- 2.0 (. Math sqrt 2.0))) (*  wy3 (+ 2.0 (. Math sqrt 2.0)))  wy4) 6.0)))
    (def wvx (+ vx (/ (+ wvx1 (* wvx2 (- 2.0 (. Math sqrt 2.0))) (* wvx3 (+ 2.0 (. Math sqrt 2.0))) wvx4) 6.0)))
    (def wvy (+ vy (/ (+ wvy1 (* wvy2 (- 2.0 (. Math sqrt 2.0))) (* wvy3 (+ 2.0 (. Math sqrt 2.0))) wvy4) 6.0)))

    (println (format "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%9.5f" t wvx wvy wx wy))

    (if (>= wy 0.0)
        (rungekuttagill (+ i 1) wvx wvy wx wy)
        nil))

(rungekuttagill 1 vx vy x y)
