
mylist = [1, 2, 3]

# mylist is global variable because it is not assigned
# inside the function
def myfunc():
    mylist.append("x")

print("Original mylist:", mylist)
myfunc()
print("Mylist is now:", mylist)

####################################################
mylist2 = [1, 2, 3]

# mylist2 is global variable and directly passed to the function
def myfunc2(mylist2):
    mylist2 += "x"

print("Original mylist2:", mylist2)
myfunc2(mylist2)
print("Mylist2 is now:", mylist2)

####################################################
mylist3 = [1, 2, 3]

# mylist3 is local variable because it is assigned locally
def myfunc3():
    mylist3 = "x"
    print("Inner scope:", mylist3)


print("Original mylist3:", mylist3)
myfunc3()
print("Mylist3 is now (outer scope):", mylist3)
