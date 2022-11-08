mylist = [1, 2, 3]
mylist2 = mylist
print(mylist)
print(mylist2)


mylist2.append(4)
print(mylist)
print(mylist2)
# both lists now have 4 appended 
# notice that both point to the same physical address
id(mylist)
id(mylist2)

# shallow copy
mylist3 = mylist.copy()
print(mylist3)

mylist3.append("x")
print(mylist)
print(mylist3)
mylist3[3] = "r"
print(mylist)
print(mylist3)

# why is it a shallow list? Consider nesting:
deeplist = ["a", "b", [0, 1]]
deeplist2 = deeplist.copy()
deeplist[2][0] = "x"
print(deeplist)
print(deeplist2)
# notice that at the nested level both lists have changed
# this is because they are referencing the same physical addresses for the list items:
for item, item2 in zip(deeplist, deeplist2):
    print(id(item))
    print(id(item2))

# for this you need a deep copy:
import copy
deeplist3 = copy.deepcopy(deeplist)

deeplist[2][1] = "y"
print(deeplist)
print(deeplist3)
for item, item2 in zip(deeplist, deeplist3):
    print(id(item))
    print(id(item2))