# Best Practices in Python Programming

Material for the course "Best Practices in Python Programming", Scientific
Software Center, Heidelberg University.

Original material by Inga Ulusoy. Revised for the next installment by Thomas
Isensee.

Python is widely used in science and research, from quick data analysis scripts
to reusable packages and simulation workflows. This course focuses on practical
habits and tools that make Python code easier to read, test, review, and share
with collaborators.

The course is not a full introduction to testing, packaging, Git, or continuous
integration. Instead, it shows the minimum useful practices that every Python
project should adopt, and points to dedicated SSC courses for deeper material.

## Prerequisites

Participants should have basic Python knowledge and a laptop with Python
installed. A GitHub account is required for the classroom exercises.

Recommended preparation:

- Install a recent supported Python version.
- Have either `venv`/`pip` or Conda available.
- Install Git and configure access to GitHub.
- Use an editor or IDE that can run terminal commands.

## Learning objectives

After the course participants will be able to:

- Explain why isolated environments make Python work more reproducible.
- Use Ruff to lint and format Python code.
- Understand how `pyproject.toml` connects project metadata and tool
  configuration.
- Explain why tests are essential and run a small pytest test suite.
- Use simple type hints with a type checker to catch bugs earlier.
- Recognize when a script should become a package.
- Avoid common beginner-relevant Python pitfalls.
- Apply modern readability patterns such as `pathlib`, `dataclasses`,
  f-strings, and `logging`.
- Use Git, pre-commit hooks, and CI as collaboration guardrails.

## Course content

1. [Project setup](Material_Part1_Setup/README.md)
2. [PEPs, style, Ruff, and pre-commit](Material_Part2_Style/README.md)
3. [Tests and type hints](Material_Part3_Tests/README.md)
4. [Common Python pitfalls](Material_Part4_Pitfalls/README.md)
5. [Modern readable Python](Material_Part5_BetterCoding/README.md)

## Related SSC courses

This course gives a compact overview. For full treatments, see:

- Python testing: <https://ssciwr.github.io/python-testing-intro/>
- Python packaging: <https://ssciwr.github.io/python-packaging/>
- SSC Python project template: <https://github.com/ssciwr/python-project-template>
- SSC Python package cookiecutter:
  <https://github.com/ssciwr/cookiecutter-python-package>

## Assignment plan

The next installment should move assignments to a classroom50 workflow. See
[ASSIGNMENTS.md](ASSIGNMENTS.md) for concrete assignment briefs. A useful split
is:

1. Ruff and formatting: fix a messy but working codebase until `ruff check` and
   `ruff format --check` pass.
2. Tests and type hints: run pytest, add or complete tests, add simple
   annotations, and fix the bug.
3. Pitfalls and readability: refactor mutable defaults, import-time side
   effects, fragile paths, and `print`-based status output.
4. Project shape: identify whether code should remain a script or become a
   package, and recognize a minimal `src/`, `tests/`, `pyproject.toml` layout.

Each assignment should start in a failing state and have a reference solution
that passes the same classroom50 autograder.
