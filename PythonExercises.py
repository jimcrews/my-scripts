#!/usr/bin/env python3
"""                                                
Author:  Jim Crews
Purpose: Questions
"""

'''
Question:
Write a program which will find all such numbers which are divisible by 7 but are not a multiple of 5,
between 2000 and 3200 (both included).
The numbers obtained should be printed in a comma-separated sequence on a single line.

Hints: 
Consider use range(#begin, #end) method
'''

# Solution
############################################


def question_1():

    res = []

    def is_div7(n, k):
        if n % k == 0:
            return True

    x = range(2000, 3200)
    for n in x:
        if is_div7(n, 7) and not is_div7(n, 5):
            res.append(n)

    print(res)

# question_1()
############################################


'''
Question:
Write a program which can compute the factorial of a given numbers.
The results should be printed in a comma-separated sequence on a single line.
Suppose the following input is supplied to the program:
8
Then, the output should be:
40320

Hints:
The factorial of a number is the product of all the integers from 1 to that number.

For example, the factorial of 6 is 1*2*3*4*5*6 = 720. Factorial is not defined for negative numbers, and the factorial of zero is one.
'''

# Solution 1
############################################


def question_2(n):
    res = 1
    x = range(1, n+1)
    for i in x:
        res = res * i

    print(res)

# question_2(6)
############################################

# Solution 2 - using recursion
############################################


def question_2_2(n):

    def fac(x):
        if x == 0:
            return 1
        return x * fac(x-1)

    print(fac(n))

# question_2_2(6)
############################################


'''
Question:
With a given integer number n, write a program to generate a dictionary that contains (i, i*i) such that is an whole number between 1 and n (both included). 
and then the program should print the dictionary.
Suppose the following input is supplied to the program:
8
Then, the output should be:
{1: 1, 2: 4, 3: 9, 4: 16, 5: 25, 6: 36, 7: 49, 8: 64}

Hints:
Consider use dict()
'''

# Solution
############################################


def question_3(n):
    d = {}
    x = range(1, n+1)
    for i in x:
        d[i] = i*i

    print(d)

# question_3(8)
############################################


'''
Question:
Write a program which accepts a sequence of comma-separated numbers from console and generate a list and a tuple which contains every number.
Suppose the following input is supplied to the program:
34,67,55,33,12,98
Then, the output should be:
['34', '67', '55', '33', '12', '98']
('34', '67', '55', '33', '12', '98')

Hints:
tuple() method can convert list to tuple
'''

# Solution
############################################


def question_4(num_string):
    arr = num_string.split(',')

    tup = tuple(arr)
    print(arr)
    print(tup)


# question_4("34,67,55,33,12,98")
############################################

'''
Question:
Define a class which has at least two methods:
getString: to get a string from console input
printString: to print the string in upper case.
Also please include simple test function to test the class methods.

Hints:
Use __init__ method to construct some parameters
'''

# Solution
############################################


def question_5():
    class myClass:

        def __init__(self):
            self.myString = ''    # instance variable unique to each instance

        def getString(self):
            print('Enter input string: ')
            self.myString = input()

        def printString(self):
            return self.myString.upper()

    c = myClass()
    c.getString()
    print(c.printString())


# question_5()
############################################

'''
Question:
Write a program that calculates and prints the value according to the given formula:
Q = Square root of [(2 * C * D)/H]
Following are the fixed values of C and H:
C is 50. H is 30.
D is the variable whose values should be input to your program in a comma-separated sequence.

Example
Let us assume the following comma separated input sequence is given to the program:
100,150,180
The output of the program should be:
18,22,24

Hints:
If the output received is in decimal form, it should be rounded off to its nearest value (for example, if the output received is 26.0, it should be printed as 26)
In case of input data being supplied to the question, it should be assumed to be a console input. 
'''

# Solution
############################################


def question_6(arr):
    import math
    c = 50
    h = 30

    res = []
    for i in arr:
        res.append(round(math.sqrt((2 * c * i) / h)))

    print(res)

# question_6([100,150,180])
############################################


