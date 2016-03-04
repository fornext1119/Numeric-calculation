;����̎w���֐�
(defn myExp [x x2 n t]
    (def denom (/ x2 (+ n t)))
    (def nume  (- n 4))
    (if (< nume 6)
        (+ 1.0 (/ (* 2.0 x) (+ (- 2.0 x) denom)))
        (myExp x x2 nume denom)))
(doseq
    [x  (map #(/ (- % 10) 4.0)
        (range 0 20))]
    (do
        ;�W���̎w���֐�
        (def d1 (. Math exp x))
        ;����̎w���֐�
        (def x2 (* x x))
        ;�W���֐��Ƃ̍���
        (def d2 (myExp x x2 30 0.0)) ;30:�K�v�Ȑ��x��������悤, 6����n�߂�4������������
        (println (format "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (- d1 d2)))))
