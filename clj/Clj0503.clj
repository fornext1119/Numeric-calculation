;自作の正接関数
(defn myTan [x x2 n t]
    (def denom (/ x2 (- n t)))
    (def nume  (- n 2))
    (if (<= nume 1)
        (/ x (- 1 denom))
        (myTan x x2 nume denom)))
(doseq
    [degree (map    #(- % 90)
            (filter #(not (zero? (mod % 180)))
            (map    #(* % 15)
            (range 0 12))))]
    (do (def radian (/ (* degree (. Math PI)) 180.0))
        (def x2     (* radian radian))
        ;自作の正接関数
        (def d1     (myTan radian x2 15 0))
        ;標準の正接関数
        (def d2     (. Math tan radian))
        ;標準関数との差異
        (println (format "%3d : %13.10f - %13.10f = %13.10f" degree d1 d2 (- d1 d2)))))
