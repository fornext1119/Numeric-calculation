(defn f[x]
    (/ 4 (+ 1 (* x x))))

(def a 0)
(def b 1)

(def t (list))
; ‘äŒ`‘¥‚ÅÏ•ª
(doseq [j (range 1 11)]
    (def n (Math/pow 2 j))
    (def h (/ (- b a) n))
    (def x a)
    (def s 0)
    (doseq [i (range 1 n)]
        (def x (+ x h))
        (def s (+ s (f x))))
    (def t1 (double (* h (+ (/ (+ (f a) (f b)) 2) s))))
    (def t2 (- t1 (. Math PI)))
    ; Œ‹‰Ê‚ğ•Û‘¶
    (def t (cons t1 t)))

; Richardson‚Ì•âŠO–@
(def t (reverse t))
(doseq [j (range 2 7)]
    (def n (Math/pow 4 (- j 1)))
    (def s (list))
    (doseq [i (range j 7)]
        (def t1 (+ (second t) (/ (- (second t) (first t)) (- n 1))))
        (def t2 (- t1 (. Math PI)))
        ; Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
		(if (= i j)
        	(println (format "%2d : %13.10f, %13.10f" j t1 t2)))
        (def t (rest t))
        (def s (cons t1 s)))
    (def t (reverse s)))
