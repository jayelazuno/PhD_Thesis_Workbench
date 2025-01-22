def py_conditionals():
    user_temp = int(input("Enter today's temperature in F: ")) 
    if user_temp > 130:
        print(str(user_temp) + " F - Too high temperature")
    elif 71 <= user_temp <= 130:
        print(str(user_temp) + " F - Enjoy playing outdoors!")
    elif 33 <= user_temp <= 70:
        print(str(user_temp) + " F - Above freezing ...")
    elif 1 <= user_temp <= 32:
        print(str(user_temp) + " F - Freezing temperature ...")
    else:
        print(str(user_temp) + " F - Zero or negative temperature ...")
    user_age = int(input("Enter your age: ")) 
    next_age = user_age + 1
    print("You will be " + str(next_age) + " next year!")
    if user_age >= 18:
        print("You can vote this year.")
    else:
        print("You can't vote this year.")
    user_year = int(input("What year was your grandmother born?: "))
    if user_year % 4 == 0 and (user_year % 100 != 0 or user_year % 400 == 0):
        print("Your grandmother was born in a leap year.")
    else:
        print("Your grandmother was NOT born in a leap year.")
    user_name1 = input("Enter the first name: ").strip()
    user_name2 = input("Enter the second name: ").strip()
    if user_name1.lower() == user_name2.lower():
        print("Both names are equal in the alphabetical order")
    elif user_name1.lower() < user_name2.lower():
        print(user_name1 + " precedes " + user_name2 + " in the alphabetical order")
    else:
        print(user_name1 + " succeeds " + user_name2 + " in the alphabetical order")
py_conditionals()