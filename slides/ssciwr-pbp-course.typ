#import "@preview/touying:0.7.4": *
#import "ssc-theme.typ": *

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
  text(size: 10.5pt, it),
)
#set raw(theme: auto)

#let logo(text, icon, baseline: 10%, hspace: 0.05em, height: 0.9em) = box[
  #text
  #h(hspace)
  #box(
    baseline: baseline,
    image(icon, height: height),
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

#show: institution-theme.with(
  title-logo: image("ssc_iwr_uni_logos_darkmode.svg"),
  slide-logo: image("ssc_logo_and_text.svg"),
  config-info(
    title: [Best Practices in #logo("", baseline: 40%, hspace: 0.2em, height: 1.5em, "figures/python-logo-generic.svg") Programming],
    author: [Thomas Isensee],
    date: datetime.today(),
    institution: [Scientific Software Center (SSC), Heidelberg University],
  ),
)

#title-slide()

== Outline <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

= Course Overview

#slide(title: "Course focus")[
  #logo("Python", "figures/python-logo.svg") is widely used in science and research, from quick data analysis scripts to reusable packages and simulation workflows.

  This course focuses on practical habits and tools that make Python code easier to read, test, review, and share with collaborators.
]

#slide(title: "What this course is not")[
  This is not a full introduction to:

  - testing
  - packaging
  - Git
  - continuous integration (CI)

  We cover the minimum useful practices and point to dedicated #link("https://www.ssc.uni-heidelberg.de/en/learning/all-courses")[SSC courses].
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
  #align(center)[
    #block(
      fill: luma(80.78%),
      inset: 12pt,
      radius: 8pt,
      [Edit \u{27F6} Format/Lint \u{27F6} Test \u{27F6} Commit \u{27F6} Review/CI]
    )
  ]

  This is a feedback loop: after each change, tools and tests quickly tell you whether the code is still readable, working, and ready to share.
]

#slide(title: "Related SSC material")[
  - Python testing: #link(testing-url)[Introduction to Python Testing]
  - Python packaging: #link(packaging-url)[Python Packaging]
  - Project template: #link(template-url)[SSC Python project template]
  - Project cookiecutter: #link(cookiecutter-url)[SSC Python package template]
]

= Project Setup

#slide(title: [#logo("Git", "figures/git-logo.svg") basics for this course])[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    grid.header([*Basic Git functionality*], [*Recommended project files*],),
    [
      Git is the history and collaboration layer for this development workflow.

      Participants should know how to:

      - clone a repository
      - create or edit files
      - inspect changes with `git status` and `git diff`
      - commit changes
      - push committed changes to the remote repository
    ],
    [
  - `.gitignore` for files that should not be committed
  - `README.md` for setup and usage instructions
  - `pyproject.toml` or another explicit dependency/configuration file
  - tests and CI once the project grows beyond a throwaway script

  Git makes changes visible, reviewable, and recoverable.
    ]
  )
]

#slide(title: "Questions a project should answer")[
  Before talking about code style, a project should make clear:

  - Which Python environment should I use?
  - Where are dependencies recorded?
  - Is this a script or a package?
  - Where are tests expected to live?
  - Is the project under version control?
]

#slide(title: "Why isolated environments?")[
  An isolated environment keeps a project's dependencies separate from your system Python and from other projects.

  Benefits:

  - different projects can need different versions
  - installed tools do not leak between projects
  - collaborators can recreate the setup
  - CI and local development can use the same dependency list
]

#slide(title: "venv")[
  `venv` is part of Python and is a good default when you only need Python packages from PyPI.

  ```bash
  python -m venv .venv
  source .venv/bin/activate
  python -m pip install --upgrade pip
  python -m pip install ruff pytest mypy
  ```

  Add `.venv/` to `.gitignore`.
]

#slide(title: "Conda")[
  Conda is common in scientific Python, especially when a project depends on compiled libraries or non-Python packages.

  ```bash
  conda create -n my-project python=3.14.6
  conda activate my-project
  conda install numpy scipy
  python -m pip install ruff pytest
  ```
]

#slide(title: logo("uv", "figures/uv-logo-letter.svg"))[
  #link(uv-url)[uv] is a newer Python project and package manager from the same organization as Ruff.

  It can:

  - create environments
  - install dependencies
  - run tools
  - manage lock files
  - support workspaces

  Highly recommended, not required for this course.
]

