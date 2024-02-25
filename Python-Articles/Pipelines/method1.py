# Define a numbers list :
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
odd = []
for n in numbers :
    if n%2 == 0:
        odd.append(n)
multiplied = []
for n in odd:
    multiplied.append(n*10)
added = []
for n in multiplied:
    added.append(n+5)
total = 0
count = 0
for n in added:
    total+=n
    count+=1
average = total / count
print(average)