#import "@preview/touying:0.7.4": *
#import "ssc-theme.typ": *

#show: institution-theme.with(
  title-logo: image("ssc_iwr_uni_logos_darkmode.svg"),
  slide-logo: image("ssc_logo_and_text.svg"),
  config-info(
    title: [Best Practices in Python Programming],
    author: [Thomas Isensee],
    date: datetime.today(),
    institution: [Scientific Software Center (SSC), Heidelberg University],
  ),
)

#set text(font: ("Source Sans 3"))
#set heading(numbering: "1.1")

#show raw.where(block: false): box.with(
  fill: luma(80.78%),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 4pt,
)

#show raw.where(block: true): it => block(
  fill: luma(80.78%),
  inset: 12pt,
  radius: 8pt,
  text(size: 12pt, it),
)
#set raw(theme: auto)

#let logo(text, icon) = box[
  #text
  #h(0.05em)
  #box(
    baseline: 10%,
    image(icon, height: 0.9em),
  )
]

#let testing-url = "https://ssciwr.github.io/python-testing-intro/"
#let packaging-url = "https://ssciwr.github.io/python-packaging/"
#let template-url = "https://github.com/ssciwr/python-project-template"
#let cookiecutter-url = "https://github.com/ssciwr/cookiecutter-python-package"
#let peps-url = "https://peps.python.org/"
#let pep8-url = "https://peps.python.org/pep-0008/"
#let ruff-url = "https://docs.astral.sh/ruff/"
#let uv-url = "https://docs.astral.sh/uv/"
#let nbstripout-url = "https://pypi.org/project/nbstripout/"

#title-slide()

== Outline <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

= Course Overview

#slide(title: "Course focus")[
  #logo("Python", "figures/python-logo.svg") is widely used in science and research, from quick data analysis
  scripts to reusable packages and simulation workflows.

  This course focuses on practical habits and tools that make Python code
  easier to read, test, review, and share with collaborators.
]

#slide(title: "What this course is not")[
  This is not a full introduction to:

  - testing
  - packaging
  - Git
  - continuous integration

  We cover the minimum useful practices and point to dedicated SSC courses.
]

#slide(title: "Learning objectives")[
  After the course, participants should be able to:

  - use isolated environments and basic project structure
  - lint and format with Ruff
  - understand `pyproject.toml` as project/tool configuration
  - run small pytest suites and simple type checks
  - avoid beginner-relevant pitfalls
  - apply modern readability patterns
]

#slide(title: "Development workflow")[
  ```text
  edit -> format/lint -> test -> commit -> review/CI
  ```

  This is a feedback loop: after each change, tools and tests quickly tell you
  whether the code is still readable, working, and ready to share.
]

#slide(title: "Related SSC material")[
  - Python testing: #link(testing-url)[Introduction to Python Testing]
  - Python packaging: #link(packaging-url)[Python Packaging]
  - Template: #link(template-url)[SSC Python project template]
  - Cookiecutter: #link(cookiecutter-url)[SSC Python package template]
]

= Project Setup

#slide(title: "Questions a project should answer")[
  Before talking about code style, a project should make clear:

  - Which Python environment should I use?
  - Where are dependencies recorded?
  - Is this a script or a package?
  - Where are tests expected to live?
  - Is the project under version control?
]

#slide(title: "Why isolated environments?")[
  An isolated environment keeps a project's dependencies separate from your
  system Python and from other projects.

  Benefits:

  - different projects can need different versions
  - installed tools do not leak between projects
  - collaborators can recreate the setup
  - CI and local development can use the same dependency list
]

#slide(title: "venv")[
  `venv` is part of Python and is a good default when you only need Python
  packages from PyPI.

  ```bash
  python -m venv .venv
  source .venv/bin/activate
  python -m pip install --upgrade pip
  python -m pip install ruff pytest mypy
  ```

  Add `.venv/` to `.gitignore`.
]

