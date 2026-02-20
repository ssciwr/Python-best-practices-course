# Linter
A code linter is there to highlight issues with the code that do not conform with a style guide, and that may lead to errors when interpreted or compiled. For Python, a code linter makes sure that the code conforms with PEP 8 standards.

**Task 2: [GitHub assignment code linter](https://classroom.github.com/a/d0dI5zx_)**

Please checkout the assignment repo and follow through with the commands below. Commit any changes to a new branch and open a pull request. If the autograding/CI checks succeed, you have completed all tasks and can merge the pull request with main to submit your assignment.

## Ruff
We will be using [Ruff](https://docs.astral.sh/ruff/linter/), a fast and popular linter for Python code.  

First, you need to install ruff. You can do so by typing  
```
pip install ruff
```
in your terminal. Alternatively, you can install it via the `requirements.txt` in the assignment repo
```
pip install -r requirements.txt
```
You can then invoke the linter using
```
ruff check path/to/code/to/check.py
# or
ruff check path/to/code/
```
in your terminal. We will be using the `--preview` flag since this provides more feedback on the files, using the latest features of Ruff.

## Ruff messages
Ruff will return error messages if your code does not adhere to the styling recommendation. You can find a list of all rules [here](https://docs.astral.sh/ruff/rules/).

If you run `ruff check --preview` on `example1.py`, you will get a list of error messages such as
```
E303 [*] Too many blank lines (4)
 --> chapter1/example1.py:7:1
  |
7 | # find all png files in a folder
  | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
8 | def find_files(path: str=None, pattern: str="*.png",
9 |                limit: int = 20) -> list:
  |
help: Remove extraneous blank line(s)
```
Ruff tells you which line the error occurs (for example, line 7) and at which position in that line (for example, position 1), and then report the error code (E303) and the error type (too many blank lines - in the example it also tells that it found (4) blank lines). It also tells you how to fix the issue (help: Remove extraneous blank line(s)).

Armed with this information, you can then navigate to the position in your code and correct the issues. 

## Configuring Ruff

Unless you use it as a `pre-commit` hook, Ruff needs to be configured in the `pyproject.toml` or `ruff.toml` file. In the assignment repo, you find the following configuration for Ruff:
```
[lint]
select = [
    "E",    # pycodestyle errors
    "W",    # pycodestyle warnings
    "F",    # Pyflakes
    "A",    # flake8-builtins (catches 'list' variable shadowing)
    "C4",   # flake8-comprehensions
]
```
In some cases, you may want to ignore errors or set limits differently, for example if you want to increase your line length to 120. You can reconfigure Ruff in a [number of different ways](https://docs.astral.sh/ruff/configuration/) (or see [here](https://docs.astral.sh/ruff/linter/#ruff-check)).

A good `ruff.toml` file will look like this:
```
# Line length configuration
line-length = 120

[lint]
select = [
    # pycodestyle
    "E",
    # Pyflakes
    "F",
    # pyupgrade
    "UP",
    # flake8-bugbear
    "B",
    # flake8-simplify
    "SIM",
    # isort
    "I",
]

# Exclude directories
exclude = [
    ".git",
    ".ruff_cache",
    ".venv",
    "venv",
    "__pycache__",
    "build",
    "dist",
    "*.egg-info",
]
```

## Ruff for jupyter notebooks
You can run Ruff also on jupyter notebooks
```
ruff check chapter2_3/example_jupyter.ipynb
```
or any other file name or path (if you just provide a path, all python source and notebook files in the given directory will be checked).

**Task 2: [GitHub assignment linter](https://classroom.github.com/a/KmXdqaRi)**

Please checkout the assignment repo and run `ruff check` and `ruff check --preview` on the code files in the repo. Familiarize yourself with the configuration of Ruff and the output.