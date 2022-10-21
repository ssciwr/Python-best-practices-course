

print("This will always be printed.")

def print_name():
    print("Module one is {}".format(__name__))

if __name__ == "__main__":
    print("Runs as main")
    print_name()
else:
    print("Runs as import")
    print_name()