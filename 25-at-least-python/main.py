import math
import numpy as np
import matplotlib.pyplot as plt

print 'Calculate e using fibonnaci aproximation'
print 'Hello, I am e! ' + str(math.e)
print ''

# def fib(n):
# 	if n == 1:
# 		return 1
# 	elif n == 2:
# 		return 1
# 	else:
# 		return fib(n-1) + fib(n-2)

# def fib_yield():
# 	n = [1,0]
# 	while True:
# 		y = sum(n)
# 		n.append(sum(n))
# 		n.pop(0)
# 		yield y

def e_yield():
	n = [1.0, 1.0]
	while True:
		print(n)
		e = n[0]/n[1]
		n.append(sum(n))
		n.pop(0)
		yield 1/e


x = range(100)
y = []
e = e_yield()
for i in x:
	y.append(e.next())

plt.plot(x, y, 'bo')
plt.xscale('log', nonposy='clip')
plt.show()
