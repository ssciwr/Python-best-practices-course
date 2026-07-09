# PEPs, style, Ruff, and pre-commit

Once the project shape is clear, we can talk about code style. The central idea
is not to memorize every rule. The central idea is to make code predictable
enough that readers can focus on meaning.

## PEPs and PEP 8

Python Enhancement Proposals (PEPs) describe Python language changes, processes,
and conventions. You can find the PEP index at <https://peps.python.org/>.

[PEP 8](https://peps.python.org/pep-0008/) is the style guide for Python code.
It covers naming, indentation, imports, whitespace, comments, and other layout
conventions. For this course, the most important message is:

- prefer consistency over personal taste;
- prefer readable code over clever code;
- automate formatting and linting whenever possible;
- adapt conventions deliberately when a project already has a local style.

Examples of useful PEP 8 guidance:

- Use 4 spaces per indentation level.
- Put imports at the top of the file.
- Prefer one import per line.
- Use descriptive `lowercase_with_underscores` names for functions and
  variables.
- Use `CamelCase` for classes.
- Avoid ambiguous one-letter names such as `l`, `O`, and `I`.
- Keep comments and code consistent with each other.

Line length deserves a pragmatic note. PEP 8 recommends 79 characters for code,
but many modern Python projects use a formatter default such as 88 characters.
The exact number matters less than agreeing on one value and letting tools
enforce it.

## Automated style feedback

Manual style review is expensive and not very interesting. Let tools handle the
boring parts so humans can review names, structure, tests, and scientific
correctness.

## Ruff

[Ruff](https://docs.astral.sh/ruff/) is a fast Python linter and formatter. In
this course we use Ruff instead of teaching separate tools such as Flake8,
isort, Black, and pyupgrade.

Install it in your project environment:

```bash
python -m pip install ruff
```

Run the linter:

```bash
ruff check path/to/code.py
ruff check path/to/package/
```

Run the formatter:

```bash
ruff format path/to/code.py
ruff format path/to/package/
```

Check formatting without changing files:

```bash
ruff format --check .
```

Apply safe automatic lint fixes:

```bash
ruff check --fix .
```

The `--preview` flag enables newer or experimental behavior. It can be useful,
but do not make it the default for a beginner course or a new team unless you
intend to handle rule changes more often.

## Reading Ruff messages

Ruff reports where a problem occurs, which rule was triggered, and often how to
fix it. Example:

```text
E303 [*] Too many blank lines (4)
 --> chapter1/example1.py:7:1
  |
7 | # find all png files in a folder
  | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
8 | def find_files(path: str = None, pattern: str = "*.png"):
  |
help: Remove extraneous blank line(s)
```

Read this as:

- `E303` is the rule code.
- `chapter1/example1.py:7:1` is the file, line, and column.
- `[*]` means Ruff can fix this automatically.
- the `help` line explains the change.

## Configuring Ruff

Ruff has defaults, but a project should usually record its configuration. This
makes local development, CI, and collaborators agree.

In `pyproject.toml`, Ruff settings live under `[tool.ruff]` and
`[tool.ruff.lint]`:

```toml
[tool.ruff]
line-length = 88

[tool.ruff.lint]
select = [
    "E",    # pycodestyle errors
    "F",    # Pyflakes
    "B",    # flake8-bugbear
    "I",    # import sorting
    "UP",   # pyupgrade
    "SIM",  # simplify
]
```

In a standalone `ruff.toml`, omit the `tool.ruff` prefix:

```toml
line-length = 88

[lint]
select = ["E", "F", "B", "I", "UP", "SIM"]
```

Start with a small rule set and add more rules deliberately. Too many rules at
once can turn a useful tool into noise.

## Jupyter notebooks

Ruff can also check notebooks:

```bash
ruff check analysis.ipynb
```

For notebooks under version control, also consider [`nbstripout`](https://pypi.org/project/nbstripout/) or a similar
tool so large generated outputs do not hide the actual code changes in review.

## pre-commit

`pre-commit` runs checks before a commit is created. This is useful when a
project starts with clean code, then more collaborators join and not everyone
uses the same editor setup.

Install and enable it:

```bash
python -m pip install pre-commit
pre-commit install
```

A minimal `.pre-commit-config.yaml` for Ruff:

```yaml
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.15.20
    hooks:
      - id: ruff-check
        args: [--fix, --show-fixes]
      - id: ruff-format

  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v6.0.0
    hooks:
      - id: check-yaml
      - id: check-toml
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-added-large-files
```

Run all hooks manually:

```bash
pre-commit run --all-files
```

For GitHub projects, services such as `pre-commit.ci` can run the same hooks on
pull requests and even commit automatic fixes.

## Task idea

Start from a repository with messy but working code.

1. Create and activate an environment.
2. Install Ruff.
3. Run `ruff check .`.
4. Run `ruff format .`.
5. Run `ruff check --fix .`.
6. Inspect the diff and explain which changes were formatting and which were
   possible bug risks.
7. Make the classroom50 autograder pass.
