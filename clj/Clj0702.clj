(def N 7)

; 元の関数
(defn f[x]
    (+ (- x (/ (Math/pow x 3.0) (* 3 2))) (/ (Math/pow x 5.0) (* 5 (* 4 (* 3 2))))))

; Neville (ネヴィル) 補間
(defn neville [d x y]
    (def w (cons y nil))
    (doseq [j (range 1 N)]
        (def t_list (list))
        (doseq [i (range 0 (- N j))]
            (def t (nth w 0))
            (def t_list
                (cons
                    (+ (nth t (+ i 1)) 
                       (/ (* (- (nth t (+ i 1)) (nth t i))
                             (- d (nth x (+ i j)))) 
                          (- (nth x (+ i j)) (nth x i))))
                    t_list
                )
            )
        )
        (def w (cons (reverse t_list) w))
    )
    (nth (nth w 0) 0)
)

; 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
(def x (map #(- (* % 1.5) 4.5) (range 0 N)))
(def y (map #(f %) x))

; 0.5刻みで 与えられていない値を補間
(def d1 (map #(- (* % 0.5) 4.5) (range 0 19)))
(def d2 (map #(f %) d1))
(def d3 (map #(neville % x y) d1))

(doseq [d (map list d1 d2 d3)]
    (def d1 (nth d 0))
    (def d2 (nth d 1))
    (def d3 (nth d 2))
    (println (format "%5.2f\t%8.5f\t%8.5f\t%8.5f" d1 d2 d3 (- d2 d3))))
