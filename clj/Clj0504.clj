;����̎w���֐�
(defn myExp [x n numerator denominator y]
    (def denom (* denominator n))
    (def nume  (* numerator x))
    (def a     (/ nume denom))
    ;�\���Ȑ��x�ɂȂ����珈���𔲂���
    (if (<= (. Math abs a) 0.00000000001)
        y
        (+ y (myExp x (+ n 1) nume denom a))))
(doseq
    [x  (map #(/ (- % 10) 4.0)
        (range 0 21))]
    (do
        ;�W���̎w���֐�
        (def d1 (. Math exp x))
        ;����̎w���֐�
        (def d2 (myExp x 1 1.0 1.0 1.0))
        ;�W���֐��Ƃ̍���
        (println (format "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (- d1 d2)))))
