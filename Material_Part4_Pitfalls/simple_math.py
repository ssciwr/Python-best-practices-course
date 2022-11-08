from math import radians, sin

# Question: I was surprised that this threw an error in the mutable_default.py,
# because apparently the import issue came up while importing datetime, which in turn imported math.
# Does this mean generally that, if I happen to name a local module like a package imported by some of my imports, this will result in an error?
rads = radians(90)

print(sin(rads))