#slide(title: "Script or package?")[
  Not every file needs to become a package. A script with a small test function can stay a script, or a notebook.

  Consider a package when code is:

  - imported from multiple scripts or notebooks
  - reused by collaborators
  - tested in CI
  - documented as an importable API
  - installed into an environment
  - published or archived as a reusable tool
]

#slide(title: "Minimal package-shaped project")[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    grid.header([*Project structure*], [],),
    [
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

      `src/` helps tests use the installed package.

      `tests/` keeps tests separate from library code.

      `README.md` contains general information about the repository and is displayed as front page on GitHub and others.
    ],
    []
  )
]

#slide(title: "Minimal package-shaped project")[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    grid.header([*Project structure*], [*Project metadata*],),
    [
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

      `src/` helps tests use the installed package.

      `tests/` keeps tests separate from library code.

      `README.md` contains general information about the repository and is displayed as front page on GitHub and others.
    ],
    [
      `pyproject.toml` started as build-system configuration, but today it is also the standard place for project metadata and tool configuration.

      It can record:

      - project metadata (Version, description, authors etc.)
      - supported Python versions
      - dependencies
      - optional development dependencies
      - tool settings for Ruff, pytest, mypy, setuptools, and others
    ]
  )
]

#slide(title: "pyproject.toml")[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    grid.header([*File content*], [*Project metadata*],),
    [
      ```toml
      [project]
      name = "my-analysis"
      version = "0.1.0"
      requires-python = ">=3.11"
      dependencies = ["numpy", "pandas"]

      [project.optional-dependencies]
      dev = ["pytest", "ruff", "mypy"]
      ```

      The key idea: another person or CI should be able to recreate the setup without any effort.
    ],
    [
      `pyproject.toml` started as build-system configuration, but today it is also the standard place for project metadata and tool configuration.

      It can record:

      - project metadata (Version, description, authors etc.)
      - supported Python versions
      - dependencies
      - optional development dependencies
      - tool settings for Ruff, pytest, mypy, setuptools, and others
    ]
  )
]

#slide(title: "Tool configuration example")[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    grid.header([*File content*], [*Project metadata*],),
    [
      ```toml
      [project]
      name = "my-analysis"
      version = "0.1.0"
      requires-python = ">=3.11"
      dependencies = ["numpy", "pandas"]

      [project.optional-dependencies]
      dev = ["pytest", "ruff", "mypy"]
      ```

      The key idea: another person or CI should be able to recreate the setup without any effort.
      ```toml
      [tool.ruff]
      line-length = 88

      [tool.pytest.ini_options]
      testpaths = ["tests"]
      ```
    ],
    [
      `pyproject.toml` started as build-system configuration, but today it is also the standard place for project metadata and tool configuration.

      It can record:

      - project metadata (Version, description, authors etc.)
      - supported Python versions
      - dependencies
      - optional development dependencies
      - tool settings for Ruff, pytest, mypy, setuptools, and others
    ]
  )
]

= PEPs, Style, Ruff, and pre-commit

#slide(title: "Why style comes after setup")[
  Once the project shape is clear, we can talk about code style.

  The central idea is not to memorize every rule. The central idea is to make code predictable enough that readers can focus on meaning.
]

#slide(title: "PEPs and PEP 8")[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    grid.header([*PEPs*], [*PEP 8*],),
    [
      Python Enhancement Proposals (PEPs) describe Python language changes, processes, and conventions.

      - PEP index: #link(peps-url)[peps.python.org]
      - PEP 8: #link(pep8-url)[style guide for Python code]

      PEP 8 covers naming, indentation, imports, whitespace, comments, and layout conventions.
    ],
    [
      For this course, the most important message is:

      - prefer consistency over personal taste
      - prefer readable code over clever code
      - automate formatting and linting whenever possible
      - adapt when a project already has a local style
    ]
  )
  #v(2em)
  #align(center)[Easter Egg: Type #raw(block: false, lang: "python", "import this") and find enlightenment.]
]

