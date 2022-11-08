# original version

f = open("data/efield.t","r")

numbers = f.read()

f.close()

# use context manager instead

with open("data/efield.t","r") as f:
    numbers = f.read()

# for example for threads, databases, etc - for improved resource handling