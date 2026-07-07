# Course prerequisites

Please set up the tools below before the course. The exercises use GitHub and classroom50, so a working command-line setup is important.

If you already use Conda, pyenv, uv, or an IDE-managed Python installation, that is fine. The important part is that the verification commands at the end work.

## Required accounts and tools

- A GitHub account: <https://github.com/>
- Python 3.11 or newer: <https://www.python.org/downloads/>
- Git: <https://git-scm.com/downloads/>
- GitHub CLI (`gh`): <https://github.com/cli/cli#installation>
- classroom50 student CLI extension
- A terminal or shell

Recommended, but not required:

- VS Code or another Python-aware editor/IDE

## Linux

If you do not already have a preferred Python setup, Conda can be a convenient option because it manages both Python installations and isolated environments. [Miniconda](https://docs.anaconda.com/miniconda/) is a compact Conda installer. This is only a suggestion, not a course requirement.

Use your distribution's package manager. On Debian or Ubuntu, this is usually:

```bash
sudo apt update
sudo apt install python3 python3-venv python3-pip git
```

Install GitHub CLI using the official instructions for your distribution: <https://github.com/cli/cli#installation>

After installing `gh`, continue with [classroom50 setup](#classroom50-setup).

## macOS

Option 1: use official installers:

- Python: <https://www.python.org/downloads/macos/>
- Git: <https://git-scm.com/download/mac>
- GitHub CLI: <https://github.com/cli/cli#installation>

Option 2: use Homebrew:

```bash
brew install python git gh
```

After installing `gh`, continue with [classroom50 setup](#classroom50-setup).

## Windows

If you do not already have a preferred Python setup, Conda can be a convenient option on Windows because it manages both Python installations and isolated environments. [Miniconda](https://docs.anaconda.com/miniconda/) is a compact Conda installer. This is only a suggestion, not a course requirement; any setup that provides Python 3.11 or newer is fine.

Conda does not replace Git or GitHub CLI, so install those separately using one of the options below.

Option 1: use official installers:

- Python: <https://www.python.org/downloads/windows/>
- Git for Windows: <https://git-scm.com/download/win>
- GitHub CLI: <https://github.com/cli/cli#installation>

When installing Python, enable the option that adds Python to `PATH`.

Option 2: use `winget` in PowerShell:

```powershell
winget install --id Python.Python.3.14 -e
winget install --id Git.Git -e
winget install --id GitHub.cli -e
```

If the exact Python package is not available, install any Python version 3.11 or newer from <https://www.python.org/downloads/windows/>.

After installing `gh`, continue with [classroom50 setup](#classroom50-setup).

## classroom50 setup

The course assignments use classroom50 through a GitHub CLI extension.

Install the student extension:

```bash
gh extension install foundation50/gh-student
```

Check that it is available:

```bash
gh student --help
```

Log in for classroom assignments:

```bash
gh student login
```

This starts the GitHub login flow with the permissions needed to accept and submit classroom50 assignments. The browser-based login is usually the easiest option.

If the extension is already installed, update it with:

```bash
gh extension upgrade gh-student
```

## Verify your setup

On Linux or macOS, run:

```bash
python3 --version
python3 -m pip --version
git --version
gh --version
gh student --help
gh auth status
```

On Windows PowerShell, run:

```powershell
py --version
py -m pip --version
git --version
gh --version
gh student --help
gh auth status
```

If you use Conda, activate your Conda environment first and use `python` in place of `py` for the first two commands.

Expected result:

- Python reports version 3.11 or newer.
- `pip`, `git`, and `gh` print version information.
- `gh student --help` prints the classroom50 student command help.
- `gh auth status` shows that you are logged in to GitHub.

If `python` works on your system but `python3` does not, that is fine. Use the command that points to Python 3.11 or newer.

## Optional: create a test environment

You do not need to create a course environment before arriving. But if you want to check that environment creation works, try this in a temporary folder.

Linux or macOS:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install ruff pytest mypy
python -m pip list
deactivate
```

Windows PowerShell:

```powershell
py -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install ruff pytest mypy
python -m pip list
deactivate
```

If PowerShell blocks activation scripts, either use a different terminal or run the environment's Python directly:

```powershell
.venv\Scripts\python -m pip install ruff pytest mypy
```

Conda users, including Linux and Windows users following the suggestions above, can use an equivalent Conda environment instead:

```bash
conda create -n pbp-course python=3.12
conda activate pbp-course
python -m pip install ruff pytest mypy
```

## Editor or IDE

An IDE is not required, but it makes the course smoother. Good options include VS Code, PyCharm, Spyder, or any editor where you are comfortable editing Python files and using a terminal.

For VS Code, install:

- the Python extension;
- a Ruff extension, or enable Ruff through your Python tooling.

The course will also show that linters, formatters, and type checkers can run in the terminal. IDE integration is a convenience layer on top of those same tools.