#slide(title: "PEPs and PEP 8")[
  #grid(
    columns: (1fr, 1fr),
    rows: 2,
    column-gutter: 1em,
    row-gutter: (1em, 5em),
    grid.header([*PEPs*], [*PEP 8*],),
    [
      Python Enhancement Proposals (PEPs) describe Python language changes, processes, and conventions.

      - PEP index: #link(peps-url)[peps.python.org]
      - PEP 8: #link(pep8-url)[style guide for Python code]

      PEP 8 covers naming, indentation, imports, whitespace, comments, and layout conventions.
    ],
    [
      For this course, the most important message is:

      - prefer consistency over personal taste
      - prefer readable code over clever code
      - automate formatting and linting whenever possible
      - adapt when a project already has a local style
    ],
    [
      - Use 4 spaces per indentation level.
      - Put imports at the top of the file.
      - Prefer one import per line.
      - Use `lowercase_with_underscores` for functions and variables.
    ],
    [
      - Use `CamelCase` for classes.
      - Avoid ambiguous names such as `l`, `O`, and `I`.
      - Keep comments and code consistent.
      - #text(fill: red)[BORING!]
    ]
  )
]

#slide(title: "Automated style feedback")[
  Manual style review is expensive and not very interesting (it's boring!).

  Let tools handle the boring parts so humans can review:

  - names
  - structure / architecture
  - tests
  - scientific correctness
  - performance
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
    #align(left)[It's very fast!]
  ]
]

#slide(title: "Install and run Ruff")[
  Install Ruff via #raw(block: false, lang: "bash", "python -m pip install ruff")
  #v(2em)
  #grid(
    columns: (1fr, 1fr),
    rows: 2,
    column-gutter: 1em,
    row-gutter: (1em, 5em),
    grid.header([*Linting*], [*Formatting*],),
    [
      Linters focus on code health and bug detection.
      ```bash
      ruff check path/to/code.py
      ruff check path/to/package/
      ```
      or
      ```bash
      # Apply safe automatic lint fixes
      ruff check --fix .
      ```
      or check #logo("Jupyter", "figures/jupyter-logo.svg") notebooks
      ```bash
      ruff check analysis.ipynb
      ```
    ],
    [
      Formatters focus on visual style and rewrite text layout.
      ```bash
      ruff format path/to/code.py
      ruff format path/to/package/
      ```
      or
      ```bash
      # Check formatting without changing files
      ruff format --check .
      ```
    ]
  )
]

#slide(title: "Reading Ruff messages")[
  Ruff reports the rule, location, code context, and often a fix.
  ```bash
F401 [*] `os` imported but unused
 --> sensor_report.py:6:8
  |
4 | import statistics
5 | from pathlib import Path
6 | import os
  |        ^^
7 |
8 | DATA_FILE=Path(__file__).parent / "data" / "readings.csv"
  |
help: Remove unused import: `os`
  |
5 | from pathlib import Path
  - import os
  ```

  - `E401` is the rule code.
  - `sensor_report.py:6:8` is file, line, and column.
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
  In a standalone #raw(block: false, "ruff.toml"), omit the #raw(block: false, "tool.ruff") prefix:

  ```toml
  line-length = 88

  [lint]
  select = ["E", "F", "B", "I", "UP", "SIM"]
  ```
][Start with a small rule set and add more rules deliberately.]

#slide(title: logo("pre-commit", "figures/pre-commit-logo.svg"))[
  `pre-commit` runs checks before a commit is created.
  #v(2em)
  #grid(
    columns: (1fr, 1fr),
    rows: 2,
    column-gutter: 1em,
    row-gutter: (1em, 5em),
    grid.header([*Install/Setup*], [*Configuration*],),
    [
      This helps when a project starts clean, then collaborators join and not everyone uses the same editor setup.

      ```bash
      python -m pip install pre-commit
      pre-commit install
      ```
  ],
  [
    `.pre-commit-config.yaml` in repository root:
    ```yaml
    repos:
      - repo: https://github.com/astral-sh/ruff-pre-commit
        rev: v0.16.4
        hooks:
          - id: ruff-check
            args: [--fix, --show-fixes]
          - id: ruff-format
    ```

    Run all hooks manually with #raw(block: false, lang: "bash", "pre-commit run --all-files").
  ]
  )
]

#slide(title: "pre-commit and GitHub")[
  Services such as #link("https://pre-commit.ci/")[`pre-commit.ci`] can run the same hooks on pull requests and
  even commit automatic fixes.

  #align(left)[
    #figure(
      image("figures/pre-commit-bot-gh.png", width: 100%),
    )
  ]
  #v(2em)
  #align(center)[Your colleagues won't be able to mess up your code!]
]

