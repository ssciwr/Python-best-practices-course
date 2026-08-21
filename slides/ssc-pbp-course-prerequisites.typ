#import "@preview/touying:0.7.4": *
#import "ssc-theme.typ": *

#show: institution-theme.with(
  title-logo: image("ssc_iwr_uni_logos_darkmode.svg"),
  slide-logo: image("ssc_logo_and_text.svg"),
  config-info(
    title: [Course Prerequisites],
    author: [Best Practices in Python Programming],
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
    baseline: 25%,
    image(icon, height: 0.9em),
  )
]

#let python-url = "https://www.python.org/downloads/"
#let git-url = "https://git-scm.com/downloads/"
#let gh-url = "https://github.com/cli/cli#installation"
#let miniconda-url = "https://docs.anaconda.com/miniconda/"
#let vscode-python-url = "https://code.visualstudio.com/docs/python/python-tutorial"
#let vscode-lint-url = "https://code.visualstudio.com/docs/python/linting"

#title-slide()

== Outline <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

= Overview

#slide(title: "What to set up before the course")[
  Required:

  - GitHub account
  - Python 3.11 or newer
  - Git
  - GitHub CLI (`gh`)
  - classroom50 student extension
  - terminal or shell access

  Recommended: a Python-aware editor or IDE.
]

#slide(title: "Why this matters")[
  The exercises use GitHub and classroom50.

  A working command-line setup lets you:

  - accept assignment repositories
  - clone starter code
  - run tools locally
  - commit and push changes
  - receive classroom feedback
]

= Install The Tools

#slide(title: logo("Python 3.11+", "figures/python-logo.svg"))[
  Install Python 3.11 or newer.

  Official downloads:

  #link(python-url)[python.org/downloads]

  Verification:

  ```bash
  python3 --version
  python3 -m pip --version
  ```

  On Windows, use `py` if `python3` is not available.
]

#slide(title: "Git")[
  Install Git.

  Official downloads:

  #link(git-url)[git-scm.com/downloads]

  Verification:

  ```bash
  git --version
  ```
]

#slide(title: "GitHub CLI")[
  Install GitHub CLI (`gh`).

  Official installation instructions:

  #link(gh-url)[GitHub CLI installation]

  Verification:

  ```bash
  gh --version
  ```
]

#slide(title: "Linux examples")[
  Suggested, not required: Conda can be convenient for managing Python and environments. A compact installer is #link(miniconda-url)[Miniconda].

  Alternatively, use your distribution's package manager.

  Debian or Ubuntu:

  ```bash
  sudo apt update
  sudo apt install python3 python3-venv python3-pip git
  ```

  Install `gh` from the official GitHub CLI instructions.
]

#slide(title: "macOS examples")[
  Official installers:

  - Python from python.org
  - Git from git-scm.com
  - GitHub CLI from the official `gh` instructions

  Or with Homebrew:

  ```bash
  brew install python git gh
  ```
]

#slide(title: "Windows examples")[
  Suggested, not required: Conda can be convenient for managing Python and environments on Windows. A compact installer is #link(miniconda-url)[Miniconda].

  Conda does not replace Git or GitHub CLI.

  Official installers:

  - Python from python.org; enable "add Python to PATH"
  - Git for Windows
  - GitHub CLI installer

  Or with PowerShell and `winget`:

  ```powershell
  winget install --id Python.Python.3.14.6 -e
  winget install --id Git.Git -e
  winget install --id GitHub.cli -e
  ```
]

= First-Time GitHub Setup

#slide(title: "Create and verify your account")[
  If you do not already use GitHub:

  1. Create an account at #link("https://github.com/")[github.com].
  2. Verify the email address for the account.
  3. Record your exact GitHub username.
  4. Send your username or profile URL to the course instructor.

  Your display name and GitHub username are not necessarily the same.

  Already have a working GitHub account? Keep using it and skip this slide.
]

