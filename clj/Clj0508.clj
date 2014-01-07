;©ì‚Ì‘o‹Èü³Œ·ŠÖ”
(defn mySinh [x n numerator denominator y]
    (def m     (* 2 n))
    (def denom (* denominator (* (+ m 1) m)))
    (def nume  (* numerator (* x x)))
    (def a     (/ nume denom))
    ;\•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ğ”²‚¯‚é
    (if (<= (. Math abs a) 0.00000000001)
        y
        (+ y (mySinh x (+ n 1) nume denom a))))
(doseq
    [i  (map #(- % 10)
        (range 0 21))]
    (do
        (def x  (double i))
        ;©ì‚Ì‘o‹Èü³Œ·ŠÖ”
        (def d1 (mySinh x 1 x 1.0 x))
        ;•W€‚Ì‘o‹Èü³Œ·ŠÖ”
        (def d2 (. Math sinh x))
        ;•W€ŠÖ”‚Æ‚Ì·ˆÙ
        (println (format "%3d : %17.10f - %17.10f = %13.10f" i d1 d2 (- d1 d2)))))
