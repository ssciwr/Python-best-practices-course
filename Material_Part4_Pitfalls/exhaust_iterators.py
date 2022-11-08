days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
lunch = ["Pizza", "Salad", "Pasta", "Sushi", "Sandwich"]

# menu = zip(days, lunch)
menu = list(zip(days, lunch))

print(list(menu))

empty_iterator = True
for item in menu:
    print("On {} we offer {} for lunch.".format(item[0], item[1]))
    empty_iterator = False
if empty_iterator:
    print("Nothing for lunch today :(")
