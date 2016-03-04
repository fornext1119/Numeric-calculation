;自作の指数関数
(defn myExp [x n numerator denominator y]
    (def denom (* denominator n))
    (def nume  (* numerator x))
    (def a     (/ nume denom))
    ;十分な精度になったら処理を抜ける
    (if (<= (. Math abs a) 0.00000000001)
        y
        (+ y (myExp x (+ n 1) nume denom a))))
(doseq
    [x  (map #(/ (- % 10) 4.0)
        (range 0 21))]
    (do
        ;標準の指数関数
        (def d1 (. Math exp x))
        ;自作の指数関数
        (def d2 (myExp x 1 1.0 1.0 1.0))
        ;標準関数との差異
        (println (format "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (- d1 d2)))))
