
def testNumbers():
    for i in range(3):
        # Get an integer from the user
        n = int(input(f"{i+1}) Please enter a number: "))
        
        # Check the first condition for the first number
        if i == 0:
            # 1) Prime check and multiplied by 2 less than 120
            if n > 1:
                is_prime = True
                j = 2
                while j * j <= n:
                    if n % j == 0:
                        is_prime = False
                        break
                    j += 1
            else:
                is_prime = False

            # Proposition (p) for prime and (q) for n*2 less than 120
            p = is_prime
            q = (n * 2) < 120

            # Print result for prime check
            if p and q:
                print("Number %d is a prime and when multiplied by 2 is less than 120" % n)
            else:
                print("Number %d is NOT a prime that when multiplied by 2 is less than 120" % n)

        # Check the second condition for the second number
        elif i == 1:
            # 2) Divisibility by 17 or 23
            p = (n % 17 == 0) 
            q = (n % 23 == 0) 
            if p or q:
                print(f"Number {n} is divisible by 17 or divisible by 23")
            else:
                print(f"Number {n} is NOT divisible by either 17 or 23")

        # Check the third condition for the third number
        elif i == 2:
            # 3) Even and less than 500 check
            p = (n % 2 == 0)  
            q = (n < 500)     
            if p and q:
                print(f"Number {n} is even and less than 500")
            else:
                print(f"Number {n} is NOT even and less than 500")

# Example of running the function
#if __name__ == "__main__":
    #testNumbers()