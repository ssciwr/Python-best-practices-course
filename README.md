# Best Practices in Python Programming

Source repository for the Scientific Software Center course “Best Practices in Python Programming” at Heidelberg University.

Original material by Inga Ulusoy. The current course was developed by Thomas Isensee.

The participant-facing course page is published at <https://ssciwr.github.io/Python-best-practices-course/>.

## Sources of truth

| Material | Canonical source |
| --- | --- |
| Taught course content | [`slides/ssciwr-pbp-course.typ`](slides/ssciwr-pbp-course.typ) |
| Prerequisite presentation | [`slides/ssciwr-pbp-course-prerequisites.typ`](slides/ssciwr-pbp-course-prerequisites.typ) |
| Written participant setup | [`PREREQUISITES.md`](PREREQUISITES.md) |
| Exercises and solutions | [`ssciwr-pbp-assignments`](https://github.com/ssciwr-courses/ssciwr-pbp-assignments) |
| Participant-facing overview | [`index.md`](index.md) |

## Build the slides

Install [Typst](https://github.com/typst/typst), then run from the repository root:

```bash
typst compile --root . --font-path slides/fonts/Source_Sans_3 slides/ssciwr-pbp-course.typ

typst compile --root . --font-path slides/fonts/Source_Sans_3 slides/ssciwr-pbp-course-prerequisites.typ
```

The GitHub Actions workflow compiles both presentations and deploys the PDFs with the course page to GitHub Pages.

## Assignment workflow

Assignment sources and solutions are maintained in the separate assignment repository linked above. [Classroom50](https://github.com/foundation50/classroom50) creates an individual repository for each participant from the relevant template.

## License

The material is released under [CC0 1.0 Universal](LICENSE).
