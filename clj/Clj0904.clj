(defn f0[x]
    (- (* x x) 2.0))

(defn f1[x]
    (* 2.0 x))

(defn newton [x0]
    (def x1 (- x0 (/ (f0 x0) (f1 x0))))
    (println (format "%12.10f\t%13.10f" x1 (- x1 (Math/sqrt 2))))

    (if (< (. Math abs (- x1 x0)) 0.00000000001)
        x1
        (newton x1)))

(def x 2.0)
(println (format "%12.10f" (newton x)))
