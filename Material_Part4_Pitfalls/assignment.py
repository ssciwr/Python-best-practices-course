
mylist = [1, 2, 3]

def myfunc():
    mylist.append("x")

myfunc()
print(mylist)

mylist2 = [1, 2, 3]

def myfunc2():
    mylist2 += "x"

# myfunc2()
print(mylist2)

def myfunc3():
    mylist3 = "x"
    return mylist3

mylist2 += myfunc3()
print(mylist2)