#slide(title: [Task 1: #raw(block: false, lang: "bash", "gh student accept ssciwr-courses pbp-2026-09-16 section3-ruff")])[
  #grid(
    columns: (1fr, 1fr),
    rows: 2,
    gutter: 1em,
    grid.cell(rowspan: 2)[
      1. Install Ruff and pre-commit via #raw(block: false, lang: "bash", "python -m pip install ruff pre-commit")
      2. Run #raw(block: false, lang: "bash", "ruff check .") and inspect the output.
      3. Run #raw(block: false, lang: "bash", "ruff check --fix .") and inspect the diff via #raw(block: false, lang: "bash", "git diff").
      4. Run #raw(block: false, lang: "bash", "ruff format .") and inspect the diff via #raw(block: false, lang: "bash", "git diff").
      5. Add a pre-commit configuration file `.pre-commit-config.yaml`.
    ],
    [
      `.pre-commit-config.yaml` in repository root:
      ```bash
      repos:
      - repo: https://github.com/astral-sh/ruff-pre-commit
        rev: v0.16.4
        hooks:
          - id: ruff-check
            args: [--fix, --show-fixes]
          - id: ruff-format
      ```

      6. Run #raw(block: false, lang: "bash", "pre-commit install").
      7. Commit changes via #raw(block: false, lang: "bash", "git commit -m \"Fix format\"")
      8. Run #raw(block: false, lang: "bash", "gh student submit") for submitting.
  ]
  )
]

= Tests and Type Hints

#slide(title: "Why tests are essential?")[
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
  #grid(
    columns: (3fr, 2fr),
    gutter: 1em,
    grid.header([*Code under test*], [*A pytest example*],),
    [
      ```python
      def mean(values):
          return sum(values) / len(values)
      ```
      #v(4em)
      ```bash
      python -m pytest
      ```

      The pattern:

      - put expected behavior in code
      - cover normal cases and edge cases
      - run tests before and after refactoring
      - ideally run tests in GitHub CI (or other) upon any pull request
    ],
    [
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
  )
]

#slide(title: "Type hints")[
  Type hints describe what kind of values code expects and returns:

  ```python
  def total(values: list[float]) -> float:
      return sum(values)
  ```

  Python does not normally enforce these annotations at runtime. Their main value is that they help readers, editors, and type-checking tools.
]

#slide(title: logo("", "figures/mypy_light.svg"))[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    grid.header([*Installation/Setup*], [*Example*],),
    [
      Install mypy:

      ```bash
      python -m pip install mypy
      ```

      Run it:

      ```bash
      mypy path/to/code.py
      ```
    ],
    [
      ```python
      def total(values: list[float]) -> float:
          return sum(values)

      measurements = ["1.0", "2.0", "3.0"]
      print(total(measurements))
      ```

      At runtime this fails. A type checker can flag the mistake earlier:
      `list[str]` is not `list[float]`.
    ]
  )
]

#slide(title: "Keep type hints simple")[
  Type hints are most useful when they stay simple:

  - annotate public functions
  - annotate ambiguous data structures
  - use `str | None` for optional values
  - prefer built-in generics such as `list[str]`
  - do not turn a beginner project into a typing puzzle
]

#slide(title: [Task 2: #raw(block: false, lang: "bash", "gh student accept ssciwr-courses pbp-2026-09-16 section4-tests")])[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      1. Install mypy via #raw(block: false, lang: "bash", "python -m pip install mypy").
      2. Run #raw(block: false, lang: "bash", "python -m sample_summary") and #raw(block: false, lang: "bash", "python -m pytest").
    ],
    [
      3. Now run #raw(block: false, lang: "bash", "python -m mypy sample_summary.py").
      4. Examine the issues and fix them.
    ]
  )
]

#slide(title: [Task 2: #raw(block: false, lang: "bash", "gh student accept ssciwr-courses pbp-2026-09-16 section4-tests")])[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      1. Install mypy via #raw(block: false, lang: "bash", "python -m pip install mypy").
      2. Run #raw(block: false, lang: "bash", "python -m sample_summary.py") and #raw(block: false, lang: "bash", "python -m pytest").
    ],
    [
      3. Now run #raw(block: false, lang: "bash", "python -m mypy sample_summary.py").
      4. Examine the issues and fix them.
    ]
  )
  ```python
    return [float(row[1]) for row in rows]
  ```
  ```python
    def render_summary(total: float, accepted: bool) -> str:
  ```

  5. Extend `tests/test_sample_summary.py` with a test `test_tolerance_boundary_is_included` expressing this requirement:
  ```text
  A measured value exactly one tolerance away from its target is accepted. For example, `9.5` is within a tolerance of `0.5` around `10.0`.
  ```
]

