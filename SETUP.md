# Firebase Setup Guide

This guide will help you set up Firebase for the Naam Uzhavan app.

## Prerequisites

1. A Google account
2. Flutter installed on your machine
3. Android Studio or Xcode (for iOS)

## Step-by-Step Setup

### 1. Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: "Naam Uzhavan" (or your preferred name)
4. Accept terms and click "Continue"
5. Disable Google Analytics (optional for MVP)
6. Click "Create project"
7. Wait for the project to be created

### 2. Enable Authentication

1. In Firebase Console, click "Authentication" in the left menu
2. Click "Get started"
3. Click on "Email/Password" in the Sign-in method tab
4. Enable "Email/Password"
5. Click "Save"

### 3. Create Cloud Firestore Database

1. In Firebase Console, click "Firestore Database" in the left menu
2. Click "Create database"
3. Select "Start in test mode" (for development)
4. Choose a Cloud Firestore location close to your users
5. Click "Enable"

### 4. Set Up Firestore Security Rules

After creating the database, update the security rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow users to read/write only their own data
    match /plans/{planId} {
      allow read, write: if request.auth != null && 
                          request.auth.uid == resource.data.userId;
      allow create: if request.auth != null;
    }
    
    // Allow users to read their own profile
    match /users/{userId} {
      allow read, write: if request.auth != null && 
                          request.auth.uid == userId;
    }
  }
}
```

### 5. Configure Firebase for Flutter

#### Option A: Using FlutterFire CLI (Recommended)

1. Install FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```

2. Run the configuration command:
   ```bash
   flutterfire configure
   ```

3. Follow the prompts:
   - Select your Firebase project
   - Select platforms (Android, iOS, Web)
   - The tool will generate `firebase_options.dart` automatically

#### Option B: Manual Configuration

##### For Android:

1. In Firebase Console, click the Android icon to add an Android app
2. Enter package name: `com.example.naam_uzhavan` (or your package name)
3. Download `google-services.json`
4. Place it in `android/app/` directory
5. Update `android/build.gradle`:
   ```gradle
   buildscript {
     dependencies {
       classpath 'com.google.gms:google-services:4.3.15'
     }
   }
   ```
6. Update `android/app/build.gradle`:
   ```gradle
   apply plugin: 'com.google.gms.google-services'
   
   android {
     defaultConfig {
       minSdkVersion 21  // or higher
     }
   }
   ```

##### For iOS:

1. In Firebase Console, click the iOS icon to add an iOS app
2. Enter bundle ID: `com.example.naamUzhavan` (or your bundle ID)
3. Download `GoogleService-Info.plist`
4. Open iOS project in Xcode: `open ios/Runner.xcworkspace`
5. Drag `GoogleService-Info.plist` into the Runner folder
6. Update `ios/Podfile`:
   ```ruby
   platform :ios, '12.0'
   ```

##### For Web:

1. In Firebase Console, click the Web icon to add a web app
2. Register the app with a nickname
3. Copy the Firebase configuration
4. Update `web/index.html` with Firebase SDK scripts

### 6. Create Firebase Options File

If you're not using FlutterFire CLI, create `lib/firebase_options.dart` manually:

```dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: 'YOUR_ANDROID_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_STORAGE_BUCKET',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_STORAGE_BUCKET',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'YOUR_IOS_BUNDLE_ID',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_WEB_API_KEY',
    appId: 'YOUR_WEB_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    authDomain: 'YOUR_AUTH_DOMAIN',
    storageBucket: 'YOUR_STORAGE_BUCKET',
  );
}
```

Replace the placeholders with your actual Firebase configuration values.

### 7. Update Main.dart

If using FlutterFire CLI, update `lib/main.dart` to import firebase_options:

```dart
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  
  runApp(NaamUzhavanApp(prefs: prefs));
}
```

### 8. Test Your Setup

1. Run the app:
   ```bash
   flutter run
   ```

2. Try to register a new user
3. Check Firebase Console > Authentication to see if the user was created
4. Create a plan and check Firestore to see if the data was saved

## Troubleshooting

### Common Issues

1. **"No Firebase App '[DEFAULT]' has been created"**
   - Make sure you call `Firebase.initializeApp()` before using any Firebase services
   - Check that firebase_options.dart is properly configured

2. **"google-services.json not found"**
   - Verify the file is in `android/app/` directory
   - Check that you've added the Google Services plugin in build.gradle

3. **"Unable to access Firestore"**
   - Check your Firestore security rules
   - Make sure authentication is working
   - Verify the user is logged in before accessing Firestore

4. **iOS build fails**
   - Run `cd ios && pod install` to install CocoaPods dependencies
   - Check that minimum iOS version is 12.0 or higher

5. **Multidex error on Android**
   - Add multidex support in `android/app/build.gradle`:
     ```gradle
     android {
       defaultConfig {
         multiDexEnabled true
       }
     }
     
     dependencies {
       implementation 'androidx.multidex:multidex:2.0.1'
     }
     ```

## Security Best Practices

1. **Never commit Firebase configuration files to public repositories**
   - Add `google-services.json` to .gitignore
   - Add `GoogleService-Info.plist` to .gitignore
   - Use environment variables for sensitive data in production

2. **Update Firestore Security Rules for production**
   - Change from test mode to production mode
   - Implement proper validation rules
   - Limit read/write access based on user authentication

3. **Enable App Check** (recommended for production)
   - Protects your Firebase resources from abuse
   - Available in Firebase Console > App Check

## Additional Resources

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Firestore Security Rules](https://firebase.google.com/docs/firestore/security/get-started)

## Support

If you encounter any issues, please:
1. Check the troubleshooting section above
2. Review Firebase and FlutterFire documentation
3. Open an issue in the GitHub repository
4. Contact support at support@naamuzhavan.com
