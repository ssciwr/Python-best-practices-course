# Better coding

## Why you should run code in your module only if `__name__` is `"__main__"`

Always encapsulate your module's content in functions/classes and have all function calls and instantiations contained after the statement
```
if __name__ == "__main__"
```
**Why?** Because, if you import your code as a module, all code that is not contained in a function or class will be run. Now, if you directly run the module,`__name__` will be set to `"__main__"`. But if the module is imported, `__name__` is set to the module's name. See the examples [module1.py](module1.py) and [module2.py](module2.py).

**Task:** Run the code in `module1.py` and `module2.py` and see what is run upon import and how `__name__` changes.