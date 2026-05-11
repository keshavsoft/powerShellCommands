# DEV.md

Developer notes for maintaining this repository.

---

# Architecture

The project follows:

```txt
Functions → main.ps1 → build.ps1 → dist output
```

---

# Why This Structure?

## During Development

Small files are easier to:

- debug
- test
- maintain
- reuse
- review

## During Delivery

Customers prefer:

- one file
- simple execution
- minimal setup

So we merge all scripts into one final distributable.

---

# Build System

`build.ps1` performs:

1. Reads all source files
2. Merges contents
3. Generates single output script

Output:

```txt
dist/cloneReposAskV1.ps1
```

---

# Important Rule

All runtime variables should exist in `main.ps1`.

Example:

```powershell
$repos = @(...)
$baseFolder = "D:\KeshavSoftRepos"
```

Because function files should remain reusable and isolated.

---

# Naming Convention

Functions:

```txt
Verb-Noun.ps1
```

Examples:

```txt
Clone-Repos.ps1
Open-Workspace.ps1
```

---

# Function Guidelines

Functions should:

- do one job only
- avoid global side effects
- avoid UI logic when possible
- return meaningful values

---

# Build Script Notes

Current build strategy:

```powershell
Get-Content source.ps1 | Add-Content output.ps1
```

Simple and reliable.

---

# Recommended Future Refactor

Possible next step:

```txt
Config/
    repos.json
```

Then scripts become reusable across projects.

---

# Possible Enhancements

## Parallel Clone

Use:

```powershell
Start-Job
```

or

```powershell
ForEach-Object -Parallel
```

---

## Logging

Future:

```txt
logs/
```

with timestamps.

---

## Packaging

Possible future:

- ps2exe
- winget package
- installer generation

---

# Philosophy

Keep development scalable.

Keep customer experience simple.

---