; “™·”—ñ‚ÌÏ
(defn product [m d n]
    (if (zero? n)
        1
        (* m (product (+ m d) d (- n 1)))))
; ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ
(product 5 3 10)