#slide(title: [Task 2: #raw(block: false, lang: "bash", "gh student accept ssciwr-courses pbp-2026-09-16 section4-tests")])[

  ```python
  def test_tolerance_boundary_is_included() -> None:
      assert is_within_tolerance(9.5, target=10.0, tolerance=0.5)
  ```

  1. Run #raw(block: false, lang: "bash", "python -m pytest") again.
  2. Run #raw(block: false, lang: "bash", "gh student submit") for submitting.

]

= Common Python Pitfalls

#slide(title: "Pitfall section scope")[
  This section focuses on mistakes that can silently change results or make a small script difficult to reuse.

  The goal is not to collect every surprising Python behavior. Iterator exhaustion and closure late binding are useful follow-up topics, but they are not central for this course.
]

#slide(title: "Names refer to objects")[
  Assigning a list to another name does not copy it:

  ```python
  original = [[1, 2], [3, 4]]
  alias = original
  alias[0].append(99)
  print(original)  # [[1, 2, 99], [3, 4]]
  ```

  Both names refer to the same object. A mutation through either name is visible through the other.
]

#slide(title: "Copy nested data deliberately")[
  A shallow copy creates a new outer list, but nested objects are still shared:

  ```python
  copied = original.copy()
  copied[0].append(99)
  ```

  When nested values must be independent, copy the known structure explicitly or use `deepcopy` deliberately:

  ```python
  from copy import deepcopy

  copied = deepcopy(original)
  ```

  `deepcopy` may copy more than intended. Copy only when independent state is actually required.
]

#slide(title: "Mutable default arguments")[
  Defaults are evaluated once, so this list is shared between calls:

  ```python
  def add_sample(value: float, samples: list[float] = []) -> list[float]:
      samples.append(value)
      return samples
  ```

  Use `None` and create a new list inside the function:

  ```python
  def add_sample(value: float, samples: list[float] | None = None) -> list[float]:
      samples = [] if samples is None else samples
      samples.append(value)
      return samples
  ```

  Test this by calling the function twice.
]

#slide(title: "Compare floating-point values deliberately")[
  ```python
  total = 0.1 + 0.2
  total == 0.3  # False
  ```

  Use a tolerance appropriate for the domain:

  ```python
  import math
  import pytest

  math.isclose(total, 0.3, rel_tol=1e-9)
  assert total == pytest.approx(0.3, rel=1e-9)
  ```

  Boundary cases still need tests; type checking cannot find a wrong `<` where `<=` was intended.
]

#slide(title: "Do not silence failures")[
  A broad exception handler can silently turn bad input into plausible output:

  ```python
  try:
      return float(text)
  except Exception:
      return 0.0
  ```

  Catch only errors you can handle, and retain useful context:

  ```python
  try:
      return float(text)
  except ValueError as error:
      raise ValueError(f"Invalid measurement: {text!r}") from error
  ```
]

#slide(title: "Missing is not the same as falsy")[
  `0`, `0.0`, empty containers, and `None` are all falsy, but they do not necessarily mean the same thing:

  ```python
  def effective_tolerance(tolerance: float | None) -> float:
      if not tolerance:
          return 0.1  # Also replaces a valid 0.0.
      return tolerance
  ```

  If only `None` means "not provided", test for it explicitly:

  ```python
  if tolerance is None:
      return 0.1
  ```
]

#slide(title: "Assertions are not input validation")[
  Assertions are useful in tests and for developer assumptions, but Python can remove them when run with optimization:

  ```python
  assert tolerance >= 0
  ```

  Validate external input with an explicit exception:

  ```python
  if tolerance < 0:
      raise ValueError("tolerance must be non-negative")
  ```
]