#slide(title: "Conda")[
  Conda is common in scientific Python, especially when a project depends on
  compiled libraries or non-Python packages.

  ```bash
  conda create -n my-project python=3.14
  conda activate my-project
  conda install numpy scipy
  python -m pip install ruff pytest mypy
  ```
]

#slide(title: logo("uv", "figures/uv-logo-letter.svg"))[
  #link(uv-url)[uv] is a newer Python project and package manager from the same
  organization as Ruff.

  It can:

  - create environments
  - install dependencies
  - run tools
  - manage lock files
  - support workspaces

  Highly recommended, not required for this course.
]

#slide(title: "Script or package?")[
  Not every file needs to become a package. A one-off script can stay a script.

  Consider a package when code is:

  - imported from multiple scripts or notebooks
  - reused by collaborators
  - tested in CI
  - documented as an importable API
  - installed into an environment
  - published or archived as a reusable tool
]

#slide(title: "Minimal package-shaped project")[
  ```text
  my-project/
  ├── README.md
  ├── pyproject.toml
  ├── src/
  |   └── my_project/
  |       ├── __init__.py
  |       └── analysis.py
  └── tests/
      └── test_analysis.py
  ```

  `src/` helps tests use the installed package. `tests/` keeps tests separate
  from library code.
]

#slide(title: "pyproject.toml")[
  `pyproject.toml` started as build-system configuration, but today it is also
  the standard place for project metadata and tool configuration.

  It can record:

  - project metadata
  - supported Python versions
  - dependencies
  - optional development dependencies
  - tool settings for Ruff, pytest, mypy, setuptools, and others
]

#slide(title: "pyproject.toml example")[
  ```toml
  [project]
  name = "my-analysis"
  version = "0.1.0"
  requires-python = ">=3.11"
  dependencies = ["numpy", "pandas"]

  [project.optional-dependencies]
  dev = ["pytest", "ruff", "mypy"]
  ```

  The key idea: another person or CI should be able to recreate the setup.
]

#slide(title: "Tool configuration example")[
  ```toml
  [tool.ruff]
  line-length = 88

  [tool.ruff.lint]
  select = ["E", "F", "B", "I", "UP", "SIM"]

  [tool.pytest.ini_options]
  testpaths = ["tests"]
  ```
]

#slide(title: [#logo("Git", "figures/git-logo.svg") basics for this course])[
  Git is the history and collaboration layer for this development workflow.

  Participants should know how to:

  - clone a repository
  - create or edit files
  - inspect changes with `git status` and `git diff`
  - commit changes
  - push committed changes to the remote repository
]

#slide(title: "Recommended project files")[
  - `.gitignore` for files that should not be committed
  - `README.md` for setup and usage instructions
  - `pyproject.toml` or another explicit dependency/configuration file
  - tests and CI once the project grows beyond a throwaway script

  Git does not make code good by itself. It makes changes visible, reviewable,
  and recoverable.
]

= PEPs, Style, Ruff, And Pre-Commit

#slide(title: "Why style comes after setup")[
  Once the project shape is clear, we can talk about code style.

  The central idea is not to memorize every rule. The central idea is to make
  code predictable enough that readers can focus on meaning.
]

#slide(title: "PEPs and PEP 8")[
  Python Enhancement Proposals (PEPs) describe Python language changes, processes, and
  conventions.

  - PEP index: #link(peps-url)[peps.python.org]
  - PEP 8: #link(pep8-url)[style guide for Python code]

  PEP 8 covers naming, indentation, imports, whitespace, comments, and layout
  conventions.
]

#slide(title: "PEP 8 message")[
  For this course, the most important message is:

  - prefer consistency over personal taste
  - prefer readable code over clever code
  - automate formatting and linting whenever possible
  - adapt deliberately when a project already has a local style
]

