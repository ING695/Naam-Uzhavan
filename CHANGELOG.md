# Changelog

All notable changes to the Naam Uzhavan project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-01

### Added

#### Authentication
- User registration with email and password
- User login functionality
- Secure authentication with Firebase Auth
- User session management
- Logout functionality
- Splash screen with app branding

#### New Plan Feature
- Create new agricultural plans
- Input fields for:
  - Crop name
  - Land size (in acres)
  - Location
  - Start date
  - Expected harvest date (optional)
  - Notes (optional)
- Date picker for selecting dates
- Save plans to Firebase Firestore
- Form validation

#### My Work Feature
- View all user plans
- Display plan details:
  - Crop name
  - Land size
  - Location
  - Start and harvest dates
  - Days remaining until harvest
  - Notes
- Delete plans functionality
- Refresh to sync with Firebase
- Empty state when no plans exist
- Error handling with retry option

#### My Account Feature
- View user profile information:
  - Name
  - Email
  - Phone number
  - User ID
- App settings:
  - Notification preferences
  - Language selection
  - About section with app version
- Change password option (coming soon)
- Logout functionality

#### Support Feature
- Contact information:
  - Email support
  - Phone support
  - Live chat (coming soon)
- Frequently Asked Questions (FAQ):
  - How to create plans
  - How to edit plans
  - How to track work progress
  - Data security information
  - Password reset information
- Feedback form
- Expandable FAQ cards

#### Navigation & UI
- Bottom navigation bar with 4 tabs:
  - Home
  - New Plan
  - My Work
  - My Account
- Home page with:
  - User welcome card
  - Quick action cards
  - Recent activity section
- Material Design UI with custom theme
- Green color scheme for agricultural theme
- Google Fonts (Roboto) for typography
- Responsive layouts
- Loading indicators
- Error messages and success notifications

#### Architecture & Code Quality
- Clean Architecture implementation
- BLoC state management pattern
- Repository pattern for data access
- Domain entities and use cases
- Firebase integration:
  - Firebase Auth for authentication
  - Cloud Firestore for data storage
- Dependency injection ready
- Test examples:
  - Unit tests for BLoC
  - Widget tests for UI components
- Code analysis with flutter_lints

#### Documentation
- Comprehensive README.md
- Firebase setup guide (SETUP.md)
- Contributing guidelines (CONTRIBUTING.md)
- MIT License
- Code examples and documentation
- Architecture overview
- Setup instructions

### Technical Details

#### Dependencies
- flutter_bloc: ^8.1.3
- equatable: ^2.0.5
- firebase_core: ^2.24.2
- firebase_auth: ^4.15.3
- cloud_firestore: ^4.13.6
- firebase_storage: ^11.5.6
- google_fonts: ^6.1.0
- intl: ^0.18.1
- shared_preferences: ^2.2.2

#### Dev Dependencies
- flutter_test (SDK)
- flutter_lints: ^3.0.1
- bloc_test: ^9.1.5
- mocktail: ^1.0.1

#### Supported Platforms
- Android (minimum SDK 21)
- iOS (minimum version 12.0)
- Web

### Project Structure

```
lib/
├── core/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── auth/
│   ├── home/
│   ├── new_plan/
│   ├── my_work/
│   ├── my_account/
│   └── support/
└── main.dart
```

## [Unreleased]

### Planned Features for v2.0
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
- Edit plan functionality
- Search and filter plans
- Calendar view
- Crop rotation suggestions
- Pest and disease management tips

### Known Issues
- Password reset functionality not yet implemented
- Edit plan feature not available
- Live chat support coming soon
- Language selection not functional yet
- Profile picture upload not available

## Notes

This is the initial release (v1.0.0) of Naam Uzhavan, providing core functionality for farmers to manage their agricultural plans and work. Future releases will add more advanced features based on user feedback and requirements.

For bug reports and feature requests, please visit: https://github.com/ING695/Naam-Uzhavan/issues