'''
Question:
Write a program which takes 2 digits, X,Y as input and generates a 2-dimensional array. 
The element value in the i-th row and j-th column of the array should be i*j.
Note: i=0,1.., X-1; j=0,1,¡­Y-1.
Example
Suppose the following inputs are given to the program:
3,5
Then, the output of the program should be:
[[0, 0, 0, 0, 0], [0, 1, 2, 3, 4], [0, 2, 4, 6, 8]] 
'''

# Solution
############################################


def question_7(x, y):
    import numpy
    arr = numpy.zeros((x, y))

    for row in range(0, x):
        for col in range(0, y):
            arr[row, col] = row*col

    print(arr)

#question_7(3, 5)
############################################


'''
Question 8:
Write a program that accepts a comma separated sequence of words as input and prints the words in a comma-separated sequence after sorting them alphabetically.
Suppose the following input is supplied to the program:
without,hello,bag,world
Then, the output should be:
bag,hello,without,world
'''

# Solution
############################################


def question_8(myString):
    myStrings = myString.split(',')
    print(sorted(myStrings))


# question_8('without,hello,bag,world')
############################################

'''
Question 9:
Write a program that accepts sequence of lines as input and prints the lines after making all characters in the sentence capitalized.
Suppose the following input is supplied to the program:
Hello world
Practice makes perfect
Then, the output should be:
HELLO WORLD
PRACTICE MAKES PERFECT
'''

# Solution
############################################


def question_9():
    lines = []
    print('Enter Multi Line text ->')
    while True:
        line = input()
        if line:
            lines.append(line)
        else:
            break
    text = '\n'.join(lines)
    print(text.upper())

# question_9()
############################################


'''
Question 10:
Write a program that accepts a sequence of whitespace separated words as input and prints the words after removing all duplicate words and sorting them alphanumerically.
Suppose the following input is supplied to the program:
hello world and practice makes perfect and hello world again
Then, the output should be:
again and hello makes perfect practice world

Hints:
In case of input data being supplied to the question, it should be assumed to be a console input.
We use set container to remove duplicated data automatically and then use sorted() to sort the data.
'''

# Solution
############################################


def question_10(st):
    words = st.split(' ')
    s = set(words)
    print(sorted(s))


#question_10('hello world and practice makes perfect and hello world again')
############################################


'''
Question 11:
Write a program which accepts a sequence of comma separated 4 digit binary numbers as its input and then check whether they are divisible by 5 or not. 
The numbers that are divisible by 5 are to be printed in a comma separated sequence.
Example:
0100,0011,1010,1001
Then the output should be:
1010

Decimal: 	0 	1 	2 	3 	4 	    5 	    6 	    7 	    8 	    9 	    10  	11 	    12 	    13 	    14 	    15
Binary: 	0 	1 	10 	11 	100 	101 	110 	111 	1000 	1001 	1010 	1011 	1100 	1101 	1110 	1111

'''

# Solution 11
############################################


def question_11(str):

    answers_arr = []
    binary_str_arr = str.split(',')

    def convert_binary(binary):
        res = 0
        for idx, val in enumerate(binary):
            if idx == 0 and val == '1':
                res = res + 8
            elif idx == 1 and val == '1':
                res = res + 4
            if idx == 2 and val == '1':
                res = res + 2
            elif idx == 3 and val == '1':
                res = res + 1
        return res

    for b in binary_str_arr:
        dec = convert_binary(b)
        if dec % 5 == 0:
            answers_arr.append(b)

    print(answers_arr)


# question_11('0100,0011,1010,1001')
############################################


'''
Question 12:

Write a program, which will find all such numbers between 1000 and 3000 (both included) such that each digit of the number is an even number.
The numbers obtained should be printed in a comma-separated sequence on a single line.
'''

# Solution 12
############################################


def question_12():

    ans_array = []

    for row in range(1000, 3001):
        if row % 2 == 0:
            ans_array.append(row)

    print(ans_array)


# question_12()
############################################

'''
Question 13:

Write a program that accepts a sentence and calculate the number of letters and digits.
Suppose the following input is supplied to the program:
hello world! 123
Then, the output should be:
LETTERS 10
DIGITS 3
'''
