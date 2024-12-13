# Code formatter
A code formatter takes care of formatting your code so that it adheres to the styling standards. For Python, a popular code formatter is [black](https://black.readthedocs.io/en/stable/). Black is PEP 8 compliant but also adds some [own flavor](https://black.readthedocs.io/en/stable/the_black_code_style/current_style.html) to the code. Comparing code that has been formatted with black makes it easier to spot the differences. You can even try it out [online](https://black.vercel.app/?version=stable&state=_Td6WFoAAATm1rRGAgAhARYAAAB0L-Wj4ARsAnNdAD2IimZxl1N_WlkPinBFoXIfdFTaTVkGVeHShArYj9yPlDvwBA7LhGo8BvRQqDilPtgsfdKl-ha7EFp0Ma6lY_06IceKiVsJ3BpoICJM9wU1VJLD7l3qd5xTmo78LqThf9uibGWcWCD16LBOn0JK8rhhx_Gf2ClySDJtvm7zQJ1Z-Ipmv9D7I_zhjztfi2UTVsJp7917XToHBm2EoNZqyE8homtGskFIiif5EZthHQvvOj8S2gJx8_t_UpWp1ScpIsD_Xq83LX-B956I_EBIeNoGwZZPFC5zAIoMeiaC1jU-sdOHVucLJM_x-jkzMvK8Utdfvp9MMvKyTfb_BZoe0-FAc2ZVlXEpwYgJVAGdCXv3lQT4bpTXyBwDrDVrUeJDivSSwOvT8tlnuMrXoD1Sk2NZB5SHyNmZsfyAEqLALbUnhkX8hbt5U2yNQRDf1LQhuUIOii6k6H9wnDNRnBiQHUfzKfW1CLiThnuVFjlCxQhJ60u67n3EK38XxHkQdOocJXpBNO51E4-f9z2hj0EDTu_ScuqOiC9cI8qJ4grSZIOnnQLv9WPvmCzx5zib3JacesIxMVvZNQiljq_gL7udm1yeXQjENOrBWbfBEkv1P4izWeAysoJgZUhtZFwKFdoCGt2TXe3xQ-wVZFS5KoMPhGFDZGPKzpK15caQOnWobOHLKaL8eFA-qI44qZrMQ7sSLn04bYeenNR2Vxz7hvK0lJhkgKrpVfUnZrtF-e-ubeeUCThWus4jZbKlFBe2Kroz90Elij_UZBMFCcFo0CfIx5mGlrINrTJLhERszRMMDd39XsBDzpZIYV4TcG7HoMS_IF8aMAAAxI-5uTWXbUQAAY8F7QgAAP01Vc6xxGf7AgAAAAAEWVo=).

You first need to install black using
```
pip install black
```
If you installed the packages via the `requirements.txt` file from your assignment repo, then you already have it installed.
You can then use black running it as 
```
black chapter2_3/example1.py
```
Please note that the formatter reformats the file in-place, that means, substituting the content of the original file!

Now you can check with flake8 if the file is compliant with PEP 8:
```
flake8 chapter2_3/example1.py
```
You will notice that flake8 is not returning errors except a line length error for one of the comment lines: Note that black does not reformat comments other than inserting proper whitespace before and after the #.

**Task 3: [GitHub assignment code formatter](https://classroom.github.com/a/nsZ7ryTk)**

**Subtask (i): Reformat `example1.py` and `example2.py` using black. Compare to your own reformatted files from the previous assignemt.**

## Black configuration
Sometimes you only want to check what black would actually reformat. In order to do so, run
```
black chapter2_3//example1.py --diff
```
or
```
black chapter2_3/example1.py --diff --color
```
**Now you should have completed all edits on your assignment repo and should be able to submit the results (if the autograding and CI do not raise any issues).**

## Black with jupyter notebooks
The new versions of black directly allow you to run it on jupyter notebooks,

**Subtask (ii): Try out reformatting notebooks with `example_jupyter.ipynb`.**


## Black with VSCode
If you are using an IDE, specifically [Visual Studio Code](https://code.visualstudio.com/), you can set up black as the default formatter for your `*.py` files. Follow the instructions provided [here](https://dev.to/adamlombard/how-to-use-the-black-python-code-formatter-in-vscode-3lo0).

For more tips and tricks, see [this page](https://code.visualstudio.com/docs/python/editing).