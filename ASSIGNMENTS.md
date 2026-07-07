# classroom50 assignment briefs

These briefs describe the intended assignment behavior before the actual
classroom50 templates and autograders are created.

Each assignment should have:

- a template repository with starter code and a student-facing README;
- a reference solution kept outside the student template;
- local commands that match the autograder;
- an autograder that reports small, actionable failures.

## Assignment 1: Ruff and formatting

Goal: participants experience automated style feedback and see the difference
between formatting, linting, and safe fixes.

Starter state:

- one or two Python files with inconsistent formatting;
- unused imports or simple lint issues;
- at least one import-order issue;
- a `pyproject.toml` with Ruff configuration.

Student tasks:

1. Create or activate an environment.
1. Install Ruff.
1. Run `ruff check .`.
1. Run `ruff format .`.
1. Run `ruff check --fix .`.
1. Inspect the diff.
1. Commit the corrected files.

Autograder checks:

```bash
ruff format --check .
ruff check .
```

## Assignment 2: Tests and type hints

Goal: participants see tests and type hints catch different classes of errors.

Starter state:

- a small numerical or string-processing function with one bug;
- a pytest suite with one missing edge-case test;
- minimal annotations missing from the public function.

Student tasks:

1. Run `python -m pytest`.
1. Add or complete the missing test.
1. Add simple type hints.
1. Run `mypy`.
1. Fix the implementation.

Autograder checks:

```bash
python -m pytest
mypy .
```

## Assignment 3: Pitfalls and readability refactor

Goal: participants fix beginner-relevant Python pitfalls while preserving
behavior.

Starter state:

- one mutable default argument;
- one import-time side effect;
- one shallow-copy surprise;
- one fragile path built by string concatenation;
- one progress `print` in reusable code.

Student tasks:

1. Fix the mutable default.
1. Move executable code behind `main`.
1. Replace fragile paths with `pathlib.Path`.
1. Replace progress `print` with `logging`.
1. Keep or add tests that prove behavior did not change.

Autograder checks:

```bash
ruff check .
ruff format --check .
python -m pytest
```

## Assignment 4: Project shape

Goal: participants recognize when code should become package-shaped without
turning the course into a packaging course.

Starter state:

- a small script plus repeated helper code;
- a partially completed `pyproject.toml`;
- a target directory layout shown in the README.

Student tasks:

1. Move reusable logic into `src/<package_name>/`.
1. Keep executable behavior in a small script or `main` function.
1. Place tests under `tests/`.
1. Complete minimal `pyproject.toml` tool configuration.

Autograder checks:

```bash
ruff check .
ruff format --check .
python -m pytest
python -c "import package_name"
```

Use the actual assignment package name instead of `package_name`.
