# inputs
a = 13
b = 5

# simple condition
if (a > b):
    print (a, "is greater than", b, sep=" ")
else:
    print (a, "is NOT greater than", b, sep=" ")

# compound condition
a = 14
b = 5
if (a > b) and (b == 5):
    print ("(a > b) and (b == 5) is true for a, b with values:", a, b, sep=" ")
else:
     print ("(a > b) and (b == 5) is false for a, b with values:", a, b, sep=" ")

# compound condition
a = 25
b = 78
if (a > b) or (b == 5):
    print ("(a > b) or (b == 5) is true for a, b with values:", a, b, sep=" ")
else:
     print ("(a > b) or (b == 5) is false for a, b with values:", a, b, sep=" ")
    
# compound condition
a = 14
b = 5
c = 23
if (a <= b) and not(b == 5 or c==23):
    print ("(a <= b) and not(b == 5 or c==23) is true for a, b, c with values:", a, b, c, sep=" ")
else:
     print ("(a <= b) and not(b == 5 or c==23) is false for a, b, c with values:", a, b, c, sep=" ")
    
# compound condition
a = 14
b = 55
c = 23
if (a <= b) and not(b == 5 or c < 23):
    print ("(a <= b) and not(b == 5 or c < 23) is true for a, b, c with values:", a, b, c, sep=" ")
else:
     print ("(a <= b) and not(b == 5 or c < 23) is false for a, b, c with values:", a, b, c, sep=" ")
    
