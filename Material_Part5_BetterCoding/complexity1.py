import numpy as np
import pandas as pd


def read_in(filedir, filename, mydatatype, myheader=False):
    if mydatatype == "numpy":
        name = "{}{}".format(filedir, filename)
        print("Reading from file {} - numpy".format(name))
        if myheader:
            data = np.loadtxt(name, skiprows=1)
        else:
            data = np.loadtxt(name, skiprows=0)
        data = data.T
    elif mydatatype == "pandas":
        name = "{}{}".format(filedir, filename)
        print("Reading from file {} - pandas".format(name))
        data = pd.read_csv(name, sep=r"\s+")
    else:
        print("Data type not found!")
        exit()
    return data


if __name__ == "__main__":
    read_in("./data/", "efield.t", "numpy", myheader=True)
    read_in("./data/", "npop.t", "pandas")
    read_in("./data/", "npop.t", "foo")