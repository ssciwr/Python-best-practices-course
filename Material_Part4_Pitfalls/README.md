# Pitfalls: Common ways to introduce bugs in your Python code

**Task 4: [GitHub assignment Python pitfalls](https://classroom.github.com/a/XBSxiwZi)**

Please checkout the assignment repo and follow through with the examples and instructions below. Commit any changes to a new branch and open a pull request. If the autograding/CI checks succeed, you have completed all tasks and can merge the pull request with main to submit your assignment.

## Naming the module

A source of errors can be naming a module the same as another module that is imported, in this example the module is named `math.py` but also imports math from the standard Python library; and function calls using methods from the math module will fail, as Python will look for those in the `math.py` file. 

[*Example*](https://github.com/ssciwr-courses/pbp-pitfalls/blob/main/chapter4/math.py)

**Solution**: Name your module file different than the modules that you are importing.

**Subtask (i): Resolve the issue for `chapter4/math.py`.**

## Shallow and deep copies

When copying lists and other mutable variable types like dictionarys, using an `=` sign only points the new variable to the same position in memory as the initial one. Changing one then automatically changes the other.

[*Example*](https://github.com/ssciwr-courses/pbp-pitfalls/blob/main/chapter4/copy_list.py)

**Solution**: Use `copy` or `deepcopy` instead to create copies of objects.

**Subtask (ii): Resolve the issue for `chapter4/copy_list.py`.**

## Instantiation of mutable default keyword arguments in function calls

Default arguments are only evaluated once: At the time the function is created. If you provide a mutable default keyword argument and then change it in the function, the next time the function is called without that keyword, the default will point to the same address as in the first call; but the argument will have already changed, so the default in the first call and the default in the second call are different. 

[*Example*](https://github.com/ssciwr-courses/pbp-pitfalls/blob/main/chapter4/mutable_default.py)

**Solution**: Only provide non-mutable default arguments..

**Subtask (iii): Resolve the issue for `chapter4/mutable_default.py`.**

## Exhausting iterators

Iterators and generators can be exhausted, meaning you can only use them once. 

[*Example*](https://github.com/ssciwr-courses/pbp-pitfalls/blob/main/chapter4/exhaust_iterators.py)

**Solution**: If you create an iterator or a generator and you need it more than once you need to save it first. As in the example provided, the iterator is created using `zip`, and can be saved in a `list`.

**Subtask (iii): Resolve the issue for `chapter4/exhaust_iterators.py`.**

## Variable assignment in different scopes

Assigning a variable within a function shadows any assignment that may have happened in an outer scope. 

[*Example*](https://github.com/ssciwr-courses/pbp-pitfalls/blob/main/chapter4/assignment.py)

**Solution**: Pass the variable as an argument into the inner scope or use the return value of a new assignment.

**Subtask (vi): Resolve the issue for `chapter4/assignment.py`.**

## Closure variable binding

Python uses late binding, resulting that in closures variables are only looked up once the inner function is called. 

[*Example*](https://github.com/ssciwr-courses/pbp-pitfalls/blob/main/chapter4/closure.py).


**Solution**: Make sure the referenced variables are either passed to the inner function or are set correctly in the surrounding scope.

**Subtask (v): Resolve the issue for `chapter4/closure.py`.**

**Task 4: Now you should have completed all edits on your assignment repo and should be able to submit the results (if the autograding and CI do not raise any issues).**