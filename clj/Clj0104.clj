(loop [n 1]
    (if (< n 10)
        (if (= (mod n 3) 0)
            (do
                (printf "%d, " n)
                (recur (inc n)))
            (recur (inc n)))
        (println "")))
