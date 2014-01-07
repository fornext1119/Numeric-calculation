ary = [n for n in range(1, 100) if (n % 3 == 0)]
reduce(lambda x, y: x + y, ary, 0)
sum([n for n in range(1, 100) if (n % 3 == 0)])
