;����̑ΐ��֐�
(defn myLog [x numerator denominator y]
    (def denom (+ denominator 2.0))
    (def nume  (* numerator (* x2 x2)))
    (def a     (/ nume denom))
    ;�\���Ȑ��x�ɂȂ����珈���𔲂���
    (if (<= (. Math abs a) 0.00000000001)
        y
        (+ y (myLog x nume denom a))))
(doseq
    [x  (map #(/ % 5.0)
        (range 1 21))]
    (do
        ;�W���̑ΐ��֐�
        (def d1 (. Math log x))
        ;����̑ΐ��֐�
        (def x2 (/ (- x 1.0) (+ x 1.0)))
        ;�W���֐��Ƃ̍���
        (def d2 (* 2.0 (myLog x2 x2 1.0 x2)))
        (println (format "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (- d1 d2)))))
