numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
average = sum(map(lambda n : n*10, map(lambda n : n+ 5, filter(lambda n : n%2 == 0, numbers)))) / len(numbers)
print(average)