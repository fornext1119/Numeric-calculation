(loop [n 1]
    (if (< n 10)
        (do 
            (printf "%d, " n)
            (recur (inc n)))
        (println "")))
