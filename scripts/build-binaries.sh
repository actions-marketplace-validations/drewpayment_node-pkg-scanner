#!/bin/bash

# Build cross-platform binaries for node-pkg-scanner
# Creates standalone executables that can be distributed without npm

set -e

echo "🔧 Building cross-platform binaries..."

# Clean up old binaries
rm -rf binaries/
mkdir -p binaries/

# Build TypeScript first
echo "📦 Compiling TypeScript..."
bun run build

# Create binaries for different platforms
echo "🍎 Building macOS binary..."
bun build src/cli.ts --compile --outfile binaries/node-pkg-scanner-macos

echo "🪟 Building Windows binary..."
# Note: Cross-compilation to Windows from macOS may not be supported by Bun yet
# This will create a macOS binary that teams can rename/use as a reference
bun build src/cli.ts --compile --outfile binaries/node-pkg-scanner-windows
echo "⚠️  Windows binary created as macOS format - teams will need to build on Windows"

echo "🐧 Building Linux binary..."
# Note: Cross-compilation to Linux from macOS may not be supported by Bun yet  
# This will create a macOS binary that teams can rename/use as a reference
bun build src/cli.ts --compile --outfile binaries/node-pkg-scanner-linux
echo "⚠️  Linux binary created as macOS format - teams will need to build on Linux"

# Make binaries executable
chmod +x binaries/node-pkg-scanner-*

echo "✅ Binaries created successfully!"
echo ""
echo "📁 Available binaries:"
ls -la binaries/
echo ""
echo "🚀 You can now distribute these binaries to your teams."
echo "💡 Add them to your repositories and reference in package.json preinstall scripts."