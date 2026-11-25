---
name: git-conventions
description: Commit message and branch naming rules. Use when committing or creating a branch.
---

# Git conventions

Conventional Commits types, shared by commits and branches:

| Type       | For                                                                                              |
| ---------- | ------------------------------------------------------------------------------------------------ |
| `feat`     | new functionality: user-visible behaviour or a new code capability (service, repository, widget) |
| `fix`      | a bug fix                                                                                        |
| `refactor` | code change with no behaviour change                                                             |
| `perf`     | performance improvement                                                                          |
| `test`     | adding or fixing tests                                                                           |
| `docs`     | documentation for people: README, `docs/`, code comments                                         |
| `style`    | formatting/lint only, no logic change (not UI styling)                                           |
| `build`    | deps, pubspec, Gradle/Xcode, flavors, build scripts                                              |
| `ci`       | CI workflows and pipelines                                                                       |
| `revert`   | reverting a previous commit                                                                      |
| `chore`    | anything else: repo config, tooling, agent files (`CLAUDE.md`, `.claude/`), housekeeping         |

Pick the most specific type; `chore` is the fallback.

## Commits

`<type>: <summary>`, e.g. `feat: add QR scan screen`

- No scope: write `fix: ...`, never `fix(auth): ...`.
- One purpose per commit: split unrelated changes into separate commits. Use a single commit, under the main change's type, when the changes belong together (a feature with its tests and docs) or the user clearly asks for one.
- Summary: imperative, starts lowercase (keep the casing of identifiers and acronyms), no trailing period, ~50 chars max.
- Body only when the _why_ isn't obvious from the diff: 1–3 short lines.
- The message ends at the summary or body. Add no trailers: this overrides the default `Co-Authored-By` line.

## Branches

Create a branch only when the user asks; otherwise commit on the current branch.

`<type>/<kebab-case-summary>`, 2–4 words, e.g. `feat/qr-scanner`, `fix/camera-permission-crash`, `chore/project-setup`.
