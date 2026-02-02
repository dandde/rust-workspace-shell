#!/bin/sh
# Rust Workspace Installer
# Can be run with: curl -sSf <url> | sh

set -u

main() {
    need_cmd cargo
    need_cmd mkdir
    need_cmd cat
    need_cmd sed
    
    say "Rust Workspace Creator"
    say ""
    
    # Get workspace name from argument or prompt
    if [ $# -gt 0 ]; then
        WORKSPACE_NAME="$1"
    else
        printf "Enter workspace name: "
        read -r WORKSPACE_NAME
    fi
    
    if [ -z "$WORKSPACE_NAME" ]; then
        err "Workspace name cannot be empty"
        exit 1
    fi
    
    if [ -d "$WORKSPACE_NAME" ]; then
        err "Directory '$WORKSPACE_NAME' already exists"
        exit 1
    fi
    
    # Create workspace
    mkdir "$WORKSPACE_NAME"
    cd "$WORKSPACE_NAME" || exit 1
    
    # Create Cargo.toml
    cat > Cargo.toml << 'EOF'
[workspace]
resolver = "2"

members = []

[workspace.package]
version = "0.1.0"
edition = "2021"
authors = []
license = "MIT OR Apache-2.0"

[workspace.dependencies]
EOF
    
    say "✓ Created Rust workspace: $WORKSPACE_NAME"
    say "  - Directory: $WORKSPACE_NAME/"
    say "  - Cargo.toml configured"
    say ""
    
    # Ask for project creation
    say "Create a new cargo project?"
    say "[1] lib (default)"
    say "[2] bin"
    printf "Choose [1/2] (press Enter for default): "
    read -r PROJECT_TYPE
    
    # Default to lib
    if [ -z "$PROJECT_TYPE" ]; then
        PROJECT_TYPE="1"
    fi
    
    # Get project name
    printf "Enter project name: "
    read -r PROJECT_NAME
    
    if [ -z "$PROJECT_NAME" ]; then
        err "Project name cannot be empty"
        exit 1
    fi
    
    # Create project
    if [ "$PROJECT_TYPE" = "1" ]; then
        cargo new --lib "$PROJECT_NAME"
        say "✓ Created library project: $PROJECT_NAME"
    elif [ "$PROJECT_TYPE" = "2" ]; then
        cargo new --bin "$PROJECT_NAME"
        say "✓ Created binary project: $PROJECT_NAME"
    else
        warn "Invalid choice. Skipping project creation."
        exit 0
    fi
    
    # Update workspace members
    sed -i.bak "s/members = \[\]/members = [\"$PROJECT_NAME\"]/" Cargo.toml
    rm -f Cargo.toml.bak
    say "✓ Added '$PROJECT_NAME' to workspace members"
    say ""
    say "Workspace is ready!"
    say "  cd $WORKSPACE_NAME"
    say "  cargo build"
}

say() {
    printf '\033[1;32m%s\033[0m\n' "$1"
}

warn() {
    printf '\033[1;33mwarn:\033[0m %s\n' "$1" >&2
}

err() {
    printf '\033[1;31merror:\033[0m %s\n' "$1" >&2
}

need_cmd() {
    if ! check_cmd "$1"; then
        err "need '$1' (command not found)"
        exit 1
    fi
}

check_cmd() {
    command -v "$1" > /dev/null 2>&1
}

# Run main function
main "$@"