#slide(title: "Names can hide other names")[
  A local `math.py` can hide the standard-library module. Variables can also hide built-ins:

  ```text
  project/
  ├── math.py
  └── analysis.py
  ```
  ```python
  list = [1, 2, 3]
  sum = 0
  ```

  Prefer project-specific module names and descriptive variables. Selected Ruff `A` rules can detect these problems.
]

#slide(title: "Import-time side effects")[
  Module-level code runs during import. Keep reusable logic in functions and
  command-line execution behind the `__name__` guard:

  ```python
  def main() -> None:
      print("Running analysis")

  if __name__ == "__main__":
      main()
  ```

  The guard prevents `main()` from running when tests or other programs import the module.
]

#slide(title: [Task 3: #raw(block: false, lang: "bash", "gh student accept ssciwr-courses pbp-2026-09-16 section5-pitfalls")])[

  #grid(
    columns: (1fr, 1fr),
    rows: 2,
    gutter: 1em,
    [
      1. Add a test that checks record_warning with default argument.
      ```python
      def test_record_warning_uses_a_fresh_default() -> None:
          assert record_warning("first") == ["first"]
          assert record_warning("second") == ["second"]
      ```

      2. Fix the mutable default argument.
      ```python
      def record_warning(
          message: str,
          warnings: list[str] | None = None,
      ) -> list[str]:
          if warnings is None:
              warnings = []
          warnings.append(message)
          return warnings
      ```
    ],
    [
      3. Add test for sum of two measurements.
      ```python
      def test_total_value_uses_approximate_float_comparison() -> None:
          measurements = [
              Measurement("A", 0.1, "mm"),
              Measurement("B", 0.2, "mm"),
          ]

          assert total_value(measurements) == pytest.approx(0.3)
      ```

      4. Test that zero is a valid tolerance.
      ```python
      def test_zero_is_a_valid_tolerance() -> None:
        assert effective_tolerance(0.0) == 0.0
      ```


    ]
  )
]
#slide(title: [Task 3: #raw(block: false, lang: "bash", "gh student accept ssciwr-courses pbp-2026-09-16 section5-pitfalls")])[

  #grid(
    columns: (1fr, 1fr),
    rows: 2,
    gutter: 1em,
    [
      5. Fix `effective_tolerance`.
      ```python
      def effective_tolerance(requested: float | None) -> float:
          """Return the requested tolerance or the workflow default."""
          if requested is None:
              return DEFAULT_TOLERANCE
          return requested
      ```
      6. Test that invalid measurements raise an error.
      ```python
        def test_parse_invalid_measurement() -> None:
            with pytest.raises(ValueError, match="not-a-number"):
                parse_measurement("A5", "not-a-number", "C")
      ```
    ],
    [
      7. Let possible errors propagate and do not invent replacement values.
      ```python
      def parse_measurement(sample_id: str, text: str, unit: str) -> Measurement:
          """Parse one measurement exported by an instrument."""
          value = float(text)
          return Measurement(sample_id, value, unit)
      ```

      8. Run #raw(block: false, lang: "bash", "python -m pytest") again.
      9. Run #raw(block: false, lang: "bash", "ruff check --fix .") and #raw(block: false, lang: "bash", "ruff format .")
      10. Run #raw(block: false, lang: "bash", "gh student submit") for submitting.
    ]
  )
]

= Modern Readable Python

#slide(title: "Readable Python")[
  Readable code is not necessarily shorter code.

  It is code where the reader can quickly see:

  - the data
  - the intent
  - the failure modes
]

#slide(title: "Docstrings")[
  #grid(
    columns: (3fr, 4fr),
    gutter: 1em,
    [
      \u{2718}
      ```python
    def some_function(par1: str, par2: str) -> str:
        return par1 + "/" + par2 + ".txt"
      ```
    ],
    [
      \u{2714}
      ```python
      def some_function(par1: str, par2: str) -> str:
          """Combine strings.

          Args:
              par1: First string.
              par2: Second string.

          Returns:
              A string composed of two input strings, divided by a forward slash.
          """
          return output_dir / f"{sample_id}.txt"
      ```
    ]
  )

  #grid(
    columns: (1fr, 2fr, 1fr),
    [Shift + Tab shows useful info:],
    align(center)[
      #figure(
        image("figures/docstring_jupyter.png", width: 100%),
      )
    ],
    []
  )
]

