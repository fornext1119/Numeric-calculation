(defn total [n]
    (if (zero? n) 0
        (if (= (mod n 3) 0)
            (+' n (total (dec n)))
            (total (dec n)))))

(println (total 99))
