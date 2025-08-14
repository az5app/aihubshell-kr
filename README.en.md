# AIHub Shell

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-0.5-blue.svg)](https://github.com/az5app/aihubshell/releases)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)](https://github.com/az5app/aihubshell)

A command-line interface tool for accessing and downloading AI datasets from [AIHub Korea](https://aihub.or.kr).

## Features

- 🚀 Easy access to AIHub Korea datasets via command line
- 📥 Download datasets with automatic file merging
- 📋 List available datasets and file structures
- 🔐 Secure API key authentication
- 🛠 Simple and intuitive command structure

## Installation

### macOS via Homebrew (Recommended)

The easiest way to install AIHub Shell on macOS is through Homebrew:

```bash
# Add the tap
brew tap az5app/tap

# Install aihubshell
brew install aihubshell
```

### Manual Installation

1. Download the latest release:
```bash
curl -L https://github.com/az5app/aihubshell/releases/latest/download/aihubshell-v0.5.tar.gz -o aihubshell.tar.gz
```

2. Extract the archive:
```bash
tar -xzf aihubshell.tar.gz
```

3. Move to your PATH:
```bash
chmod +x aihubshell-v0.5/aihubshell
sudo mv aihubshell-v0.5/aihubshell /usr/local/bin/
```

## Configuration

### Setting up your API Key

Before using AIHub Shell, you need to obtain an API key from [AIHub Korea](https://aihub.or.kr).

You can provide your API key in two ways:

1. **Environment Variable (Recommended):**
```bash
export AIHUB_APIKEY="your-api-key-here"
```

Add this line to your shell configuration file (`~/.bashrc`, `~/.zshrc`, etc.) to make it permanent.

2. **Command Parameter:**
```bash
aihubshell -aihubapikey "your-api-key" -mode l
```

## Usage

### Basic Commands

#### Display Help
```bash
aihubshell -help
```

#### List All Datasets
```bash
aihubshell -mode l
```

#### View Dataset File Structure
```bash
aihubshell -mode l [dataset-key]
```

#### Download Dataset
```bash
aihubshell -mode d -datasetkey [dataset-key]
```

#### Download Specific Files
```bash
aihubshell -mode d -datasetkey [dataset-key] -filekey [file-keys]
```

### Examples

1. **List available datasets:**
```bash
aihubshell -mode l
```

2. **View file structure of dataset 71265:**
```bash
aihubshell -mode l 71265
```

3. **Download entire dataset:**
```bash
aihubshell -mode d -datasetkey 71265
```

4. **Download specific files from dataset:**
```bash
aihubshell -mode d -datasetkey 71265 -filekey "1,2,3"
```

### Parameters

| Parameter | Description | Required | Example |
|-----------|-------------|----------|---------|
| `-aihubapikey` | Your AIHub API key | No (if AIHUB_APIKEY env var is set) | `-aihubapikey "abc123"` |
| `-mode` | Operation mode (`l` for list, `d` for download) | Yes | `-mode l` |
| `-datasetkey` | Dataset identifier | Yes (for download mode) | `-datasetkey 71265` |
| `-filekey` | Specific file keys to download | No (default: all) | `-filekey "1,2,3"` |

## Features in Detail

### Automatic File Merging
When downloading large datasets that are split into parts, AIHub Shell automatically:
- Downloads all parts
- Merges them in the correct order
- Cleans up temporary files
- Provides progress feedback

### Interrupt Handling
- Downloads can be safely interrupted with `Ctrl+C`
- Automatic cleanup of partial downloads
- Resume capability for interrupted downloads

### Error Handling
- Clear error messages for common issues
- HTTP status code reporting
- Automatic retry with resume support

## Troubleshooting

### Common Issues

1. **"Error: datasetkey is required when mode is 'd'"**
   - Solution: Provide a dataset key when using download mode
   ```bash
   aihubshell -mode d -datasetkey [your-dataset-key]
   ```

2. **Authentication Failed**
   - Verify your API key is correct
   - Check if your API key has the necessary permissions
   - Ensure your API key hasn't expired

3. **Download Interrupted**
   - The tool automatically backs up existing downloads
   - Re-run the same command to resume

## Development

### Building from Source

```bash
# Clone the repository
git clone https://github.com/az5app/aihubshell.git
cd aihubshell

# The main script is ready to use
chmod +x aihubshell
./aihubshell -help
```

### Creating a Release

```bash
# Use the release preparation script
./prepare-release.sh
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 🐛 [Report Issues](https://github.com/az5app/aihubshell/issues)
- 📖 [Documentation](https://github.com/az5app/aihubshell/wiki)
- 💬 [Discussions](https://github.com/az5app/aihubshell/discussions)

## Acknowledgments

- [AIHub Korea](https://aihub.or.kr) for providing the dataset platform
- The open-source community for inspiration and support

---

Made with ❤️ for the AI research community