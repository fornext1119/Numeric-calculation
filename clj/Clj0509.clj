;����̑o�Ȑ��]���֐�
(defn myCosh [x n numerator denominator y]
    (def m     (* 2 n))
    (def denom (* denominator (* m (- m 1))))
    (def nume  (* numerator (* x x)))
    (def a     (/ nume denom))
    ;�\���Ȑ��x�ɂȂ����珈���𔲂���
    (if (<= (. Math abs a) 0.00000000001)
        y
        (+ y (myCosh x (+ n 1) nume denom a))))
(doseq
    [i  (map #(- % 10)
        (range 0 21))]
    (do
        (def x  (double i))
        ;����̑o�Ȑ��]���֐�
        (def d1 (myCosh x 1 1.0 1.0 1.0))
        ;�W���̑o�Ȑ��]���֐�
        (def d2 (. Math cosh x))
        ;�W���֐��Ƃ̍���
        (println (format "%3d : %17.10f - %17.10f = %13.10f" i d1 d2 (- d1 d2)))))
