# Project setup

The goal of the first part is to make a Python project understandable before we
talk about code style. A future reader should be able to answer:

- Which Python environment should I use?
- Where are dependencies recorded?
- Is this a script or a package?
- Where are tests expected to live?
- Is the project under version control?

The development workflow for the whole course is:

```text
edit -> format/lint -> test -> commit -> review/CI
```

This is a feedback loop: after each change, tools and tests quickly tell you
whether the code is still readable, working, and ready to share. This part
covers the project setup pieces that make the workflow reproducible.

## Isolated environments

An isolated environment keeps a project's dependencies separate from your system
Python and from other projects. This helps because:

- different projects can require different package versions;
- installed tools do not accidentally leak between projects;
- collaborators can recreate the same setup more easily;
- CI and local development can use the same dependency list.

### venv

`venv` is part of Python and is a good default when you only need Python
packages from PyPI:

```bash
python -m venv .venv
source .venv/bin/activate  # Linux/macOS
python -m pip install --upgrade pip
python -m pip install ruff pytest mypy
```

On Windows, activation usually looks like:

```powershell
.venv\Scripts\activate
```

Add `.venv/` to `.gitignore`; the environment itself should not be committed.

### Conda

Conda is common in scientific Python, especially when a project depends on
compiled libraries or non-Python packages:

```bash
conda create -n my-project python=3.12
conda activate my-project
conda install numpy scipy
python -m pip install ruff pytest mypy
```

For a course or research group, Conda can be a practical choice when package
installation would otherwise be difficult on different operating systems.

### uv

[`uv`](https://docs.astral.sh/uv/) is a newer Python project and package manager
from the same organization as [Ruff](https://docs.astral.sh/ruff/). It can
create environments, install dependencies, run tools, manage lock files, and
support workspaces. It is worth knowing about, but this course does not require
it.

Use `uv` when your project benefits from faster installs, lock files, or a
single tool for project management. Use uv workspaces only for larger
repositories that intentionally contain multiple related packages.

## Script or package?

Not every file needs to become a package. A one-off script can stay a script.

Consider setting up a package when:

- code is imported from multiple scripts or notebooks;
- multiple people depend on the same functionality;
- you want automated tests and CI;
- you want documentation to point to importable functions/classes;
- you want to install the code into an environment;
- you want to publish or archive a reusable tool.

A minimal package-shaped project:

```text
my-project/
|- README.md
|- pyproject.toml
|- src/
|  `- my_project/
|     |- __init__.py
|     `- analysis.py
`- tests/
   `- test_analysis.py
```

The `src/` layout helps tests use the installed package instead of accidentally
importing files from the current directory. The `tests/` directory keeps tests
separate from library code.

For a full packaging course, see the [SSC Python packaging course](https://ssciwr.github.io/python-packaging/).
For a ready-to-use template, see the [SSC Python project template](
https://github.com/ssciwr/python-project-template) or the [Cookiecutter Python package template](https://github.com/ssciwr/cookiecutter-python-package).

## `pyproject.toml`

`pyproject.toml` started as a build-system configuration file, but today it is
also the standard place for project metadata and tool configuration.

A small project might eventually contain:

```toml
[project]
name = "my-analysis"
version = "0.1.0"
requires-python = ">=3.11"
dependencies = ["numpy", "pandas"]

[project.optional-dependencies]
dev = ["pytest", "ruff", "mypy"]

[tool.ruff]
line-length = 88

[tool.ruff.lint]
select = ["E", "F", "B", "I", "UP", "SIM"]

[tool.pytest.ini_options]
testpaths = ["tests"]
```

You do not need to understand all packaging details for this course. The key
idea is that a project should record enough information that another person, or
CI, can recreate the development setup.

## Git basics for this course

Git is the history and collaboration layer for this development workflow.

For this course, participants should know how to:

- clone a repository;
- create or edit files;
- inspect changes with `git status` and `git diff`;
- commit changes;
- push the committed changes to the remote repository.

Recommended project files:

- `.gitignore` for files that should not be committed, such as `.venv/`,
  caches, build artifacts, and local editor files;
- `README.md` for setup and usage instructions;
- `pyproject.toml` or another explicit dependency/configuration file;
- tests and CI configuration once the project grows beyond a throwaway script.

Git does not make code good by itself. It makes changes visible, reviewable, and
recoverable.
