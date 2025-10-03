.PHONY: help install clean test analyze format build run doctor

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

install: ## Install dependencies
	@echo "Installing dependencies..."
	flutter pub get

clean: ## Clean build files
	@echo "Cleaning build files..."
	flutter clean
	flutter pub get

test: ## Run all tests
	@echo "Running tests..."
	flutter test

test-coverage: ## Run tests with coverage
	@echo "Running tests with coverage..."
	flutter test --coverage
	@echo "Coverage report generated in coverage/lcov.info"

analyze: ## Run code analysis
	@echo "Running code analysis..."
	flutter analyze

format: ## Format code
	@echo "Formatting code..."
	dart format lib/ test/

format-check: ## Check code formatting
	@echo "Checking code formatting..."
	dart format --set-exit-if-changed lib/ test/

lint: analyze ## Run linter (alias for analyze)

build-android: ## Build Android APK
	@echo "Building Android APK..."
	flutter build apk --release

build-android-debug: ## Build Android APK (debug)
	@echo "Building Android APK (debug)..."
	flutter build apk --debug

build-ios: ## Build iOS app
	@echo "Building iOS app..."
	flutter build ios --release

build-web: ## Build web app
	@echo "Building web app..."
	flutter build web

run: ## Run the app
	@echo "Running app..."
	flutter run

run-release: ## Run the app in release mode
	@echo "Running app in release mode..."
	flutter run --release

doctor: ## Check Flutter installation
	@echo "Checking Flutter installation..."
	flutter doctor -v

upgrade: ## Upgrade dependencies
	@echo "Upgrading dependencies..."
	flutter pub upgrade

outdated: ## Check for outdated dependencies
	@echo "Checking for outdated dependencies..."
	flutter pub outdated

fix: ## Apply auto-fixes
	@echo "Applying auto-fixes..."
	dart fix --apply

generate: ## Generate code (if using code generation)
	@echo "Generating code..."
	flutter pub run build_runner build --delete-conflicting-outputs

watch: ## Watch and generate code
	@echo "Watching and generating code..."
	flutter pub run build_runner watch --delete-conflicting-outputs

firebase-configure: ## Configure Firebase (requires flutterfire CLI)
	@echo "Configuring Firebase..."
	flutterfire configure

setup: install ## Complete setup
	@echo "Setup complete! Run 'make firebase-configure' to set up Firebase."
	@echo "Then run 'make run' to start the app."

all: clean install analyze test ## Clean, install, analyze, and test
