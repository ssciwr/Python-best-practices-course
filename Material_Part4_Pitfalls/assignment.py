mylist = [1, 2, 3]


def myfunc():
    mylist.append("x")


myfunc()
print(mylist)

mylist2 = [1, 2, 3]


def myfunc2(input_list):
    input_list += "x"

# Interesting... I didn't know that the global scope variable wouldn't be picked up here.

myfunc2(mylist2)
print(mylist2)


def myfunc3():
    mylist3 = "x"
    return mylist3


mylist2 += myfunc3()
print(mylist2)
