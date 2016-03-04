(defn f[x]
    (/ 4 (+ 1 (* x x))))

(def a 0)
(def b 1)

; Simpson‘¥‚ÅÏ•ª
(doseq [j (range 1 6)]
    (def n (Math/pow 2 j))
    (def h (/ (- b a) n))
    (def x (+ a h))
    (def s2 0)
    (def s4 0)
    (doseq [i (range 1 (+ (/ n 2) 1))]
        (def s4 (+ s4 (f x)))
        (def x  (+ x  h))
        (def s2 (+ s2 (f x)))
        (def x  (+ x  h))
    )
    (def w2 (double (+ (* (- s2 (f b)) 2) (f a) (f b))))
    (def w4 (* s4 4))
    (def t1 (double (/ (* (+ w2 w4) h) 3)))
    (def t2 (- t1 (. Math PI)))
    ; Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
    (println (format "%2d : %13.10f, %13.10f" j t1 t2)))
