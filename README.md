# create-rust-workspace.sh

## What is create-rust-workspace.sh?

A shell script that automates the creation of Rust workspaces. 
It streamlines the setup process by:

- Creating a new workspace directory
- Generating a properly configured `Cargo.toml` workspace file
- Optionally creating an initial cargo project (library or binary)
- Automatically adding the project to the workspace members

This eliminates the manual steps of setting up a Rust workspace and ensures consistent configuration across projects.

## How to use create-rust-workspace.sh?

### Prerequisites

- Rust and Cargo installed on your system
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

### Example

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
