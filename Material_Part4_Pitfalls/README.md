# Common Python pitfalls

This section keeps the pitfalls that are most useful for participants with
basic Python knowledge. Advanced topics such as iterator exhaustion and closure
late binding are good follow-up material, but they are not central for this
course.

## Naming a module like a library

If you create a file called `math.py`, `random.py`, `typing.py`, or `logging.py`,
it can shadow the standard-library module with the same name.

Problem:

```text
project/
|- math.py
`- analysis.py
```

Inside `analysis.py`:

```python
import math

print(math.sqrt(4))
```

Python may import your local `math.py` instead of the standard-library `math`
module. The result is confusing import errors or missing attributes.

Prevention:

- avoid file names that collide with imported libraries;
- use clear project-specific names such as `geometry.py`;
- let tests and CI catch import behavior on a clean checkout.

## Mutable default arguments

Default arguments are evaluated once, when the function is defined. This is a
classic source of shared state bugs.

Problem:

```python
def add_sample(value: float, samples: list[float] = []) -> list[float]:
    samples.append(value)
    return samples
```

Every call without `samples` reuses the same list.

Better:

```python
def add_sample(value: float, samples: list[float] | None = None) -> list[float]:
    if samples is None:
        samples = []
    samples.append(value)
    return samples
```

Prevention:

- use `None` as the default for mutable values;
- create the mutable object inside the function;
- write a test that calls the function twice.

## Shallow and deep copies

Assignment does not copy objects:

```python
original = [[1, 2], [3, 4]]
alias = original
alias[0].append(99)
print(original)
```

Both names point to the same list.

A shallow copy copies the outer container:

```python
copied = original.copy()
```

For nested mutable structures, inner lists are still shared. A deep copy also
copies nested objects:

```python
from copy import deepcopy

copied = deepcopy(original)
```

Use `deepcopy` deliberately. It can be slower, and for complex objects it may
copy more than you intended. Often the better solution is to simplify the data
structure or construct a new object explicitly.

## Import-time side effects

Code at module top level runs when the module is imported. This makes code hard
to test and reuse.

Problem:

```python
def main() -> None:
    print("Running analysis")


main()
```

If another file imports this module, the analysis runs immediately.

Better:

```python
def main() -> None:
    print("Running analysis")


if __name__ == "__main__":
    main()
```

Prevention:

- put reusable logic in functions and classes;
- keep command-line execution behind `if __name__ == "__main__":`;
- write tests that import modules without triggering expensive work.

## Variable shadowing

Avoid names that hide useful built-ins or imported objects:

```python
list = [1, 2, 3]
sum = 0
```

These names make later code harder to understand and can break calls such as
`list(...)` or `sum(...)`.

Prevention:

- use descriptive names such as `values`, `total`, or `records`;
- enable Ruff rules such as `A` for built-in shadowing when appropriate.

## Task idea

Start with a small project that has:

- one mutable default argument;
- one import-time side effect;
- one shallow-copy surprise;
- one confusing name.

Students should add or run tests, fix the problems, and confirm Ruff still
passes.
