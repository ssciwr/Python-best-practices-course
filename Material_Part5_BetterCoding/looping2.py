example_dict = {
    "catA": {
        "A": "something",
        "B": "something",
        "C": "something",
        "D": "something",
    },
    "catB": {
        "E": "something",
        "F": "something",
        "G": "something",
    },
}


def get_values(mydict, mylist):
    outdict = {}
    for item in mylist:
        outdict[item] = mydict[item[0]][item[1]]
    print(outdict)


def list_categories(mydict: dict) -> list:
    """Unravel the categories into a list of tuples."""
    mylist = []
    for main_cat_key, main_cat_value in mydict.items():
        for sub_cat_key in main_cat_value.keys():
            mylist.append((main_cat_key, sub_cat_key))
    return mylist


if __name__ == "__main__":
    mylist = list_categories(example_dict)
    get_values(example_dict, mylist)
