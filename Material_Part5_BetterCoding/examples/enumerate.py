lunch = ["Pizza", "Salad", "Pasta", "Sushi", "Sandwich"]

# original version

index = 0
for meal in lunch:
    print(index, meal)
    index += 1

# use enumerate function instead

for index, meal in enumerate(lunch):
    print(index, meal)
