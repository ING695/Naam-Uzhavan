# Naam Uzhavan

A Flutter application for farmers to manage their agricultural work, plans, and activities. Built with BLoC state management pattern and Firebase backend.

## Features

### V1.0 MVP Features

1. **Authentication**
   - User registration with email and password
   - User login
   - Secure authentication with Firebase Auth
   - User session management

2. **New Plan**
   - Create new agricultural plans
   - Specify crop name, land size, and location
   - Set start date and expected harvest date
   - Add optional notes
   - Save plans to Firebase Firestore

3. **My Work**
   - View all created plans
   - See plan details including crop, land size, location, and dates
   - Track days remaining until harvest
   - Delete plans
   - Refresh to sync with Firebase

4. **My Account**
   - View profile information
   - See user details (name, email, phone, user ID)
   - Manage app settings (notifications, language)
   - View app version and about information
   - Logout functionality

5. **Support**
   - Contact support via email, phone, or chat
   - View frequently asked questions (FAQ)
   - Submit feedback
   - Get help with common issues

## Architecture

This app follows Clean Architecture principles with BLoC state management:

```
lib/
├── core/
│   ├── theme/          # App theme and styling
│   ├── utils/          # Utility functions
│   └── widgets/        # Reusable widgets
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   └── repositories/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── new_plan/
│   ├── my_work/
│   ├── my_account/
│   └── support/
└── main.dart
```

## Tech Stack

- **Framework**: Flutter 3.0+
- **State Management**: flutter_bloc
- **Backend**: Firebase
  - Firebase Auth for authentication
  - Cloud Firestore for data storage
  - Firebase Storage for future file uploads
- **UI**: Material Design with Google Fonts
- **Additional Libraries**:
  - equatable (for value equality)
  - intl (for date formatting)
  - shared_preferences (for local storage)

## Setup Instructions

### Prerequisites

1. Install Flutter SDK (3.0.0 or higher)
2. Install Dart SDK
3. Set up Android Studio or VS Code with Flutter extensions
4. Create a Firebase project

### Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or use an existing one
3. Enable Firebase Authentication (Email/Password provider)
4. Create a Cloud Firestore database
5. Download configuration files:
   - For Android: Download `google-services.json` and place it in `android/app/`
   - For iOS: Download `GoogleService-Info.plist` and place it in `ios/Runner/`

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/ING695/Naam-Uzhavan.git
   cd Naam-Uzhavan
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Add your Firebase configuration files as mentioned above
   - Or run: `flutterfire configure` (if you have FlutterFire CLI installed)

4. Run the app:
   ```bash
   flutter run
   ```

## Development

### Running Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

### Build for Production

#### Android
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

## Project Structure

- `lib/features/` - Feature modules following Clean Architecture
- `lib/core/` - Shared code, themes, and utilities
- `assets/` - Images, icons, and other static assets
- `test/` - Unit and widget tests

## State Management

This app uses BLoC (Business Logic Component) pattern for state management:

- **Events**: User actions and external triggers
- **States**: UI states representing different screens and data states
- **BLoC**: Business logic layer that handles events and emits states

Example flow:
```
User Action → Event → BLoC → Repository → Firebase
                       ↓
                     State → UI Update
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.

## Support

For support, email support@naamuzhavan.com or open an issue in the GitHub repository.

## Roadmap

### Future Features (V2.0)
- Push notifications for harvest reminders
- Weather integration
- Market price information
- Expense tracking
- Multi-language support (Tamil, Hindi)
- Dark mode
- Offline support
- Photo upload for crops
- Analytics dashboard
- Export data to PDF/Excel

## Authors

- ING695 - Initial work

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All contributors and supporters