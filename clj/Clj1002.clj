(def N 4)

(def a [[9.0 2.0 1.0 1.0] [2.0 8.0 -2.0 1.0] [-1.0 -2.0 7.0 -2.0] [1.0 -1.0 -2.0 6.0]])
(def b  [20.0 16.0 8.0 17.0])
(def x0 [0.0 0.0 0.0 0.0])

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

;ガウス・ザイデル法
(defn row_loop [row a b x0 x1]
    (def a1 (map (fn [a b] [a b]) (nth a row) x0))
    (def a2 (concat (take row a1) (drop (+ row 1) a1)))
    (def a3 (map (fn [x] (* (first x) (second x))) a2))
    (def s  (apply + a3))
    (def x  (/ (- (nth b row) s) (nth (nth a row) row)))
    (def xs (cons x x1))
    (def x2 (concat (take (inc row) (reverse xs)) (drop (inc row) x0)))

    (if (>= row (- N 1)) 
        (reverse xs)
        (row_loop (inc row) a b x2 xs)))

(defn gauss [a b x0 xs]
    (def x1 (row_loop 0 a b x0 []))

    (def cnt (count 
        (filter (fn [x] (>= x 0.0000000001))
            (map (fn [x] (. Math abs (- (first x) (second x)))) 
                (map (fn [a b] [a b]) x0 x1)))))

    (if (< cnt 1)
        (vector (reverse xs) x1)
        (gauss a b x1 (cons x1 xs))))

;ガウス・ザイデル法
(def xs (gauss a b x0 []))

(disp_matrix (first xs))
(println "X")
(disp_vector (second xs))
