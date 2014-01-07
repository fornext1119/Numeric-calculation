(1..99).select { |n| n % 3 == 0}.inject(:+)
(1..99).select { |n| n % 3 == 0}.inject("+")
