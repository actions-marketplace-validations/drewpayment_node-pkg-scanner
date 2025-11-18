# Cross-Platform Preinstall Script Examples

This directory contains example `package.json` configurations for different platforms showing how to use the node-pkg-scanner binary in npm preinstall hooks.

## Setup Instructions

1. **Download the appropriate binary** for your platform from your internal repository
2. **Place the binary** in a `security/` directory within your project root
3. **Make the binary executable** (Mac/Linux only):
   ```bash
   chmod +x security/node-pkg-scanner-macos
   # or
   chmod +x security/node-pkg-scanner-linux
   ```
4. **Update your package.json** with the appropriate preinstall script

## Platform-Specific Examples

### macOS (`package.json.macos`)
```json
{
  "scripts": {
    "preinstall": "./security/node-pkg-scanner-macos scan --quiet"
  }
}
```

### Windows (`package.json.windows`)
```json
{
  "scripts": {
    "preinstall": ".\\security\\node-pkg-scanner-windows.exe scan --quiet"
  }
}
```

### Linux (`package.json.linux`)
```json
{
  "scripts": {
    "preinstall": "./security/node-pkg-scanner-linux scan --quiet"
  }
}
```

## How It Works

1. **Before any packages are installed**, npm runs the `preinstall` script
2. **The scanner checks** your `package.json` and lock files for known compromised packages
3. **If compromised packages are found**, the script exits with code 1, preventing installation
4. **If the scan is clean**, installation proceeds normally

## Advanced Configuration

You can create a `.config.yml` file in your project root to customize the scanner behavior:

```yaml
# Security scan configuration
severityLevel: error
compromisedPackagesUrl: https://raw.githubusercontent.com/Cobenian/shai-hulud-detect/main/compromised-packages.txt
excludeDirectories:
  - node_modules
  - .git
  - dist
  - build
cacheTimeout: 60
```

## Cross-Platform Script

For teams using multiple platforms, you can create a more sophisticated preinstall script:

```json
{
  "scripts": {
    "preinstall": "node -e \"const os=require('os'); const platform=os.platform(); const scanner=platform==='win32'?'.\\\\security\\\\node-pkg-scanner-windows.exe':platform==='darwin'?'./security/node-pkg-scanner-macos':'./security/node-pkg-scanner-linux'; require('child_process').execSync(scanner+' scan --quiet', {stdio:'inherit'})\""
  }
}
```

This single script will automatically choose the correct binary based on the operating system.