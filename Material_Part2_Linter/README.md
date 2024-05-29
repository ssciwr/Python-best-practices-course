# Linter
A code linter is there to highlight issues with the code that do not conform with a style guide, and that may lead to errors when interpreted or compiled. For Python, a code linter makes sure that the code conforms with PEP 8 standards.


## Flake8
We will be using [flake8](https://flake8.pycqa.org/en/latest/), a popular linter for Python code.  

First, you need to install flake8. You can do so by typing  
```
pip install flake8
```
in your terminal. All of this will be demonstrated in the course. You can then invoke the linter using
```
flake8 path/to/code/to/check.py
# or
flake8 path/to/code/
```
in your terminal.

## Flake8 messages
Flake8 will return error messages if your code does not adhere to the styling recommendation. You can find a list of all error codes [here](https://flake8.pycqa.org/en/latest/user/error-codes.html).

If you run flake8 on `example1.py`, you will get a list of error messages such as
```
Material_Part2_Linter/example1.py:6:1: E303 too many blank lines (3)
Material_Part2_Linter/example1.py:7:1: E302 expected 2 blank lines, found 3
Material_Part2_Linter/example1.py:7:65: E251 unexpected spaces around keyword / parameter equals
Material_Part2_Linter/example1.py:7:67: E251 unexpected spaces around keyword / parameter equals
Material_Part2_Linter/example1.py:11:80: E501 line too long (166 > 79 characters)
Material_Part2_Linter/example1.py:27:11: E225 missing whitespace around operator
Material_Part2_Linter/example1.py:32:18: W291 trailing whitespace
Material_Part2_Linter/example1.py:34:1: E305 expected 2 blank lines after class or function definition, found 1
Material_Part2_Linter/example1.py:34:12: E225 missing whitespace around operator
Material_Part2_Linter/example1.py:36:41: W292 no newline at end of file
```
Flake8 tells you which line the error occurs (for example, line 6) and at which position in that line (for example, position 1), and then report the error code (E303) and the error type (too many blank lines - in the example it also tells that it found (3) blank lines).

Armed with this information, you can then navigate to the position in your code and correct the issues. 

You can also select to report specific errors only:
```
flake8 --select E305 Material_Part2_Linter/example1.py
```
this will return 
```
Material_Part2_Linter/example1.py:32:1: E305 expected 2 blank lines after class or function definition, found 1
```
Or you can ask flake8 to ignore specific errors:
```
flake8 --ignore E305 Material_Part2_Linter/example1.py
```
This will report all errors other than E305. More than one error code is ignored using
```
flake8 --ignore E303,E305 Material_Part2_Linter/example1.py
```
**Task 1: Try out all the commands and familiarize yourself with the output.**

## Configuring flake8
In some cases, you may want to ignore flake8 errors or set limits differently, for example if you want to increase your line length to 120. You can reconfigure flake8 in a [number of different ways](https://flake8.pycqa.org/en/latest/user/configuration.html), and we will be using a flake8 configuration file. 

In order to do so, place a `.flake8` file in the root of your folder. The top of the file contains the line `[flake8]` - see [the example](https://github.com/ssciwr/Python-best-practices-course/blob/main/.flake8). A list of ignored errors can be included following the `ignore` option.

If you want to ignore additional errors to the ones specified in your flake8 configuration file, use `extend-ignore` (instead of `ignore`) when invoking flake8 (just using `ignore` will overwrite the specifications in your .flake8 configuration).
```
flake8 --extend-ignore E305 Material_Part2_Linter/example1.py
```

A good `.flake8` file will look like this:
```
[flake8]
extend-ignore = E203
exclude =
    .git,
    __pycache__,
    docs/source/conf.py,
    old,
    build,
    dist
max-complexity = 10
```
This uses `extend-ignore` not to overwrite previously defined options, and excludes directories for the linter to parse - so you can invoke flake8 on your complete package / source folder instead of selecting each file manually:
```
flake8 Material_Part1_PEP
```
**Task 2: Run the linter on your previously formatted code from the last chapter to see if you have missed anything.**

**Bonustask: Run the linter on [example4.py](https://github.com/ssciwr/Python-best-practices-course/blob/main/Material_Part2_Linter/example4.py).** 

## Flake8 for jupyter notebooks
To lint your jupyter notebooks using flake8, install the [modified version](https://github.com/s-weigand/flake8-nb) using
```
pip install flake8-nb
```
To run flake8-nb, simply execute
```
flake8-nb Material_Part2_Linter/example_jupyter.ipynb
```
or any other file name or path (if you just provide a path, all python source and notebook files in the given directory will be checked).

### Default reporting of flake8-nb
The default reporting of issues with flake8-nb is by referencing the execution count. So if an issue is highlighted in executed cell #2, then flake8-nb will report it as
```
Material_Part2_Linter/example_jupyter.ipynb#In[2]:1:1: E265 block comment should start with '# '
```
The `[2]` refers to the execution count cell #2, and the following two numbers `[2]:1:1:` are the line and position number (so line 1, first position on that line).

If you have not executed any of the cells (so your notebook kernel is clean and also all output has been cleared/not yet been generated), then the reporting will show an empty 
```
[ ]
```
.

### Custom reporting of flake8-nb

If you prefer to instead get the code cell count number (which can be more intuitive), then you need to run
```
flake8_nb --notebook-cell-format '{nb_path}:code_cell#{code_cell_count}' Material_Part2_Linter/example_jupyter.ipynb 
```
which will result in 
```
Material_Part2_Linter/example_jupyter.ipynb:code_cell#2:1:1: E265 block comment should start with '# '
```
for the same error. `#2:1:1` refers to cell #2, line 1 and position 1.

### Setup file for flake8-nb
As flake8-nb is basically an extension for flake8, you can also provide a configuration file for the notebook linting. This file will be called `.flake8_nb`. For example, if you want to set the custom reporting for all the files in your repo, you would put
```
[flake8_nb]
notebook_cell_format = '{nb_path}:code_cell#{code_cell_count}'
```
in that file. Similarly, you can provide all the same options as in the `.flake8` configuration file. 

**Task 3: Familiarize yourself with `flake8-nb`.**