#slide(title: "Useful PEP 8 guidance")[
  - Use 4 spaces per indentation level.
  - Put imports at the top of the file.
  - Prefer one import per line.
  - Use `lowercase_with_underscores` for functions and variables.
  - Use `CamelCase` for classes.
  - Avoid ambiguous names such as `l`, `O`, and `I`.
  - Keep comments and code consistent.
]

#slide(title: "Line length")[
  PEP 8 recommends 79 characters for code.

  Many modern projects use a formatter default such as 88 characters.

  The exact number matters less than agreeing on one value and letting tools
  enforce it.
]

#slide(title: "Automated style feedback")[
  Manual style review is expensive and not very interesting (it's boring).

  Let tools handle the boring parts so humans can review:

  - names
  - structure
  - tests
  - scientific correctness
]

#slide(composer: (1fr, 1fr), title: [#logo("Ruff", "figures/ruff-logo.svg")])[
  #link(ruff-url)[Ruff] is a fast Python linter and formatter.

  In this course we use Ruff instead of teaching separate tools such as:

  - Flake8
  - isort
  - Black
  - pyupgrade
][
  #align(right)[
    #rect(
      fill: rgb("#261230"),
      figure(
        image("figures/ruff-gh-comparison.svg", width: 100%),
      )
    )
  ]
]

#slide(title: "Install and run Ruff")[
  ```bash
  python -m pip install ruff

  ruff check path/to/code.py
  ruff check path/to/package/

  ruff format path/to/code.py
  ruff format path/to/package/
  ```
]

#slide(title: "Ruff checks")[
  ```bash
  # Check formatting without changing files
  ruff format --check .

  # Apply safe automatic lint fixes
  ruff check --fix .
  ```

  `--preview` enables newer or experimental behavior. Do not make it the
  beginner default unless you intend to handle rule changes more often.
]

#slide(title: "Reading Ruff messages")[
  ```bash
  E303 [*] Too many blank lines (4)
   --> chapter1/example1.py:7:1
    |
  7 | # find all png files in a folder
    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  help: Remove extraneous blank line(s)
  ```

  Ruff reports the rule, location, code context, and often a fix.
]

#slide(title: "Reading Ruff messages: details")[
  - `E303` is the rule code.
  - `chapter1/example1.py:7:1` is file, line, and column.
  - `[*]` means Ruff can fix this automatically.
  - the `help` line explains the change.
]

#slide(composer: (1fr, 1fr), title: "Configuring Ruff")[
  In #raw(block: false, "pyproject.toml"):
  ```toml
  [tool.ruff]
  line-length = 88

  [tool.ruff.lint]
  select = [
      "E",  # pycodestyle errors
      "F",  # Pyflakes
      "B",  # flake8-bugbear
      "I",  # import sorting
      "UP", # pyupgrade
      "SIM",
  ]
  ```
][
  In a standalone #raw(block: false, "ruff.toml"), omit the `tool.ruff` prefix: :

  ```toml
  line-length = 88

  [lint]
  select = ["E", "F", "B", "I", "UP", "SIM"]
  ```
][Start with a small rule set and add more rules deliberately.]

#slide(title: [#logo("Jupyter", "figures/jupyter-logo.svg") notebooks])[
  Ruff can also check notebooks:

  ```bash
  ruff check analysis.ipynb
  ```

  For notebooks under version control, consider #link(nbstripout-url)[nbstripout]
  or a similar tool so generated outputs do not hide the actual code changes.
]

#slide(title: logo("pre-commit", "figures/pre-commit-logo.svg"))[
  `pre-commit` runs checks before a commit is created.

  This helps when a project starts clean, then collaborators join and not
  everyone uses the same editor setup.

  ```bash
  python -m pip install pre-commit
  pre-commit install
  ```
]

#slide(title: "pre-commit configuration")[
  ```yaml
  repos:
    - repo: https://github.com/astral-sh/ruff-pre-commit
      rev: v0.15.20
      hooks:
        - id: ruff-check
          args: [--fix, --show-fixes]
        - id: ruff-format
  ```

  Run all hooks manually with `pre-commit run --all-files`.
]

