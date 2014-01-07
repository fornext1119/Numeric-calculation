;自作の対数関数
(defn myLog [x numerator denominator y]
    (def denom (+ denominator 2.0))
    (def nume  (* numerator (* x2 x2)))
    (def a     (/ nume denom))
    ;十分な精度になったら処理を抜ける
    (if (<= (. Math abs a) 0.00000000001)
        y
        (+ y (myLog x nume denom a))))
(doseq
    [x  (map #(/ % 5.0)
        (range 1 21))]
    (do
        ;標準の対数関数
        (def d1 (. Math log x))
        ;自作の対数関数
        (def x2 (/ (- x 1.0) (+ x 1.0)))
        ;標準関数との差異
        (def d2 (* 2.0 (myLog x2 x2 1.0 x2)))
        (println (format "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (- d1 d2)))))
