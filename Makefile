# iOS automation test environment setup

# Check and install basic environment dependencies (LTS versions recommended)
env:
	@echo "Checking Homebrew..."
	@command -v brew >/dev/null 2>&1 || { echo "Installing Homebrew..."; /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }
	@echo "Checking Node.js..."
	@command -v node >/dev/null 2>&1 || brew install node

# Install iOS specific system tools via Homebrew
ios-tools:
	brew install carthage           # Dependency manager for iOS frameworks
	brew install ios-deploy         # Tool to install/debug iOS apps via terminal
	brew install ideviceinstaller   # Interface for iOS app installation service
	brew install libimobiledevice   # Protocol library to communicate with iOS devices
	sudo xcode-select --install || echo "Xcode CLI already installed"

# Setup Appium with locked version 3.1.2 and stable drivers
setup: env ios-tools
	npm install -g appium@3.1.2                 # Appium Server (Locked to v3.1.2)
	appium driver install xcuitest@10.1.3       # Stable driver for iOS automation
	appium driver install uiautomator2@5.0.7    # Stable driver for Android automation
	appium plugin install images@3.0.17         # Stable plugin for image recognition
	npm install -g appium-doctor@2.0.21         # Environment diagnostic tool

# Verify the iOS environment setup
check:
	appium-doctor --ios