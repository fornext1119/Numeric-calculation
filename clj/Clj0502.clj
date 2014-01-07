;����̗]���֐�
(defn myCos [x n nega numerator denominator y]
    (def m     (* 2 n))
    (def denom (* denominator (* m (- m 1))))
    (def nume  (* numerator (* x x)))
    (def a     (/ nume denom))
    ;�\���Ȑ��x�ɂȂ����珈���𔲂���
    (if (<= a 0.00000000001)
        y
        (+ y (myCos x (+ n 1) (not nega) nume denom (if nega a (- a))))))
(doseq
    [degree (filter #(or (= (mod % 30) 0) 
                         (= (mod % 45) 0))
            (map    #(* % 15)
            (range 0 25)))]
    (do
        (def radian (/ (* degree (. Math PI)) 180.0))
        ;����̗]���֐�
        (def d1     (myCos radian 1 false 1.0 1.0 1.0))
        ;�W���̗]���֐�
        (def d2     (. Math cos radian))
        ;�W���֐��Ƃ̍���
        (println (format "%3d : %13.10f - %13.10f = %13.10f" degree d1 d2 (- d1 d2)))))
