def listRange(L):
    # Initialize the max and min with the first element of the list
    max_value = L[0]
    min_value = L[0]
    
    # Traverse through the list to find max and min values
    for num in L:
        if num > max_value:
            max_value = num
        if num < min_value:
            min_value = num
    
    # Calculate the difference (range)
    difference = max_value - min_value
    
    # Print the results in the required format
    print("List:", L)
    print("Minimum value:", min_value, "Maximum value:", max_value, "Difference:", difference)
#myList = [26, 22, -6, -19, 27, -12, -6, 9, -10, 21] 
#listRange(myList)
