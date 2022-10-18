# PEP recommendations

## What is a PEP?

Find out about the purpose of PEPs (Python Enhancement Proposals) on the [pep site](https://peps.python.org/pep-0001/). Short answer: These are documents helping to organize the evolution of the Python language in the community.

You can find a list of PEPs [here](https://peps.python.org/).

## What is PEP 8?

[PEP 8](https://peps.python.org/pep-0008/) is a meta-PEP = a PEP about other PEPs. PEP 8 specifies Python styling do's and dont's.

## PEP 8 summary

1. Line length
Don't write lines that are very long. Reason: Often you would use multiple windows next to each other and that makes it hard to read code (and possibly lead to introduction of bugs).  
PEP 8 recommends lines no longer than 79 characters, but 90 is also a good number.

1. Alignment of code  
Make use of indentation when using continuation lines:  

        foo = long_function_name(var_one, var_two,
                                 var_three, var_four)  
                                 
    instead of 

        foo = long_function_name(var_one, var_two,
            var_three, var_four)

    You may also use hanging indents

        foo = long_function_name(
            var_one, var_two,
            var_three, var_four)

1. Break line before binary operator
        
        income = (gross_wages
          + taxable_interest
          + (dividends - qualified_dividends)
          - ira_deduction
          - student_loan_interest)

    instead of  

        income = (gross_wages +
          taxable_interest +
          (dividends - qualified_dividends) -
          ira_deduction -
          student_loan_interest)

1. Blank lines:  
- two blank lines after `import` statements
- two blank lines between functions and classes
- one blank line between methods of classes

        import os


        def greeting():
           print("Hello world!")


        def goodbye():
        print("See ya!")
    
    instead of

        import os

        def greeting():
           print("Hello world!")

        def goodbye():
        print("See ya!")

    and

        def something():
            pass


        class MyClass:

            def my_method():
                pass

            def some_other():
                pass

    instead of 

        def something():
            pass

        class MyClass:
            def my_method():
                pass
            def some_other():
                pass


1. Encoding: The source file should always use UTF-8 encoding, and preferably without non-ASCII characters. It also makes your code more general if you use English words for identifiers (function names etc.).

1. Imports should be on separate lines:

        import os
        import sys

    and not

        import os, sys

1. String quotes: Do either use `'` or `"` throughout your project - do not mix. For triple-quoted strings, always use `"`, so `"""` instead of `'''`.

1. Whitespaces:
    - no whitespace in parantheses - do `{item: 1}`, don't ```{ item: 1 }```
    - whitespace after comma - do `a, b`, don't `a,b`, but not if followed by a parenthesis - do `(a, b,)` don't `(a, b, )`
    - no whitespace before parenthesis - do `calc_this(x)` don't `calc_this (x)`
    - no trailing whitespaces
    - whitespace around operators (ie. `=, +, +=, ==, is, and`) except for keywords - do `(x=circle)`, don't `(x = circle)`
1. Keep comments up-to-date when changing the code. Comments should be complete sentences with a capitalized first word (unless it is an identifier). Use English language preferably.
1. Include docstrings - see below (PEP 257).
1. Naming conventions:
- package and module names: short all-lowercase, preferably no underscores (do `analysis.py`, don't `Analysis.py`; do `mypackage`, don't `my_package`)
- class names: use CamelCase (do `MyClass`, don't `myclass`, `Myclass`, `MYCLASS`)
- functions and variable names: use lowercase with underscore to increase readibility (do `my_function()`, don't `myfunction()`, `MyFunction()`; do `accuracy_param`, don't `accuracyparam`, `accuracy_PARAM`)
- constants: all capital with separating underscore (do `MIN_THRESHOLD`, don't `Min_Threshold`)
- never use `l, O, I` letter names because of their similarity with `1` and `0`

1. Underscores:
- avoid name clashes using a trailing underscore or synonym (`class_`)
- single leading underscore for methods that should only be used "internally" (should not be made available to the package or class interface)
- use two leading underscores to invoke name mangling for attributes that should not be used in subclasses of the parent class (`__only_parent`)
- double leading and trailing underscores for "magic" objects (dunder methods) - `__init__`, `__str__`


## What is PEP 257?

[PEP 257](https://peps.python.org/pep-0257/) specifies styling of Python docstrings.

## PEP 257 summary

## PEP 20

The Zen of Python. Type `import this` in your Python console.