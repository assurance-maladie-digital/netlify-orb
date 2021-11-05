# Contribution Guide

First off, thanks for taking the time to contribute! This is really important to help us improve our Design System.

Make sure to read the [Code of Conduct](CODE_OF_CONDUCT.md) before starting.

## Report bugs

Bugs are reported using [GitHub issues](https://guides.github.com/features/issues/).

Before creating a new issue, [check if your bug hasn't already been reported](https://github.com/assurance-maladie-digital/netlify-orb/issues?q=is%3Aissue+is%3Aopen). If that's the case and you don't find a solution in the comments, contribute to the issue instead of creating a new one.

Also, see if the error is reproducible with the latest version.

### Submit a (good) bug report

Explain the problem and include additional details to help maintainers reproduce the problem:
- **Use a clear and descriptive title**
- **Describe the exact steps which reproduce the problem**
- **Provide specific examples to demonstrate the steps.** Include links to files or projects, or copy/pasteable snippets, which you use in those examples. If you're providing snippets in the issue, use [Markdown code blocks](https://help.github.com/articles/markdown-basics/#multiple-lines).

[Go to issues](https://github.com/assurance-maladie-digital/netlify-orb/issues)

## Suggest changes

Enhancement suggestions are tracked as GitHub issues, [create a new issue](#submitting-a-good-bug-report).

## Code contribution

You can look for issues labelled with `help-wanted` if you're not sure where to start!

### Local development

This Orb is based on the [Orb Development Kit](https://circleci.com/docs/2.0/orb-author/#orb-development-kit) from CircleCI.

You can check the Orb [Development Kit](https://circleci.com/docs/2.0/orb-author/).

#### Lint YAML

You can lint YAML files using [`yamllint`](https://github.com/adrienverge/yamllint):

```bash
yamllint .
```

#### Lint Shell scripts

You can lint Shell scripts using [ShellCheck](https://github.com/koalaman/shellcheck):

```bash
shellcheck src/scripts/*.sh
```

#### Tests

You can run the unit tests using [Bats-Core](https://github.com/bats-core/bats-core):

```bash
bats src/tests
```

#### Commit guidelines

Be explicit, and follow these guidelines:

- Write it in English
- Tell what package is affected by your changes
- Capitalize the subject line
- Do not end the subject line with a period
- Use the imperative mood
- Start with a verb (eg. *Add*, *Fix*, *Update*, *Refactor*)

#### Pull Requests

When creating a pull request, follow and complete the provided template.
