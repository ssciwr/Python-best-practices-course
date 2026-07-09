# Tests and type hints

Formatting and linting make code easier to read. Tests and type hints make code
safer to change.

## Why tests are essential

Tests are executable assumptions. They help answer:

- Does the code do what I think it does?
- Did my recent change break old behavior?
- Can a collaborator change this without guessing?
- Does the code still work on a clean machine or in CI?

For scientific code, tests are not only software engineering hygiene. They are
part of making computational results trustworthy.

This course only gives a short introduction. For the full SSC testing course,
see <https://ssciwr.github.io/python-testing-intro/>.

## A tiny pytest example

Code under test:

```python
def mean(values: list[float]) -> float:
    return sum(values) / len(values)
```

Test file:

```python
import pytest

from statistics_tools import mean


def test_mean_of_three_values():
    assert mean([1.0, 2.0, 3.0]) == 2.0


def test_mean_of_empty_list_raises():
    with pytest.raises(ZeroDivisionError):
        mean([])
```

Run the tests:

```bash
python -m pytest
```

This example is small, but it already demonstrates the pattern:

- put expected behavior in code;
- cover normal cases and edge cases;
- run tests before and after refactoring.

## Type hints

Type hints describe what kind of values code expects and returns:

```python
def total(values: list[float]) -> float:
    return sum(values)
```

Python does not normally enforce these annotations at runtime. Their main value
is that they help readers, editors, and type-checking tools.

Install mypy:

```bash
python -m pip install mypy
```

Run it:

```bash
mypy path/to/code.py
```

Example bug:

```python
def total(values: list[float]) -> float:
    return sum(values)


measurements = ["1.0", "2.0", "3.0"]
print(total(measurements))
```

At runtime this fails because `sum` cannot add strings to an integer start
value. A type checker can flag the mistake earlier: `measurements` is a
`list[str]`, but `total` expects `list[float]`.

Type hints are most useful when they stay simple:

- annotate public functions;
- annotate data structures that are otherwise ambiguous;
- use `str | None` for optional values;
- prefer built-in generic types such as `list[str]` and `dict[str, float]`;
- do not turn a beginner project into a typing puzzle.

## Task idea

Start from code with a small numerical function and a hidden edge case.

1. Run the existing pytest suite.
2. Add one missing test.
3. Add simple type hints to the public function.
4. Run mypy.
5. Fix the implementation.
6. Run pytest and mypy again.
