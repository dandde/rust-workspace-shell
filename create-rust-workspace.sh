#!/bin/zsh

# Prompt for workspace name
echo -n "Enter workspace name: "
read workspace_name

# Validate input
if [[ -z "$workspace_name" ]]; then
    echo "Error: Workspace name cannot be empty"
    exit 1
fi

# Create workspace directory
if [[ -d "$workspace_name" ]]; then
    echo "Error: Directory '$workspace_name' already exists"
    exit 1
fi

mkdir "$workspace_name"
cd "$workspace_name"

# Create workspace Cargo.toml
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

echo "✓ Created Rust workspace: $workspace_name"
echo "  - Directory: $workspace_name/"
echo "  - Cargo.toml configured"
echo ""

# Ask to create a cargo project
echo "Create a new cargo project?"
echo "[1] lib (default)"
echo "[2] bin"
echo -n "Choose [1/2] (press Enter for default): "
read project_type

# Set default to lib if empty
if [[ -z "$project_type" ]]; then
    project_type="1"
fi

# Ask for project name
echo -n "Enter project name: "
read project_name

if [[ -z "$project_name" ]]; then
    echo "Error: Project name cannot be empty"
    exit 1
fi

# Create the appropriate project type
if [[ "$project_type" == "1" ]]; then
    cargo new --lib "$project_name"
    echo "✓ Created library project: $project_name"
elif [[ "$project_type" == "2" ]]; then
    cargo new --bin "$project_name"
    echo "✓ Created binary project: $project_name"
else
    echo "Invalid choice. Skipping project creation."
    exit 0
fi

# Update workspace members
sed -i '' "s/members = \[\]/members = [\"$project_name\"]/" Cargo.toml
echo "✓ Added '$project_name' to workspace members"
echo ""
echo "Workspace is ready!"
echo "  cd $workspace_name"
echo "  cargo build"
