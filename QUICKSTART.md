# Quick Start Guide

Get up and running with Naam Uzhavan in 5 minutes!

## Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK
- A Firebase account
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio with Flutter plugins

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/ING695/Naam-Uzhavan.git
cd Naam-Uzhavan
```

### 2. Install Dependencies

```bash
flutter pub get
```

Or using Makefile:
```bash
make install
```

### 3. Set Up Firebase

#### Option A: Quick Setup (Using FlutterFire CLI)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

Follow the prompts to:
- Select/create a Firebase project
- Select platforms (Android, iOS, Web)
- FlutterFire will generate `firebase_options.dart` automatically

#### Option B: Manual Setup

See [SETUP.md](SETUP.md) for detailed Firebase configuration instructions.

### 4. Run the App

```bash
flutter run
```

Or using Makefile:
```bash
make run
```

## First Time Setup in Firebase Console

1. **Enable Authentication**
   - Go to Firebase Console → Authentication
   - Enable Email/Password sign-in method

2. **Create Firestore Database**
   - Go to Firestore Database
   - Create database in test mode
   - Choose a location close to your users

3. **Set Up Security Rules** (Important!)

In Firestore, update rules to:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /plans/{planId} {
      allow read, write: if request.auth != null && 
                          request.auth.uid == resource.data.userId;
      allow create: if request.auth != null;
    }
  }
}
```

## Using the App

### 1. Register a New Account

- Open the app
- Tap "Don't have an account? Register"
- Enter your name, email, and password
- Tap "Register"

### 2. Create Your First Plan

- After login, tap the "New Plan" tab
- Fill in the details:
  - Crop name (e.g., "Rice", "Wheat", "Tomatoes")
  - Land size in acres
  - Location
  - Start date
  - Expected harvest date (optional)
  - Notes (optional)
- Tap "Create Plan"

### 3. View Your Plans

- Go to "My Work" tab
- See all your plans
- Tap the refresh icon to sync with Firebase

### 4. Manage Your Account

- Go to "My Account" tab
- View your profile information
- Manage app settings
- Logout when done

### 5. Get Support

- Tap the help icon in the app bar
- Or go to Support tab
- View FAQs or submit feedback

## Common Commands

```bash
# Run the app
flutter run

# Run in release mode
flutter run --release

# Run tests
flutter test

# Run code analysis
flutter analyze

# Format code
dart format lib/ test/

# Build APK (Android)
flutter build apk --release

# Build for iOS
flutter build ios --release
```

## Using Makefile Commands

```bash
make help          # Show all available commands
make install       # Install dependencies
make test          # Run tests
make analyze       # Run code analysis
make format        # Format code
make build-android # Build Android APK
make run           # Run the app
make clean         # Clean build files
```

## Troubleshooting

### Issue: Firebase not initialized

**Solution:** Make sure you've run `flutterfire configure` or manually added Firebase configuration files.

### Issue: Build fails on Android

**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: CocoaPods error on iOS

**Solution:**
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter run
```

### Issue: "No user logged in" error

**Solution:** 
- Check Firebase Authentication is enabled
- Verify email/password provider is active
- Check network connection

## Next Steps

1. **Read the Documentation**
   - [README.md](README.md) - Project overview
   - [SETUP.md](SETUP.md) - Detailed setup guide
   - [ARCHITECTURE.md](ARCHITECTURE.md) - Technical architecture
   - [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute

2. **Explore the Code**
   - Check out `lib/features/` for feature implementations
   - Look at `lib/core/` for shared code
   - Review `test/` for test examples

3. **Customize**
   - Update app theme in `lib/core/theme/app_theme.dart`
   - Add new features in `lib/features/`
   - Modify Firebase rules for production

4. **Deploy**
   - Build for Android: `flutter build apk --release`
   - Build for iOS: `flutter build ios --release`
   - Deploy to Play Store / App Store

## Getting Help

- **Documentation**: Check [README.md](README.md) and [SETUP.md](SETUP.md)
- **Issues**: Open an issue on [GitHub](https://github.com/ING695/Naam-Uzhavan/issues)
- **Support**: Email support@naamuzhavan.com
- **Community**: Join our discussions

## Development Workflow

1. Create a new branch for your feature
   ```bash
   git checkout -b feature/my-feature
   ```

2. Make your changes

3. Run tests and analysis
   ```bash
   make test
   make analyze
   ```

4. Commit your changes
   ```bash
   git add .
   git commit -m "Add my feature"
   ```

5. Push and create a pull request
   ```bash
   git push origin feature/my-feature
   ```

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [BLoC Documentation](https://bloclibrary.dev/)
- [Dart Documentation](https://dart.dev/guides)

## Tips for Success

1. **Start Simple**: Begin by exploring the existing features
2. **Read the Code**: Understand the architecture before making changes
3. **Test Often**: Run tests frequently during development
4. **Ask for Help**: Don't hesitate to open an issue or ask questions
5. **Contribute Back**: Share your improvements with the community

Happy farming! 🌾