#slide(title: "pre-commit and GitHub")[
  Services such as `pre-commit.ci` can run the same hooks on pull requests and
  even commit automatic fixes.

  #align(left)[
    #figure(
      image("figures/pre-commit-bot-gh.png", width: 100%),
    )
  ]

  Your colleagues won't be able to mess up your code!
]

#slide(title: "Task idea: Ruff")[
  Start from a repository with messy but working code.

  1. Create and activate an environment.
  2. Install Ruff.
  3. Run `ruff check .`.
  4. Run `ruff format .`.
  5. Run `ruff check --fix .`.
  6. Inspect the diff.
  7. Make the classroom50 autograder pass.
]

= Tests And Type Hints

#slide(title: "Why tests are essential")[
  Tests are executable assumptions. They help answer:

  - Does the code do what I think it does?
  - Did my recent change break old behavior?
  - Can a collaborator change this without guessing?
  - Does the code still work on a clean machine or in CI?
]

#slide(title: "Tests in scientific code")[
  For scientific code, tests are not only software engineering hygiene.

  They are part of making computational results trustworthy.

  This course only gives a short introduction.

  Full course: #link(testing-url)[Introduction to Python Testing]
]

#slide(title: "A tiny pytest example: code")[
  Code under test:

  ```python
  def mean(values: list[float]) -> float:
      return sum(values) / len(values)
  ```
]

#slide(title: "A tiny pytest example: tests")[
  ```python
  import pytest

  from statistics_tools import mean

  def test_mean_of_three_values():
      assert mean([1.0, 2.0, 3.0]) == 2.0

  def test_mean_of_empty_list_raises():
      with pytest.raises(ZeroDivisionError):
          mean([])
  ```
]

#slide(title: "Run pytest")[
  ```bash
  python -m pytest
  ```

  The pattern:

  - put expected behavior in code
  - cover normal cases and edge cases
  - run tests before and after refactoring
]

#slide(title: "Type hints")[
  Type hints describe what kind of values code expects and returns:

  ```python
  def total(values: list[float]) -> float:
      return sum(values)
  ```

  Python does not normally enforce these annotations at runtime. Their main
  value is that they help readers, editors, and type-checking tools.
]

#slide(title: "mypy")[
  Install mypy:

  ```bash
  python -m pip install mypy
  ```

  Run it:

  ```bash
  mypy path/to/code.py
  ```
]

#slide(title: "Type checker example")[
  ```python
  def total(values: list[float]) -> float:
      return sum(values)

  measurements = ["1.0", "2.0", "3.0"]
  print(total(measurements))
  ```

  At runtime this fails. A type checker can flag the mistake earlier:
  `list[str]` is not `list[float]`.
]

#slide(title: "Keep type hints simple")[
  Type hints are most useful when they stay simple:

  - annotate public functions
  - annotate ambiguous data structures
  - use `str | None` for optional values
  - prefer built-in generics such as `list[str]`
  - do not turn a beginner project into a typing puzzle
]

#slide(title: "Task idea: tests and types")[
  Start from code with a small numerical function and a hidden edge case.

  1. Run the existing pytest suite.
  2. Add one missing test.
  3. Add simple type hints to the public function.
  4. Run mypy.
  5. Fix the implementation.
  6. Run pytest and mypy again.
]

= Common Python Pitfalls

#slide(title: "Pitfall section scope")[
  This section keeps the pitfalls that are most useful for participants with
  basic Python knowledge.

  Advanced topics such as iterator exhaustion and closure late binding are good
  follow-up material, but they are not central for this course.
]

