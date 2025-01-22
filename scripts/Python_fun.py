# 1. Function UserInputReturns
def UserInputReturns():
    user_input = input("Please enter a string of characters:")
    length = len(user_input)
    # Print both messages directly
    return("The length of the string is " + str(length))

# 2. Function ParameterReturns
def ParameterReturns(s):
    # Convert the input string to upper case
    upper_case = s.upper()
    # Return the formatted message
    return("String converted to upper case is " + upper_case)

# 3. Function UserInputPrints
def UserInputPrints():
    user_input = input("Please enter a string of characters:")
    capitalized = user_input.capitalize()
    print("The string capitalized is " + capitalized)

# 4. Function ParameterPrints
def ParameterPrints(s):
    first_letter = s[0]
    # Print both messages as required, formatted to match the output
    print("The first letter of the string is " + first_letter)
print(UserInputReturns())  # Example input: "Good day!"
print(ParameterReturns('string of characters'))  # Example input: "string of characters"
UserInputPrints()  # This function remains unchanged as it passed.
ParameterPrints('Chocolate')  # Example input: "Chocolate"


