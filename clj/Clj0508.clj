;自作の双曲線正弦関数
(defn mySinh [x n numerator denominator y]
    (def m     (* 2 n))
    (def denom (* denominator (* (+ m 1) m)))
    (def nume  (* numerator (* x x)))
    (def a     (/ nume denom))
    ;十分な精度になったら処理を抜ける
    (if (<= (. Math abs a) 0.00000000001)
        y
        (+ y (mySinh x (+ n 1) nume denom a))))
(doseq
    [i  (map #(- % 10)
        (range 0 21))]
    (do
        (def x  (double i))
        ;自作の双曲線正弦関数
        (def d1 (mySinh x 1 x 1.0 x))
        ;標準の双曲線正弦関数
        (def d2 (. Math sinh x))
        ;標準関数との差異
        (println (format "%3d : %17.10f - %17.10f = %13.10f" i d1 d2 (- d1 d2)))))
