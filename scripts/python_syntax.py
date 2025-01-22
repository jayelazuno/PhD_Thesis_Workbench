# python syntax can be executed by writing directly in the command line 
print("Hello, World") # the output is printed to the command line or shell 
# you can also create a python file with an entension .py and run on the command line. This will be useful when there there is the need to automate certain processess further down 
# C:\Users\Your Name>python myfile.py


# python indentation: refers to specific spaces left at the begining of a code
# Indentation in python is important because it indicates blocks of codes 
if 6 > 3:
    print("six is greater than three!")
# the number of space to use is at the descretion of the progrommmer but the most common is 4 spaces, but the space must be at least 1
# you have to use the same number of spaces in the same block of code else python will return syntax error. for example 
if 6 > 3:
    print("six is greater than three!")
else:
    print("the first number is less!")
# if you instead indented as shown below, you will get a syntax error from python 
#if 6 > 3:
   #print("six is greater than three!")
#else:
        #print("the first number is less!")



#Python variables 
# in python a variable is created by assigning value, example
x = 5
y = "Helle, World" # we will get into the details of this later 