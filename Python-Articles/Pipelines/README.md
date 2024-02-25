# What is a Pipeline :
- A pipeline is a way of organizing a series of operations or functions that process some data.
- The output of one operation becomes the input of the next one, and so on, until the final result is obtaines.
- A pipeline can be visualized as a chain of pipes, where the data flows from one pipe to another, undergoing some transformation or manipulation along the way.
- For example, suppose you have a list of numbers and you want to perform the following operations on them :
    a. Filter out the odd numbers
    b. Multiply each number by 10
    c. Add 5 to each number
    d. Calculate the average of the resulting numbers.

## Method 1 :
- One way to do this is to write a loop that iterates over the list and applies each operation one by one, storing the intermediate results in a new list. Refer [method1.py](https://github.com/yateesh-chandra-duggirala/Tech-Articles/blob/python-article/Python-Articles/Pipelines/method1.py) file
- Actually this code works, but it is not very elegant or efficient. It creates three new lists, which takes up memory and make the code less readable, which requires writing 4 loops,  which can be tedious and error-prone.

## Method 2 :
- A better way to do this is to use a pipeline.
- A pipeline allows you to chain the operations together, without creating intermediate lists or loops.
- You can use the built-in map and filter functions, which take a function and an iterable as arguments, and return a new iterable that applies the function to each element of the original iterable.
- You can also use the sum and len functions, which calculate the sum and the length of an iterable, respectively.
- Refer the [method2.py](https://github.com/yateesh-chandra-duggirala/Tech-Articles/blob/python-article/Python-Articles/Pipelines/method2.py) file
- This code is much shorter and simpler than the previous one.
- It does not create any new lists or loops and it is easy to see the flow of data from one operation to the next.
- However, It is still not very readable, as it uses nested map and filter calls, which can be confusing and hard to follow.

## Method 3:
- A more readable way to write a pipeline is to use the pipe function from the toolz library.
- The pipe function takes an initial value and a series of functions, and applies each function to the output of the previous one, returning the final result.
- Refer [Method3.py](https://github.com/yateesh-chandra-duggirala/Tech-Articles/blob/python-article/Python-Articles/Pipelines/method3.py) file
- This code is much more readable and elegant than the previous ones. It clearly shows the sequence of operations that are applied to the data, and it does not use any nested calls or intermediate lists.
- The pipe function makes the code look like a pipeline, where the data flows from one function to the next.

## Why use pipelines :
Pipelines have several advantages over other ways of organizing code. Some of them are :
1. Readability : Pipelines make the code mroe readable and understandable as they show the flow of data from one operation to the next, without cluttering the code with intermediate variables or loops. Pipelines also make the code more modular and reusable, as each operation can be defined as a seperate function that can be easily tested and reused in different contexts.
2. Efficiency : Pipelines can improve the efficiency of the code, as they avoid creating intermediate lists or iterables that take up memory and slow down the execution. Pipelines also allow for lazy evaluation, which means that the operations are only executed when the data is needed, and not before. This can save time and resources, especially when dealing with large or infinite data sources.
3. Flexibility : Pipelines can be easily modified or extended, as they allow for adding, removing or changing the ordert of the operations without affecting the rest of the code. Pipelines also support different types of operations, such as filtering, mapping, reducing, aggregating, grouping, sorting, etc., which can be combined in various ways to achieve different results.

## How to use Pipelines in Python :
There are different ways to create and use pipelines in python. Some of them are :

1. Using Built-in Functions : Python provides several built-in functions that can be used to create pipelines, such as map, filter, reduce, zip, enumerate, sorted, reversed, etc. These functions take a function and an iterable as arguments and return a new iterable that applies the function to each element of the original iterable.
2. Using list comprehensions : List Comprehensions are a concise and expressive way to create lists in Python, by using a syntax that resembles mathematical notation. List Comprehensions can also be used to create pipelines, by applying a series of operations to each element of an iterable and collecting the results in a new list.
3. Using Generator expressions : Generator expressions are similar to list comprehensions, but they return a generator object instead of a list. A generator object is an iterable that produces the elements on demand, without storing them in memory. Generator expressions can also be used to create pipelines, by applying a series of operations to each element of an iterable and yielding the results as a generator.
