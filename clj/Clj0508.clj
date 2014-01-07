;����̑o�Ȑ������֐�
(defn mySinh [x n numerator denominator y]
    (def m     (* 2 n))
    (def denom (* denominator (* (+ m 1) m)))
    (def nume  (* numerator (* x x)))
    (def a     (/ nume denom))
    ;�\���Ȑ��x�ɂȂ����珈���𔲂���
    (if (<= (. Math abs a) 0.00000000001)
        y
        (+ y (mySinh x (+ n 1) nume denom a))))
(doseq
    [i  (map #(- % 10)
        (range 0 21))]
    (do
        (def x  (double i))
        ;����̑o�Ȑ������֐�
        (def d1 (mySinh x 1 x 1.0 x))
        ;�W���̑o�Ȑ������֐�
        (def d2 (. Math sinh x))
        ;�W���֐��Ƃ̍���
        (println (format "%3d : %17.10f - %17.10f = %13.10f" i d1 d2 (- d1 d2)))))
