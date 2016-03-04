(defn g[x]
    (+ (/ x 2.0) (/ 1.0 x)))

(defn iterative [x0]
    (def x1 (g x0))
    (println (format "%12.10f\t%13.10f" x1 (- x1 (Math/sqrt 2))))

    (if (< (. Math abs (- x1 x0)) 0.00000000001)
        x1
        (iterative x1)))

(def x 1.0)
(println (format "%12.10f" (iterative x)))
