# Linter
A code linter is there to highlight issues with the code that do not conform with a style guide, and that may lead to errors when interpreted or compiled. For python, a code linter makes sure that the code conforms with PEP 8 standards.


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
- this will return 
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
Try out all the commands and familiarize yourself with the output.

## Configuring flake8
In some cases, you may want to ignore flake8 errors or set limits differently, for example if you want to increase your line length to 120. You can reconfiger flake8 in a [number of different ways](https://flake8.pycqa.org/en/latest/user/configuration.html), and we will be using a flake8 configuration file. 

In order to do so, place a `.flake8` file in the root of your folder. The top of the file contains the line `[flake8]` - see [the example](../.flake8). A list of ignored errors can be included following the `ignore` option.

If you want to ignore additional errors to the ones specified in your flake8 configuration file, use `extend-ignore` (instead of `ignore`) when invoking flake8 (just using `ignore` will overwrite the specifications in your .flake8 configuration).
```
flake8 --extend-ignore E305 Material_Part2_Linter/example1.py
```

A good `.flake8` file will look like this
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
using `extend-ignore` not to overwrite previously defined options, and excluding directories for the linter to parse - so you can invoke flake8 on your complete package / source folder instead of selecting each file manually:
```
flake8 Material_Part1_PEP
```
**Task: Run the linter on your previously formatted code to see if you have missed any deviations in code style or obvious bugs.**

## Excurse: Flake8 for notebooks

# Code formatter
A code formatter takes care of formatting your code so that it adheres to the PEP 8 standards.