import time
from datetime import datetime


def ingredients1(ingredient, all_ingredients=[]):
    all_ingredients.append(ingredient)
    print(all_ingredients)


def ingredients2(ingredient, all_ingredients=None):
    if all_ingredients is None:
        all_ingredients = []
    all_ingredients.append(ingredient)
    print(all_ingredients)


def display_time(time_to_print=datetime.now()):
    print(time_to_print.strftime('%B %d, %Y %H:%M:%S'))


def myfunc(a={"b": 0}):
    a["b"] += 5
    print(a)


if __name__=="__main__":
    # method 1
    # a list is mutable
    # print(ingredients1.__defaults__)
    ingredients1("flour")
    # print(ingredients1.__defaults__)
    ingredients1("sugar")
    # print(ingredients1.__defaults__)
    ingredients1("butter")
    # method 2
    # None is not mutable
    # print(ingredients2.__defaults__)
    ingredients2("flour")
    # print(ingredients2.__defaults__)
    ingredients2("sugar")
    # print(ingredients2.__defaults__)
    ingredients2("butter")
    # a dictionary is mutable
    myfunc()
    myfunc()
    # display_time()
    # default argument only evaluated once
    # print(display_time.__defaults__)
    # time.sleep(1)
    # display_time()






