(filter #(= (mod  % 3) 0)
    (range 1 10))
(filter #(= (rem  % 3) 0)
    (range 1 10))
