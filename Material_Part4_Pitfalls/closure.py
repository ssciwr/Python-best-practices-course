def make_multiplier_of(n):
    mylist = []
    for i in n:
        def multiplier(j):
            return i * j
        mylist.append(multiplier)
    return mylist

# generate a multiplier from 1 to 5
times_x = make_multiplier_of(list(range(5)))

# multiply 2 by the multiplier
for times in times_x:
    print(times(2))


# def make_multiplier(n):
#     def multiplier(j):
#         return n * j
#     return multiplier
# 
# # generate a multiplier from 1 to 5
# times_y = [make_multiplier(i) for i in range(5)]
# 
# # multiply 2 by the multiplier
# for times in times_y:
#     print(times(2))
# 