days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
lunch = ["Pizza", "Salad", "Pasta", "Sushi", "Sandwich"]

# original version

for index, day in enumerate(days):
    print("On {} we offer {} for lunch.".format(day, lunch[index]))


# use zip instead

for day, meal in zip(days, lunch):
    print("On {} we offer {} for lunch.".format(day, meal))

# also works for more than two lists

rating = [5, 4, 3, 2, 1]

for day, meal, number in zip(days, lunch, rating):
    print("On {} we offer {} for lunch and it is rated {}.".format(day, meal, number))

# if you use lists of different lengths, zip will stop after shortest list is exhausted
# for more details check the itertools library