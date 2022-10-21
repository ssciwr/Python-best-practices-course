def make_multiplier_of(n):
    mylist = []
    for i in n:
        def multiplier(j):
            return i * j
        mylist.append(multiplier)
    return mylist

times_x = make_multiplier_of(list(range(5)))

for times in times_x:
    print(times(2))