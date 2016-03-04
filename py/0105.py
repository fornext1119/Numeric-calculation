sum = 0
for i in range(1, 100):
    if i % 3 == 0:
        sum += i
print sum

sum = 0
for i in range(1, 100):
    sum += i if i % 3 == 0 else 0
print sum
