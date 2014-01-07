;自作の対数関数
(defn myLog [x n t]
    (do
        (def n2 (if (zero? (rem n 2)) 2
                                      n))
        (def n3 (if (> n 3)           n2
                                      n))
        (def x2 (if (> n 3)           (* x (quot n 2))
                                      x))
        (def t2 (/ x2 (+ n3 t)))

        (if (<= n 2) (/ x (+ 1.0 t2))
                     (myLog x (- n 1) t2))))
(doseq
    [x  (map #(/ % 5.0)
        (range 1 21))]
    (do
        ;標準の対数関数
        (def d1 (. Math log x))
        ;自作の対数関数
        (def d2 (myLog (- x 1.0) 27 0.0)) ;27:必要な精度が得られる十分大きな奇数
        ;標準関数との差異
        (println (format "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (- d1 d2)))))
