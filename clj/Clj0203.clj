(apply +
    (filter #(= (mod  % 3) 0) 
    (range 1 100)))
(reduce +
    (filter #(= (mod  % 3) 0)
    (range 1 100)))
