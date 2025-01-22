# Function 1: echoInput
def echoInput():
    while True:  # Start a while loop to continuously prompt the user
        user_input = int(input("Enter an int number, 999 to quit: "))
        if user_input == 999:  # Check if the user wants to quit
            print("Bye!")
            break  # Exit the loop
        print(f"{user_input} multiplied by 100 is {user_input * 100}")

# Function 2: multiples
def multiples(n, k):
    i = 0  # Start with the 0th multiple
    while i < k:  # Continue until we reach k multiples
        print(i * n)  # Print the current multiple
        i += 1  # Increment the counter

# Function 3: printAscendingRange
def printAscendingRange(low, high, step):
    current = low  # Start with the lower value
    while current < high:  # Continue until the current value is less than high
        print(current)  # Print the current value
        current += step  # Increment the value by step

# Function 4: printDescendingRange
def printDescendingRange(high, low, step):
    current = high  # Start with the higher value
    while current > low:  # Continue until the current value is greater than low
        print(round(current, 1))  # Print the current value rounded to 1 decimal place
        current -= step  # Decrement the value by step

# Sample calls
#echoInput()  # Function 1
#multiples(13, 5)  # Function 2
#printAscendingRange(3, 21, 3)  # Function 3
#printDescendingRange(12, 0, 1.5)  # Function 4


