# Making a new list
print('# Making a new list')
myList = ["apple", "banana", "cherry","lemon","mango","orange"]
print(myList)
# Making an empty list
print('# Making an empty list')
L = []
print(L)
print("\n")

# range
print('# range')
for i in range(5):
    print(i, end=' ')
print("\n")

# Looping through a list by INDEX (position in the list)
print('# Looping through a list by INDEX (position in the list)')
myList = ["apple", "banana", "cherry","lemon","mango","orange"]
for i in range(len(myList)):
  print("index:", i, "item:", myList[i])
print("\n")

# Looping through a list by list ELEMENT
print('# Looping through a list by list ELEMENT')
myList = ["apple", "banana", "cherry","lemon","mango","orange"]
for element in myList:
    print(element, end=" ")
print("\n")

# Inspecting elements of a list on some condition
print('# Inspecting elements of a list on some condition')
L = [-2, -3, 0, 5, 7]
for element in L:
    if element > 0:
        print(element)
print("\n")

# Adding elements to a list
# Append an element at the end of the list
print('# Append an element at the end of the list')
myList = []
print ('Length of list:',len(myList))
myList.append(5)
myList.append(99)
myList.append(0)
myList.append(10)
print ('Length of list:',len(myList))
print (myList)
print("\n")

# Put an element at a given index (position)
print('# Put an element at a given index (position)')
L = [-2, -3, 0, 5, 7]
print(L)
L[2] = "new at position 2"
print (L)
L[0] = "new at position 0"
print (L)
print("\n")

# Removing elements from a list
# Removing the element at the end of the list
print('# Removing the element at the end of the list')
myList = ["apple", "banana", "cherry","lemon","mango","orange"]
print(myList)
print(myList.pop())
print(myList)
print("\n")

# Removing an element by index (position)
print('# Removing an element by index (position)')
myList = ["apple", "banana", "cherry", "lemon", "mango", "orange"]
print(myList)
myList.pop(2)
print(myList)
print("\n")

# Removing a specific element
print('# Removing a specific element')
myList = ["apple", "banana", "cherry", "lemon", "mango", "orange"]
print(myList)
myList.remove("banana")
print(myList)
print("\n")

# Changing list elements
print('# Changing list elements, strings')
# strings
myList = ["apple", "banana", "cherry","lemon","mango","orange"]
for i in range(len(myList)):
  myList[i] = myList[i]+ " checked"
  print("index:", i, "item:", myList[i])
print("\n")

# numbers
print('# Changing list elements, numbers')
L = [100, 200, 300, 400, 500]
print(L)
for i in range(len(L)):
  L[i] = L[i]+ 5
  print("index:", i, "item:", L[i])
print("\n")


# Break out of a loop on a condition
print('# Break out of a loop on a condition')
myList = ["apple", "banana", "cherry","lemon","mango","orange"]
print(myList)
for i in range(len(myList)):
  print("index:", i, "item:", myList[i])
  if i == 3:
      print("when reaching the 4th item, break")
      break
print("Good bye!")

