x = 10

# original version

if x >= 10:
    y = 1
else:
    y = 0

print("Original version {}".format(x))

# use ternary conditionals instead

y = 1 if x >= 10 else 0

print("Pythonic version {}".format(x))