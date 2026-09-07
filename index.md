---
layout: default
title: Best Practices in Python Programming
description: A practical course from the Scientific Software Center at Heidelberg University
---

This four-hour course introduces practical habits and tools that make Python code easier to read, test, review, and share. It is aimed at participants who already know basic Python and want to make small scripts and research software more reliable and maintainable.

The course is not a complete introduction to Git, testing, packaging, or continuous integration, etc. Instead, it presents a useful baseline and points to more detailed courses and resources.

Original material by Inga Ulusoy. The current course was developed by Thomas Isensee at the Scientific Software Center, Heidelberg University.

## Course materials

- [Complete course slides (PDF)]({{ "/slides/ssciwr-pbp-course.pdf" | relative_url }})
- [Prerequisite slides (PDF)]({{ "/slides/ssciwr-pbp-course-prerequisites.pdf" | relative_url }})
- [Written setup instructions]({{ "/PREREQUISITES.html" | relative_url }})

## Before the course

Please complete the [setup instructions]({{ "/PREREQUISITES.html" | relative_url }}) before attending. You will need Python 3.11 or newer, Git, a GitHub account, the GitHub CLI, and the Classroom50 student extension.

The exercises use individual GitHub repositories created through classroom50. Confirm beforehand that `gh student --help` works and that `gh auth status` shows that you are logged in.

## Course outline and practice material

| Topic | What you will practise | Standalone template |
| --- | --- | --- |
| Project setup and Git | Isolated environments, project structure, and a basic Git workflow | — |
| Ruff and pre-commit | Formatting, linting, automated fixes, and local quality checks | [Ruff template](https://github.com/ssciwr-courses/python-ruff-template) |
| Python packaging | Turning a module into a minimal installable package | [Packaging template](https://github.com/ssciwr-courses/python-packaging-template) |
| Tests and type hints | Using pytest and mypy to reveal different kinds of problems | [Tests template](https://github.com/ssciwr-courses/python-tests-template) |
| Common Python pitfalls | Finding bugs caused by shared state, falsy values, and hidden failures | [Pitfalls template](https://github.com/ssciwr-courses/python-pitfalls-template) |
| Practical Python patterns | Refactoring with dataclasses, pathlib, context managers, and clearer interfaces | [Readable Python template](https://github.com/ssciwr-courses/readable-python-template) |

> During the live course, accept and submit assignments through Classroom50 using the commands provided by the instructor. The repositories linked above are the underlying starter templates. They can be inspected or used for independent practice, but cloning one directly does not create a Classroom50 submission repository. Automated checks provide feedback; the exercises are not formally graded.

## Learning objectives

After the course, you should be able to:

- use isolated environments to make Python work more reproducible;
- use Ruff to lint and format Python code;
- understand the role of `pyproject.toml` in a modern project;
- run tests with pytest and use simple type hints with a type checker;
- recognize when a script should become an installable package;
- avoid common beginner-relevant Python pitfalls;
- apply modern readability patterns such as `pathlib`, dataclasses, f-strings, and logging;
- use Git and pre-commit hooks as collaboration guardrails.

## Related SSC material

- [Python testing course](https://ssciwr.github.io/python-testing-intro/)
- [Python packaging course](https://ssciwr.github.io/python-packaging/)
- [SSC Python project template](https://github.com/ssciwr/python-project-template)
- [SSC Python package cookiecutter](https://github.com/ssciwr/cookiecutter-python-package)
- [All SSC courses](https://www.ssc.uni-heidelberg.de/en/learning/all-courses)

## Sources of truth

The presentation slides are the source of truth for the taught course content. Exercise instructions and starter code live in the assignment template repositories. This page provides stable navigation and a high-level overview. It is not intended to duplicate the slides.
