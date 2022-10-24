import numpy as np
import pandas as pd


def read_in(filedir, filename, data_type, myheader=False):
    input_handler = {"numpy": read_numpy, "pandas": read_pandas}
    reading_method = input_handler.get(data_type)
    if not reading_method:
        print("Data type not found!")
        exit()
    data = reading_method(filedir, filename, myheader)
    return data


def read_numpy(filedir, filename, myheader):
    name = "{}{}".format(filedir, filename)
    print("Reading from file {} - numpy".format(name))
    if myheader:
        data = np.loadtxt(name, skiprows=1)
    else:
        data = np.loadtxt(name, skiprows=0)
    data = data.T
    return data


def read_pandas(filedir, filename, myheader):
    name = "{}{}".format(filedir, filename)
    print("Reading from file {} - pandas".format(name))
    data = pd.read_csv(name, sep=r"\s+")
    return data


if __name__ == "__main__":
    read_in("./data/", "efield.t", "numpy", myheader=True)
    read_in("./data/", "npop.t", "pandas")
    read_in("./data/", "npop.t", "foo")
