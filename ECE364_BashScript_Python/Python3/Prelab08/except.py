

__author__ = 'ee364d08'

a = input("Please enter some values: ").split()
sum = 0
for value in a:
	try:
		sum = sum + float(value)
	except:
		pass
	finally:
		pass
print('The sum is:',sum)