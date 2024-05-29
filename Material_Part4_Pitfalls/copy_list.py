
mylist1 = [1, 2, 3]
mylist2 = mylist1
print("1:", mylist1)
print("2:", mylist2)


mylist2.append(4)
print("1:", mylist1)
print("2:", mylist2)
# both lists now have 4 appended 
# notice that both point to the same physical address
print("id 1:", id(mylist1))
print("id2:", id(mylist2))

# shallow copy
mylist3 = mylist1.copy()
print("3:", mylist3)

mylist3.append("x")
print("1:", mylist1)
print("3:", mylist3)
mylist3[3] = "r"
print("1:", mylist1)
print("3:", mylist3)

# for shallow copies, same reference for list members
for item1, item3 in zip(mylist1, mylist3[0:3]):
    print("id from 1:", id(item1))
    print("id from 3:", id(item3))

# why is it a shallow list? Consider nesting:
shallow_list1 = ["a", "b", [0, 1]]
shallow_list2 = shallow_list1.copy()
print("shallow 1:", shallow_list1)
print("shallow 2:", shallow_list2)
shallow_list1[2][0] = "x"
print("shallow 1:", shallow_list1)
print("shallow 2:", shallow_list2)
# notice that at the nested level both lists have changed
# this is because they are referencing the same physical addresses for the list items
shallow_list1[0] = "z"
print("shallow 1:", shallow_list1)
print("shallow 2:", shallow_list2)

# for this you need a deep copy:
import copy
deep_list1 = copy.deepcopy(shallow_list1)

deep_list1[2][1] = "y"
print(shallow_list1)
print(deep_list1)
for item, item2 in zip(shallow_list1, deep_list1):
    print("id shallow:", id(item))
    print("id deep:", id(item2))
