(defn f[x]
    (/ 4 (+ 1 (* x x))))

(def a 0)
(def b 1)

; ’†“_‘¥‚ÅÏ•ª
(doseq [j (range 1 11)]
    (def n (Math/pow 2 j))
    (def h (/ (- b a) n))
    (def x (+ a (/ h 2)))
    (def s 0)
    (doseq [i (range 1 (+ n 1))]
        (def s (+ s (f x)))
        (def x (+ x h)))
    (def t1 (double (* h s)))
    (def t2 (- t1 (. Math PI)))
    ; Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
    (println (format "%2d : %13.10f, %13.10f" j t1 t2)))
