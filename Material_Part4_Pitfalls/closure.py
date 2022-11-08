def make_multiplier_of(n):
    mylist = []
    for i in n:

        def multiplier(j):
            return i * j

        mylist.append(multiplier)
    return mylist


def make_multiplier_of_A(n):
    from functools import partial
    mylist = []
    for i in n:

        def multiplier(factor1, factor2):
            return factor1 * factor2

        mylist.append(partial(multiplier, i))
    return mylist


# Question: Does partial do something like below?
def make_multiplier_of_B(n):
    mylist = []
    for i in n:
        def multiplier(factor1):
            def multiply(factor2):
                return factor2 * factor1
            return multiply

        mylist.append(multiplier(i))
    return mylist


def make_multiplier_of_C(n):
    for i in n:

        def multiplier(j):
            return i * j

        yield multiplier
# Question: Are there other solutions?


# times_x = make_multiplier_of(list(range(5)))
# times_x = make_multiplier_of_A(list(range(5)))
# times_x = make_multiplier_of_B(list(range(5)))
times_x = make_multiplier_of_C(list(range(5)))

for times in times_x:
    print(times(2))
# I guess the expected outcome would be 2*n, i.e. 0, 2, 4, 6, 8?
