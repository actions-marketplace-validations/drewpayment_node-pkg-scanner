#!/bin/bash

# Cross-platform binary builder for node-pkg-scanner
# Run this script on each target platform for best compatibility

set -e

echo "🔧 Building node-pkg-scanner binary for $(uname -s)..."

# Clean up old binary
rm -f node-pkg-scanner-binary node-pkg-scanner-binary.exe

# Detect platform and build appropriate binary
case "$(uname -s)" in
    Darwin*)
        echo "🍎 Building macOS binary..."
        bun build src/cli.ts --compile --outfile node-pkg-scanner-macos
        echo "✅ Created: node-pkg-scanner-macos"
        ;;
    Linux*)
        echo "🐧 Building Linux binary..."
        bun build src/cli.ts --compile --outfile node-pkg-scanner-linux
        echo "✅ Created: node-pkg-scanner-linux"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        echo "🪟 Building Windows binary..."
        bun build src/cli.ts --compile --outfile node-pkg-scanner-windows.exe
        echo "✅ Created: node-pkg-scanner-windows.exe"
        ;;
    *)
        echo "❌ Unsupported platform: $(uname -s)"
        echo "Supported platforms: macOS (Darwin), Linux, Windows (MINGW/MSYS/Cygwin)"
        exit 1
        ;;
esac

echo ""
echo "🚀 Binary ready for distribution!"
echo "💡 Copy this binary to your team repositories and use in preinstall scripts."