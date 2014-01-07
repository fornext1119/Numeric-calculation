sum = 0
(1..99).each do |i|
    if i % 3 == 0
        sum += i
    end
end
puts sum
