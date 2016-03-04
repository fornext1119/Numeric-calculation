;自作の正弦関数
(defn mySin [x n nega numerator denominator y]
    (def m     (* 2 n))
    (def denom (* denominator (* (+ m 1) m)))
    (def nume  (* numerator (* x x)))
    (def a     (/ nume denom))
    ;十分な精度になったら処理を抜ける
    (if (<= a 0.00000000001)
        y
        (+ y (mySin x (+ n 1) (not nega) nume denom (if nega a (- a))))))
(doseq
    [degree (filter #(or (= (mod % 30) 0) 
                         (= (mod % 45) 0))
            (map    #(* % 15)
            (range 0 25)))]
    (do
        (def radian (/ (* degree (. Math PI)) 180.0))
        ;自作の正弦関数
        (def d1     (mySin radian 1 false radian 1.0 radian))
        ;標準の正弦関数
        (def d2     (. Math sin radian))
        ;標準関数との差異
        (println (format "%3d : %13.10f - %13.10f = %13.10f" degree d1 d2 (- d1 d2)))))
