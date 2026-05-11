# PowerShell Commands

Utility scripts for cloning, preparing, and managing KeshavSoft repositories.

---

# Features

- Clone multiple repositories
- Auto create workspace folders
- Prevent accidental overwrite
- Optional Git installation
- Auto open workspace
- Modular function-based architecture
- Single-file build output for customers

---

# Folder Structure

```txt
Build/
│
├── Functions/
│   ├── Ensure-GitInstalled.ps1
│   ├── Get-WorkspaceFolder.ps1
│   ├── Ensure-BaseFolder.ps1
│   ├── Ensure-WorkspaceFolder.ps1
│   ├── Clone-Repos.ps1
│   ├── Install-NpmPackages.ps1
│   └── Open-Workspace.ps1
│
├── dist/
│
├── build.ps1
└── main.ps1
```

---

# Development

Run modular scripts during development.

```powershell
.\build.ps1
```

This generates:

```txt
.\dist\cloneReposAskV1.ps1
```

---

# Customer Usage

Customer only needs:

```powershell
.\cloneReposAskV1.ps1
```

No need to manage multiple files.

---

# Workspace Behavior

Creates folders like:

```txt
D:\KeshavSoftRepos\2026-05-11
```

If already exists:

```txt
D:\KeshavSoftRepos\2026-05-11(1)
D:\KeshavSoftRepos\2026-05-11(2)
```

after user confirmation.

---

# Requirements

- PowerShell 7+
- Git
- Node.js (optional for npm install)

---

# Build Philosophy

Development should be modular.

Delivery should be simple.

This repo uses:

- Small maintainable function files
- Single-file export for distribution

---

# Future Improvements

- Parallel cloning
- Logging
- Retry support
- Repo configuration JSON
- Interactive menu system
- Packaging as EXE

---