#slide(title: "Naming a module like a library")[
  If you create `math.py`, `random.py`, `typing.py`, or `logging.py`, it can
  shadow the standard-library module with the same name.

  ```text
  project/
  |- math.py
  `- analysis.py
  ```

  In `analysis.py`, `import math` may import your local file.
]

#slide(title: "Module shadowing: prevention")[
  Result: confusing import errors or missing attributes.

  Prevention:

  - avoid file names that collide with imported libraries
  - use clear project-specific names such as `geometry.py`
  - let tests and CI catch import behavior on a clean checkout
]

#slide(title: "Mutable default arguments")[
  Default arguments are evaluated once, when the function is defined.

  ```python
  def add_sample(value: float,
                 samples: list[float] = []) -> list[float]:
      samples.append(value)
      return samples
  ```

  Every call without `samples` reuses the same list.
]

#slide(title: "Mutable defaults: better")[
  ```python
  def add_sample(
      value: float,
      samples: list[float] | None = None,
  ) -> list[float]:
      if samples is None:
          samples = []
      samples.append(value)
      return samples
  ```

  Write a test that calls the function twice.
]

#slide(title: "Shallow and deep copies")[
  Assignment does not copy objects:

  ```python
  original = [[1, 2], [3, 4]]
  alias = original
  alias[0].append(99)
  print(original)
  ```

  Both names point to the same list.
]

#slide(title: "Shallow and deep copies: fixes")[
  A shallow copy copies the outer container:

  ```python
  copied = original.copy()
  ```

  A deep copy also copies nested objects:

  ```python
  from copy import deepcopy
  copied = deepcopy(original)
  ```

  Use `deepcopy` deliberately.
]

#slide(title: "Import-time side effects")[
  Code at module top level runs when the module is imported.

  Problem:

  ```python
  def main() -> None:
      print("Running analysis")

  main()
  ```

  This makes code hard to test and reuse.
]

#slide(title: "Import-time side effects: better")[
  ```python
  def main() -> None:
      print("Running analysis")

  if __name__ == "__main__":
      main()
  ```

  Keep command-line execution behind the `__name__` guard.
]

#slide(title: "Variable shadowing")[
  Avoid names that hide useful built-ins or imported objects:

  ```python
  list = [1, 2, 3]
  sum = 0
  ```

  These can break calls such as `list(...)` or `sum(...)`.
]

#slide(title: "Variable shadowing: prevention")[
  - use descriptive names such as `values`, `total`, or `records`
  - enable Ruff rules such as `A` for built-in shadowing when appropriate
]

#slide(title: "Task idea: pitfalls")[
  Start with a small project that has:

  - one mutable default argument
  - one import-time side effect
  - one shallow-copy surprise
  - one confusing name

  Students add or run tests, fix the problems, and confirm Ruff still passes.
]

= Modern Readable Python

#slide(title: "Readable Python")[
  Readable code is not necessarily shorter code.

  It is code where the reader can quickly see:

  - the data
  - the intent
  - the failure modes
]

#slide(title: "f-strings")[
  Use f-strings for readable string interpolation:

  ```python
  sample_id = "A42"
  temperature = 21.378

  message = f"Sample {sample_id} measured {temperature:.1f} C"
  ```

  The variable stays near the text that explains it.
]

#slide(title: "pathlib")[
  `pathlib.Path` represents file system paths as objects instead of fragile
  strings.

  String-based path handling:

  ```python
  filename = data_dir + "/" + sample_id + ".csv"
  ```

  Path-based handling:

  ```python
  filename = data_dir / f"{sample_id}.csv"
  ```
]

#slide(title: "pathlib methods and benefits")[
  ```python
  filename.exists()
  filename.read_text()
  filename.with_suffix(".json")
  filename.parent
  ```

  Benefits:

  - clearer path joining with `/`
  - fewer operating-system assumptions
  - convenient methods for common file operations
  - easier testing with temporary directories
]

#slide(title: "dataclasses")[
  Use `dataclasses` for small records with named fields:

  ```python
  from dataclasses import dataclass

  @dataclass
  class Measurement:
      sample_id: str
      temperature: float
      valid: bool = True
  ```
]

#slide(title: "When dataclasses help")[
  Dataclasses are useful when:

  - the data has a stable shape
  - field names matter
  - you pass the same group of values through several functions
  - you want a helpful representation for debugging

  They are often clearer than parallel lists or dictionaries with repeated
  string keys.
]

#slide(title: "logging")[
  Use `logging` for reusable code and `print` for small one-off scripts or final
  user-facing output.

  ```python
  import logging

  logger = logging.getLogger(__name__)

  def load_samples(path):
      logger.info("Loading samples from %s", path)
  ```
]

#slide(title: "logging configuration and benefits")[
  At the application entry point:

  ```python
  logging.basicConfig(level=logging.INFO)
  ```

  Benefits:

  - callers choose how much output they want
  - messages include severity levels
  - libraries do not force output on users
  - logs can be redirected or captured by tests
]

#slide(title: "Context managers")[
  Use context managers for resources that must be cleaned up:

  ```python
  from pathlib import Path

  path = Path("results.txt")

  with path.open("w") as handle:
      handle.write("done\n")
  ```

  The file is closed even if an error occurs inside the block.
]

#slide(title: "enumerate and zip")[
  ```python
  for index, value in enumerate(values):
      print(index, value)

  for sample_id, temperature in zip(sample_ids, temperatures):
      print(sample_id, temperature)
  ```

  If the sequences must have the same length, use `strict=True` in modern
  Python.
]

#slide(title: "Main functions")[
  Keep command-line behavior in a `main` function and protect it with the
  `__name__` guard:

  ```python
  def main() -> None:
      ...

  if __name__ == "__main__":
      main()
  ```

  This makes the module importable and testable.
]

#slide(title: "Task idea: readability")[
  Refactor a small analysis script:

  1. replace string path handling with `Path`
  2. replace a dictionary record with a dataclass
  3. replace manual string formatting with f-strings
  4. replace progress `print` calls with logging
  5. keep command-line execution behind `main`
  6. verify pytest and Ruff still pass
]

= Classroom50 Assignment Briefs

#slide(title: "Assignment structure")[
  Each classroom50 assignment should have:

  - a template repository with starter code and a student-facing README
  - a reference solution kept outside the student template
  - local commands that match the autograder
  - an autograder that reports small, actionable failures
]

#slide(title: "Assignment 1: Ruff and formatting")[
  Goal: experience automated style feedback.

  Starter state:

  - inconsistent formatting
  - unused imports or simple lint issues
  - at least one import-order issue
  - `pyproject.toml` with Ruff configuration

  Autograder: `ruff format --check .` and `ruff check .`
]

#slide(title: "Assignment 2: Tests and type hints")[
  Goal: see tests and type hints catch different classes of errors.

  Starter state:

  - small function with one bug
  - pytest suite with one missing edge-case test
  - minimal annotations missing from the public function

  Autograder: `python -m pytest` and `mypy .`
]

#slide(title: "Assignment 3: Pitfalls and readability")[
  Goal: fix beginner-relevant pitfalls while preserving behavior.

  Starter state:

  - mutable default argument
  - import-time side effect
  - shallow-copy surprise
  - fragile path built by string concatenation
  - progress `print` in reusable code
]

#slide(title: "Assignment 4: Project shape")[
  Goal: recognize when code should become package-shaped.

  Student tasks:

  - move reusable logic into `src/<package_name>/`
  - keep executable behavior in a script or `main` function
  - place tests under `tests/`
  - complete minimal `pyproject.toml` tool configuration
]

#slide(title: "Take-away")[
  A minimum healthy Python project has:

  - isolated environment
  - explicit project/tool configuration
  - Ruff formatting and linting
  - tests and simple type hints
  - Git and CI/pre-commit feedback
  - readable modern Python
]
