def Password_Check(newpassword, oldpassword):
   # Check if the new password contains at least one special character
    if not any(char in "!#$%.*&" for char in newpassword):
        print("Your new password must contain a special character!")#
    # Check if the new password is different from the old password
    elif newpassword == oldpassword:
        print("Your new password is the same as your old password!")
    # Check if the new password contains at least one digit
    elif not any(char for char in newpassword if '0' <= char <= '9'):
        print("Your new password must contain a digit!")
    # Check if the new password contains at least one letter
    elif not any(char for char in newpassword if ('a' <= char <= 'z' or 'A' <= char <= 'Z')):
        print("Your new password must contain a letter!")
        # Check if the new password is at least 6 characters long
    elif len(newpassword) < 6:
        print("Your new password is too short!")
    # If all checks pass, accept the new password
    else:
        print("Your new password is good!")

# Testing the function
#Password_Check('E10-s2ff', 'E10.s2ff')
#Password_Check('E10sfc!!!', 'E10sfc!!!!')
Password_Check('E10-s2ff!', 'E10-s2ff!')
#Password_Check('Eejdff', 'E10.s2ff')
#Password_Check('$$$###8', 'E10.s2ff')
#Password_Check('Eej7s', 'E10.s2ff')
#Password_Check('$$$pp8', 'E10.s2ff')