#slide(title: "f-strings")[
  Use f-strings for readable string interpolation:
  #grid(
    rows: 2,
    gutter: 1em,
    [
      \u{2718} (not wrong)
      ```python
      sample_id = "A5"
      temperature = 21.378

      message = "Sample " + sample_id + " measured " + str(temperature) + " C"
      ```
    ],
    [
      \u{2714} (better)
      ```python
      sample_id = "A5"
      temperature = 21.378

      message = f"Sample {sample_id} measured {temperature:.1f} C"
      ```
      The variable stays near the text that explains it.
    ]
  )

]

#slide(title: "pathlib")[
  `pathlib.Path` represents file system paths as objects instead of fragile strings.

  String-based path handling \u{2718} (not wrong):

  ```python
  filename = data_dir + "/" + sample_id + ".csv"
  ```

  Path-based handling \u{2714} (better):

  ```python
  from pathlib import Path

  data_dir = Path("data")
  filename = data_dir / f"{sample_id}.csv"
  ```
  Uses appropritate paths depending on the OS (don't worry about "/" or "\\" anymore.)
]

#slide(title: "pathlib methods and benefits")[
  Benefits:

  - clearer path joining with `/`
  - fewer operating-system assumptions
  - convenient methods for common file operations
  - easier testing with temporary directories

  #grid(
    columns: (1fr, 2fr, 2fr),
    gutter: 1em,
    [
      ```python
      path.exists()
      path.is_file()
      path.parent
      path.name
      path.suffix
      path.stem
      ```
    ],
    [
      ```python
      output_dir = Path("results")
      output_dir.mkdir(parents=True, exist_ok=True)
      ```
    ],
    [
      ```python
      with open(path) as f:
          ...
      ```
      ```python
      text = path.read_text()
      path.write_text("hello")
      ```
    ]
  )
]

#slide(title: "Relative paths depend on the working directory")[
  `Path("data/results.csv")` is resolved relative to the current working directory, which may differ between a terminal, an editor, and CI.

  Prefer passing paths into reusable functions. At the application boundary, choose the base directory explicitly:

  ```python
  from pathlib import Path

  def load_results(path: Path) -> str:
      return path.read_text(encoding="utf-8")

  project_dir = Path(__file__).parent
  load_results(project_dir / "data" / "results.csv")
  ```
]

#slide(title: "Dataclasses make records explicit")[
  Use a dataclass for a small record with a known set of named fields:

  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
    \u{2718} (not wrong)
    ```python
    class Point:
        def __init__(self, x: float, y: float):
            self.x = x
            self.y = y

        def __repr__(self):
            return f"Point(x={self.x!r}, y={self.y!r})"

        def __eq__(self, other):
            if not isinstance(other, Point):
                return NotImplemented
            return self.x == other.x and self.y == other.y
    ```
    ],
    [
    \u{2714} (better)
    ```python
    from dataclasses import dataclass

    @dataclass(frozen=True, slots=True, order=True)
    class Point:
        x: float
        y: float
    ```
    Generates initializer, a readable representation, and value-based equality. The annotations document the fields, but do not validate values at runtime.

    `frozen=True`: prevents reassignment of fields.
    `slots=True`: generally reduces memory use.
    `order=True`: generates <, <=, >, and >= (in field order).
    ]
  )
]

#slide(title: "Frozen records reduce accidental changes")[
  `frozen=True` prevents fields from being reassigned after creation:

  ```python
  from dataclasses import dataclass

  @dataclass(frozen=True)
  class Measurement:
      sample_id: str
      value: float
      unit: str
  ```

  Freezing is shallow: a list stored in a frozen record can still be mutated. Prefer immutable field types such as tuples when appropriate.
]

#slide(title: "Mutable fields need a factory")[
  Dataclasses reject a list as a direct default. Give each instance its own list with `default_factory`:

  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
    \u{2718}
    ```python
    @dataclass
    class Mesh:
        vertices: list = []  # ValueError
    ```
    This would conceptually risk all instances sharing the same list, so dataclasses reject it.
  ],
  [
    \u{2714}
    ```python
    @dataclass
    class SamplingRun:
        run_id: str
        values: list[float] = field(default_factory=list)
    ```
    This is the dataclass equivalent of avoiding a mutable default argument. Factories also work for dictionaries, sets, and more complex defaults.
  ]
  )
]

