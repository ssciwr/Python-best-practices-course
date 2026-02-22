# Better coding

**Task 5: [GitHub assignment write more readable code using these suggestions](https://classroom.github.com/a/7Yu9uxax)**

Please checkout the assignment repo and follow through with the examples and instructions below. Commit any changes to a new branch and open a pull request. If the autograding/CI checks succeed, you have completed all tasks and can merge the pull request with main to submit your assignment.

## Demonstrations

I will demonstrate how to improve the readability in some code snippets. This has mostly to do with design decisions. Advice: **Plan first, code second!**

## Further examples 
Here are further examples, loosely based on [this video](https://youtu.be/C-gEQdGVXbk). Feel free to take a look if any of these suggestions may help you write better code in the future. **Please not that brevity has its limit and sometimes using more lines to write a piece of code can actually be better**: If it helps to improve understanding of the code.

## Why you should run code in your module only if `__name__` is `"__main__"`

Always encapsulate your module's content in functions/classes and have all function calls and instantiations contained after the statement
```
if __name__ == "__main__"
```
**Why?** Because, if you import your code as a module, all code that is not contained in a function or class will be run. Now, if you directly run the module,`__name__` will be set to `"__main__"`. But if the module is imported, `__name__` is set to the module's name. See the examples [module1.py](https://github.com/ssciwr-courses/pbp-better-code/blob/main/chapter5/module1.py) and [module2.py](https://github.com/ssciwr-courses/pbp-better-code/blob/main/chapter5/module2.py) in the assignment repo folder `chapter5`.

**Subtask (i): Run the code in `module1.py` and `module2.py` and see what is run upon import and how `__name__` changes.**

### Ternary conditionals

Use ternary conditionals to simplify `if ... else` statements. 

[*Example*](https://github.com/ssciwr-courses/pbp-better-code/blob/main/chapter5/ternary.py)

**Subtask (ii): Fix the conditional in `chapter5/ternary.py` to use a ternary conditional.**

### Context managers
 
Use context managers to not have to worry about tear-down methods, like closing a file. Using `with open`, for example, automatically closes the file after it has been read. 

[*Example*](https://github.com/ssciwr-courses/pbp-better-code/blob/main/chapter5/context_managers.py)

**Subtask (iii): Use a context manager in `chapter5/context_managers.py`.**

### Using enumerate

Use `enumerate` when you want to access both the list item and its index at the same time when iterating. 

[*Example*](https://github.com/ssciwr-courses/pbp-better-code/blob/main/chapter5/enumerate.py)

**Subtask (iv): Use enumerate in the loop in `chapter5/enumerate.py`.**

### Using zip

Use `zip` if you want to iterate over two lists simultaneously. 

[*Example*](https://github.com/ssciwr-courses/pbp-better-code/blob/main/chapter5/use_zip.py)

**Subtask (v): Use zip for the loop in `chapter5/use_zip.py`.**

**Task 5: Now you should have completed all edits on your assignment repo and should be able to submit the results (if the autograding and CI do not raise any issues).**