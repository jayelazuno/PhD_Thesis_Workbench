"""
python Variables 
python has no command for declaring variable 
A variable is created once you first assign value to it 
"""
print(X)
print(y)
"""
variables can be declared without indicating their type 
"""
z = 7 # is a type of int
k = "Vitus" # is a type of string 

# Casting refers to specifying the type of a variable 
m = str("COME")
c = int(3)
d = float(3)

# you can obtain the type of a variable using the type () function
x = 5
y = "Josh"
print(type(x))
print(type(y))

# single or double quotes: variables can be declared with either 
a = "Emily"
# is the same as 
a = 'Emily'

# Case sensitive: variables are case sensitive 
a = 4 
A = "Frank"
# will create two different variables 

"""
Python variable names:
A variable can have a short name (like x and y) or a more descriptive name (age, carname, total_volume). Rules for Python variables:
A variable name must start with a letter or the underscore character
A variable name cannot start with a number
A variable name can only contain alpha-numeric characters and underscores (A-z, 0-9, and _ )
Variable names are case-sensitive (age, Age and AGE are three different variables)
A variable name cannot be any of the Python keywords https://www.w3schools.com/python/python_ref_keywords.asp.
"""
myvar = "John"
my_var = "John"
_my_var = "John"
myVar = "John"
MYVAR = "John"
myvar2 = "John"
# Multi Words Variable Names
# variables with more than 1 word can be difficult to ready 
# Below are techniques used to make them to easily readable 
# Camel Case: each word except the first is capitalized 
favSoccerTeam = "chelsea"
#snake case: each word is separated by an underscore 
fav_soccer_team = "chelsea"
#Pascal Case: each word is capitalized
FavSoccerTeam = "Chelsea"