#slide(title: "Dataclasses in scientific workflows")[
  Dataclasses are useful when:

  - each record has the same known set of fields
  - values should travel with metadata such as units or sample identifiers
  - functions pass the same record between processing stages
  - equality and readable output make tests and debugging easier

  It is especially suitable for configuration objects, coordinates, simulation parameters, records, and intermediate results.

  They are often clearer than parallel lists or dictionaries with repeated string keys. They are not a replacement for large numerical arrays or tables; choose a container that matches the data and operations.
]

#slide(title: "logging")[
  Use `logging` for reusable code and `print` for small one-off scripts or final user-facing output.



  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      \u{2718}
      ```python
      def load_samples(path):
          print("Loading samples from %s", path)
      ```
    ],
    [
      \u{2714}
      ```python
      import logging

      logger = logging.getLogger(__name__)

      def load_samples(path):
          logger.info("Loading samples from %s", path)
      ```
    ]
  )
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      Every log message has a severity level:
      ```python
      logging.debug("Detailed diagnostic information")
      logging.info("Program started")
      logging.warning("Something looks suspicious")
      logging.error("Something failed")
      logging.critical("Something went very badly wrong")
      ```
    ],
    [
      At the application entry point, choose the desired level of the logger:
      ```python
      logging.basicConfig(level=logging.INFO)

      logging.debug("debug")      # not shown
      logging.info("info")        # shown
      logging.warning("warning")  # shown
      logging.error("error")      # shown
      ```
    ]
  )
]

#slide(title: "Context managers")[
  Use context managers for resources that must be cleaned up:

  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
    \u{2718}
    ```python
    from pathlib import Path

    path = Path("results.txt")

    handle = path.open("w")
    handle.write("done\n")
    handle.close()
    ```
    ],
    [
    \u{2714}
    ```python
    from pathlib import Path

    path = Path("results.txt")

    with path.open("w") as handle:
        handle.write("done\n")
    ```
    The file is closed even if an error occurs inside the block.
    ]
  )
]

#slide(title: "enumerate and zip")[
  #grid(
    columns: (6fr, 7fr),
    rows: 2,
    gutter: 1em,
    grid.header([*enumerate*], [*zip*],),
    [
      \u{2718} (not wrong)
      ```python
      for index in range(len(values)):
          value = values[index]
          print(index, value)
      ```
    ],
    [
      \u{2718} (not wrong)
      ```python
      for index in range(len(sample_ids)):
          sample_id = sample_ids[index]
          temperature = temperatures[index]
          print(sample_id, temperature)
      ```
    ],
    [
      \u{2714} (better)
      ```python
      for index, value in enumerate(values):
          print(index, value)
      ```
    ],
    [
      \u{2714} (better)
      ```python
      for sample_id, temperature in zip(sample_ids, temperatures):
          print(sample_id, temperature)
      ```
    ]
  )
]

#slide(title: [Task 4: #raw(block: false, lang: "bash", "gh student accept ssciwr-courses pbp-2026-09-16 section6-readable-python")])[

  #grid(
    columns: (1fr, 1fr),
    rows: 2,
    gutter: 1em,
    [
    ],
    [
    ]
  )
]
#slide(title: [Task 4: #raw(block: false, lang: "bash", "gh student accept ssciwr-courses pbp-2026-09-16 section6-readable-python")])[

  #grid(
    columns: (1fr, 1fr),
    rows: 2,
    gutter: 1em,
    [
    ],
    [
      8. Run #raw(block: false, lang: "bash", "python -m pytest") again.
      9. Run #raw(block: false, lang: "bash", "ruff check --fix .") and #raw(block: false, lang: "bash", "ruff format .")
      10. Run #raw(block: false, lang: "bash", "gh student submit") for submitting.
    ]
  )
]

= Comment on AI/LLM usage

#slide(title: "AI/LLM usage")[
  1. Ask for best practices.
  2. Ask for modern Python.
  3. Ask for tests.
  4. Ask for documentation comments.

  Example `AGENTS.md`:
  ```text
  This is a collection of my analysis scripts. Please write modern Python (3.11 or higher), apply common best practice techniques, and write reasonable tests in the test/ directory. Each (public) function should have a reasonable documentation comment that explains at least the input parameters and the ouptut.

  Run "ruff --check .", "ruff --format .", and "mypy ." to validate any changes.
  ```

  5. Use a CLI agent (e.g., Codex), then you don't have to copy-paste code into a chat.
]
