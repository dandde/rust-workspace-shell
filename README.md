# Rust Workspace Scripts

Two shell scripts for automating the creation of Rust workspaces:
- **create-rust-workspace.sh** - Local zsh script
- **rust-workspace-piped.sh** - POSIX-compliant script for piped execution

Both scripts streamline the setup process by:
- Creating a new workspace directory
- Generating a properly configured `Cargo.toml` workspace file
- Interactively creating an initial cargo project (library or binary)
- Automatically adding the project to workspace members

---

## rust-workspace-piped.sh

### What is it?

A POSIX-compliant shell script that can be downloaded and executed directly from the internet, similar to the Rust installer. Works on any Unix-like system (Linux, macOS, BSD, etc.).

### Prerequisites

- Rust and Cargo installed
- `curl` or `wget` for downloading
- Any POSIX-compliant shell (sh, bash, zsh, etc.)

### Usage

### Security Note

Only run scripts from trusted sources. Inspect before running:
```sh
curl -sSf https://example.com/rust-workspace-piped.sh | less
```

---

## create-rust-workspace.sh

### What is it?

A local zsh script optimized for macOS users.

### Prerequisites

- Rust and Cargo installed
- Zsh shell (default on macOS)

### Usage

1. Make the script executable (if not already):
   ```zsh
   chmod +x create-rust-workspace.sh
   ```

2. Run the script:
   ```zsh
   ./create-rust-workspace.sh
   ```

3. Follow the interactive prompts:
   - **Workspace name**: Enter a name for your workspace directory
   - **Project type**: Choose between:
     - `[1]` lib (default) - Creates a library project
     - `[2]` bin - Creates a binary/executable project
   - **Project name**: Enter a name for your initial cargo project

### Example Session

```zsh
$ ./create-rust-workspace.sh
Enter workspace name: my-workspace
✓ Created Rust workspace: my-workspace
  - Directory: my-workspace/
  - Cargo.toml configured

Create a new cargo project?
[1] lib (default)
[2] bin
Choose [1/2] (press Enter for default): 1
Enter project name: core
✓ Created library project: core
✓ Added 'core' to workspace members

Workspace is ready!
  cd my-workspace
  cargo build
```

---

## Interactive Prompts (Both Scripts)

When you run either script, you'll be prompted for:

1. **Workspace name** (if not provided as argument)
2. **Project type**:
   - `[1]` lib (default) - Creates a library project
   - `[2]` bin - Creates a binary/executable project
3. **Project name** - Name for your initial cargo project

### What gets created

The script creates the following structure:

```
my-workspace/
├── Cargo.toml          # Workspace configuration
└── core/               # Your cargo project
    ├── Cargo.toml
    └── src/
        └── lib.rs      # (for lib) or main.rs (for bin)
```

The workspace `Cargo.toml` includes:
- Resolver 2 configuration
- Empty workspace dependencies section (ready for shared dependencies)
- Common workspace package metadata
- Your project automatically added to the members array
