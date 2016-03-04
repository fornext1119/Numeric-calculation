(def N 4)

(def a [[5.0 2.0 3.0 4.0] [2.0 10.0 6.0 7.0] [3.0 6.0 15.0 9.0] [4.0 7.0 9.0 20.0]])
(def b  [34.0 68.0 96.0 125.0])

;１次元配列を表示
(defn disp_vector [row]
    (doseq [col row]
        (print (format "%14.10f\t" col)))
    (println))

;２次元配列を表示
(defn disp_matrix [matrix]
    (doseq [row matrix]
        (doseq [col row]
            (print (format "%14.10f\t" col)))
        (println)))

;前進消去
(defn forward_elim_loop [pivot col a]
    (def a_map (map 
		(fn [k a_piv a_col] (* (* a_piv a_col) (nth (nth a k) k))) 
			(range 0 col) (take col (nth a pivot)) (take col (nth a col))))
    (def s (if (> (count a_map) 0) (apply + a_map) 0))

    (def a_col (/ (- (nth (nth a pivot) col) s) (nth (nth a col) col)))

    (def a_row (concat (take col   (nth a pivot)) (cons a_col (drop (inc col)   (nth a pivot)))))
    (def a_piv (concat (take pivot (nth a col  )) (cons a_col (drop (inc pivot) (nth a col)))))

    (def a1 (concat (take col   a ) (cons (vec a_piv) (drop (inc col)   a))))
    (def a2 (concat (take pivot a1) (cons (vec a_row) (drop (inc pivot) a))))

    (def next_col
        (if (= (inc col) pivot)
            (inc pivot)
            (inc col)))
            
    (if (< next_col pivot)
        (forward_elim_loop pivot next_col a2)
        a2))

(defn forward_elimination [pivot a]
    (def next_col
        (if (= pivot 0) 1 0))
    (def a1 (forward_elim_loop pivot next_col a))

    (def a_map (map 
		(fn [k col] (* (* col col) (nth (nth a1 k) k))) 
			(range 0 pivot) (take pivot (nth a1 pivot))))
    (def s (apply + a_map))
    (def a_col (- (nth (nth a1 pivot) pivot) s))

    (def a_row (concat (take pivot (nth a1 pivot)) (cons a_col (drop (inc pivot) (nth a1 pivot)))))
    (def a2    (concat (take pivot a1)             (cons a_row (drop (inc pivot) a1))))

    (if (< pivot (dec N))
        (forward_elimination (inc pivot) a2)
        a2))

;前進代入
(defn forward_substitution [row a b]
    (def a_map (map (fn [a_col b_col] (* a_col b_col)) (take row (nth a row)) b))
    (def s (apply + a_map))
    (def y (- (nth b row) s))
    (def b2 (concat (take row b) (cons y (drop (inc row) b))))
    (if (< row (dec N))
        (cons y (forward_substitution (inc row) a b2))
        (cons y [])))

;後退代入
(defn backward_substitution [row a b]
    (def a_map (map 
		(fn [a_col b_col] (* (* a_col b_col) (nth (nth a row) row))) 
			(drop (inc row) (nth a row)) (drop (inc row) b)))
    (def s (apply + a_map))
    (def x (/ (- (nth b row) s) (nth (nth a row) row)))
    (def b2 (concat (take row b) (cons x (drop (inc row) b))))
    (if (> row 0)
        (cons x (backward_substitution (dec row) a b2))
        (cons x [])))

(println "A")
(disp_matrix a)
(println "B")
(disp_vector b)
(println "")

;前進消去
(def a2 (forward_elimination 0 a))

(println "LDL^T")
(disp_matrix a2)

;Ly=b から y を求める (前進代入)
(def y (forward_substitution 0 a2 b))

(println "Y")
(disp_vector y)

;DL^Tx=y から x を求める (後退代入)
(def x (backward_substitution (dec N) a2 y))

(println "X")
(disp_vector (reverse x))
