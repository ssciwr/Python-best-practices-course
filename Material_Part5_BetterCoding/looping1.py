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


def get_values(mydict):
    outdict = {}
    for main_cat_key, main_cat_value in mydict.items():
        for sub_cat_key, sub_cat_value in main_cat_value.items():
            outdict[(main_cat_key, sub_cat_key)] = sub_cat_value
    print(outdict)


if __name__ == "__main__":
    get_values(example_dict)
