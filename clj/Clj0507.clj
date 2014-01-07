;����̑ΐ��֐�
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
        ;�W���̑ΐ��֐�
        (def d1 (. Math log x))
        ;����̑ΐ��֐�
        (def d2 (myLog (- x 1.0) 27 0.0)) ;27:�K�v�Ȑ��x��������\���傫�Ȋ
        ;�W���֐��Ƃ̍���
        (println (format "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (- d1 d2)))))