#slide(title: "Configure your Git identity")[
  Git records an author name and email address in every commit.

  Check your global configuration:

  ```bash
  git config --global --get user.name
  git config --global --get user.email
  ```

  If either command prints nothing, configure it:

  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your-email@example.org"
  ```

  Use an email associated with your GitHub account, or your GitHub-provided `noreply` address. These settings identify commits; they are not login credentials.
]

#slide(title: "Choose HTTPS or SSH")[
  Git can connect to GitHub using either HTTPS or SSH.

  - *First-time users:* HTTPS is usually the easiest option. After running `gh student login`, configure Git to use the stored GitHub CLI credential:

    ```bash
    gh auth setup-git
    ```

  - *Existing GitHub users:* keep your working HTTPS or SSH setup. There is no need to change protocols or replace working SSH keys.

  You do not need to create a personal access token for this course.
]

= classroom50

#slide(title: "Install classroom50 student CLI")[
  The course assignments use classroom50 through a GitHub CLI extension.

  Install:

  ```bash
  gh extension install foundation50/gh-student
  ```

  Verify:

  ```bash
  gh student --help
  ```
]

#slide(title: "Log in for assignments")[
  ```bash
  gh student login
  ```

  This starts the GitHub login flow with the permissions needed to accept and submit classroom50 assignments.

  Browser-based login is usually easiest. Your Git transport can remain either  HTTPS or SSH.
]

#slide(title: "Update classroom50 student CLI")[
  If the extension is already installed, update it with:

  ```bash
  gh extension upgrade gh-student
  ```
]

= Check Your Setup

#slide(title: "Verify on Linux or macOS")[
  ```bash
  python3 --version
  python3 -m pip --version
  git --version
  gh --version
  gh student --help
  gh auth status
  gh api user --jq .login
  ```

  If `python` works but `python3` does not, use the command that points to Python 3.11 or newer.
]

#slide(title: "Verify on Windows PowerShell")[
  ```powershell
  py --version
  py -m pip --version
  git --version
  gh --version
  gh student --help
  gh auth status
  gh api user --jq .login
  ```

  With Conda, activate the environment first and use `python` instead of `py`.
]

#slide(title: "Expected result")[
  - Python reports version 3.11 or newer.
  - `pip`, `git`, and `gh` print version information.
  - `gh student --help` prints classroom50 command help.
  - `gh auth status` shows that you are logged in to GitHub.
  - `gh api user --jq .login` prints the GitHub username sent to the instructor.
]

= Optional Environment Check

#slide(title: "venv check: Linux or macOS")[
  ```bash
  python3 -m venv .venv
  source .venv/bin/activate
  python -m pip install --upgrade pip
  python -m pip install ruff pytest mypy
  python -m pip list
  deactivate
  ```

  This is optional; no shared course environment is required before arrival.
]

#slide(title: "venv check: Windows")[
  ```powershell
  py -m venv .venv
  .venv\Scripts\Activate.ps1
  python -m pip install --upgrade pip
  python -m pip install ruff pytest mypy
  python -m pip list
  deactivate
  ```

  If activation is blocked, run `.venv\Scripts\python` directly.
]

#slide(title: "Optional Conda environment")[
  Conda can be especially convenient on Linux and Windows, but it is not required.
  To check an equivalent environment:

  ```bash
  conda create -n pbp-course python=3.14.6
  conda activate pbp-course
  python -m pip install ruff pytest mypy
  ```
]

= Editor Or IDE

#slide(title: "Editor recommendation")[
  An IDE is not required, but it makes the course smoother.

  Good options include:

  - #logo(link("https://code.visualstudio.com/")[VS Code], "figures/vscode-logo.png")
  - #logo(link("https://www.jetbrains.com/pycharm/")[PyCharm], "figures/PyCharm_icon.svg")
  - #logo(link("https://www.spyder-ide.org/")[Spyder], "figures/spyder_logo.svg")
  - any editor where you can edit Python + a terminal
]
