a = 5  # ‰€ 5
d = 3  # Œö· 3
n = 10 # €” 10
p = 1  # Ï

(1..n).each do |i|
    m = a + (d * (i - 1))
    p *= m
end
puts p
