def list_categories(mydict: dict) -> list:
    """Unravel the categories into a list of tuples."""
    mylist = []
    for main_cat_key, main_cat_value in mydict.items():
        for sub_cat_key in main_cat_value.keys():
            mylist.append((main_cat_key, sub_cat_key))
    return mylist