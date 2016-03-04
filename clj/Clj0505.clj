;自作の指数関数
(defn myExp [x x2 n t]
    (def denom (/ x2 (+ n t)))
    (def nume  (- n 4))
    (if (< nume 6)
        (+ 1.0 (/ (* 2.0 x) (+ (- 2.0 x) denom)))
        (myExp x x2 nume denom)))
(doseq
    [x  (map #(/ (- % 10) 4.0)
        (range 0 20))]
    (do
        ;標準の指数関数
        (def d1 (. Math exp x))
        ;自作の指数関数
        (def x2 (* x x))
        ;標準関数との差異
        (def d2 (myExp x x2 30 0.0)) ;30:必要な精度が得られるよう, 6から始めて4ずつ増加させる
        (println (format "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (- d1 d2)))))
