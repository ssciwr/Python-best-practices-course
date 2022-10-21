
def ingredients1(ingredient, all_ingredients=[]):
    all_ingredients.append(ingredient)
    print(all_ingredients)


def ingredients2(ingredient, all_ingredients=None):
    if all_ingredients is None:
        all_ingredients = []
    all_ingredients.append(ingredient)
    print(all_ingredients)

def myfunc(a={"b": 0}):
    a["b"] += 5
    print(a)

if __name__=="__main__":
    # method 1
    print(ingredients1.__defaults__)
    ingredients1("flour")
    print(ingredients1.__defaults__)
    ingredients1("sugar")
    print(ingredients1.__defaults__)
    ingredients1("butter")
    # method 2
    print(ingredients2.__defaults__)
    ingredients2("flour")
    print(ingredients2.__defaults__)
    ingredients2("sugar")
    print(ingredients2.__defaults__)
    ingredients2("butter")
    myfunc()
    myfunc()