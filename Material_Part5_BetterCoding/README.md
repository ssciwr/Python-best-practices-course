# Modern readable Python

Readable code is not necessarily shorter code. It is code where the reader can
quickly see the data, the intent, and the failure modes.

## f-strings

Use f-strings for readable string interpolation:

```python
sample_id = "A42"
temperature = 21.378

message = f"Sample {sample_id} measured {temperature:.1f} C"
```

Compared with manual concatenation or older formatting styles, f-strings keep
the variable near the text that explains it.

## pathlib

`pathlib.Path` represents file system paths as objects instead of fragile
strings.

String-based path handling:

```python
filename = data_dir + "/" + sample_id + ".csv"
```

Path-based handling:

```python
from pathlib import Path

data_dir = Path("data")
filename = data_dir / f"{sample_id}.csv"
```

Useful methods:

```python
filename.exists()
filename.read_text()
filename.with_suffix(".json")
filename.parent
```

Benefits:

- clearer path joining with `/`;
- fewer operating-system assumptions;
- convenient methods for common file operations;
- easier testing with temporary directories.

## dataclasses

Use `dataclasses` for small records with named fields:

```python
from dataclasses import dataclass


@dataclass
class Measurement:
    sample_id: str
    temperature: float
    valid: bool = True
```

This is often clearer than parallel lists or dictionaries with repeated string
keys:

```python
measurement = Measurement(sample_id="A42", temperature=21.4)
print(measurement.temperature)
```

Dataclasses are useful when:

- the data has a stable shape;
- field names matter;
- you pass the same group of values through several functions;
- you want a helpful representation for debugging.

## logging

Use `logging` for reusable code and `print` for small one-off scripts or final
user-facing output.

```python
import logging

logger = logging.getLogger(__name__)


def load_samples(path):
    logger.info("Loading samples from %s", path)
```

At the application entry point:

```python
logging.basicConfig(level=logging.INFO)
```

Benefits:

- callers can choose how much output they want;
- messages can include severity levels;
- libraries do not force output on users;
- logs can be redirected or captured by tests.

## Context managers

Use context managers for resources that must be cleaned up:

```python
from pathlib import Path

path = Path("results.txt")

with path.open("w") as handle:
    handle.write("done\n")
```

The file is closed even if an error occurs inside the block.

## enumerate and zip

Use `enumerate` when you need both an index and a value:

```python
for index, value in enumerate(values):
    print(index, value)
```

Use `zip` to iterate over related sequences:

```python
for sample_id, temperature in zip(sample_ids, temperatures):
    print(sample_id, temperature)
```

If the sequences must have the same length, use `strict=True` in modern Python:

```python
for sample_id, temperature in zip(sample_ids, temperatures, strict=True):
    print(sample_id, temperature)
```

## Main functions

Keep command-line behavior in a `main` function and protect it with the
`__name__` guard:

```python
def main() -> None:
    ...


if __name__ == "__main__":
    main()
```

This makes the module importable and testable.

## Task idea

Refactor a small analysis script:

1. replace string path handling with `Path`;
2. replace a dictionary record with a dataclass;
3. replace manual string formatting with f-strings;
4. replace progress `print` calls with logging;
5. keep command-line execution behind `main`;
6. verify pytest and Ruff still pass.
