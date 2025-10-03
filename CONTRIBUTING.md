# Contributing to Naam Uzhavan

Thank you for your interest in contributing to Naam Uzhavan! This document provides guidelines and instructions for contributing.

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers and encourage diverse perspectives
- Focus on what is best for the community
- Show empathy towards other community members

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in Issues
2. If not, create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots (if applicable)
   - Environment details (OS, Flutter version, etc.)

### Suggesting Enhancements

1. Check if the enhancement has been suggested
2. Create a new issue with:
   - Clear title and description
   - Use case and benefits
   - Possible implementation approach
   - Mockups or examples (if applicable)

### Pull Requests

1. Fork the repository
2. Create a new branch from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes following our coding standards
4. Write or update tests
5. Update documentation if needed
6. Commit your changes:
   ```bash
   git commit -m "Brief description of changes"
   ```
7. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
8. Create a Pull Request

## Development Setup

1. Install Flutter SDK (3.0.0+)
2. Clone the repository:
   ```bash
   git clone https://github.com/ING695/Naam-Uzhavan.git
   cd Naam-Uzhavan
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Set up Firebase (see SETUP.md)
5. Run the app:
   ```bash
   flutter run
   ```

## Coding Standards

### Dart Style Guide

- Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter analyze` to check for issues
- Format code with `dart format .`

### File Organization

```
lib/
├── core/           # Shared code
├── features/       # Feature modules
│   └── feature_name/
│       ├── data/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   └── repositories/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
```

### Naming Conventions

- **Files**: `lowercase_with_underscores.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `SCREAMING_SNAKE_CASE` or `camelCase`
- **Private members**: prefix with `_`

### Code Style

```dart
// Good
class UserRepository {
  final FirebaseFirestore _firestore;
  
  UserRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
      
  Future<User> getUser(String id) async {
    // Implementation
  }
}

// Bad
class user_repository {
  var firestore;
  
  user_repository(firestore) {
    this.firestore = firestore;
  }
}
```

### BLoC Pattern

- Use `flutter_bloc` for state management
- One BLoC per feature
- Events should be nouns (e.g., `UserLoginRequested`)
- States should describe the state (e.g., `UserLoading`, `UserLoaded`)

Example:
```dart
// Event
class LoadUserRequested extends UserEvent {
  final String userId;
  const LoadUserRequested({required this.userId});
}

// State
class UserLoaded extends UserState {
  final User user;
  const UserLoaded({required this.user});
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<LoadUserRequested>(_onLoadUserRequested);
  }
  
  Future<void> _onLoadUserRequested(
    LoadUserRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final user = await userRepository.getUser(event.userId);
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
```

## Testing

### Writing Tests

- Write unit tests for business logic
- Write widget tests for UI components
- Write integration tests for user flows

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/auth_bloc_test.dart

# Run with coverage
flutter test --coverage
```

### Test Structure

```dart
void main() {
  group('FeatureName', () {
    late FeatureBloc bloc;
    late MockRepository mockRepository;

    setUp(() {
      mockRepository = MockRepository();
      bloc = FeatureBloc(repository: mockRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('description', () {
      // Arrange
      // Act
      // Assert
    });
  });
}
```

## Documentation

- Add inline comments for complex logic
- Update README.md for new features
- Update SETUP.md for configuration changes
- Add examples in code comments

Example:
```dart
/// Fetches user data from Firestore.
///
/// Returns a [User] object if found, throws [UserNotFoundException] if not found.
/// Throws [NetworkException] if there's a connection issue.
///
/// Example:
/// ```dart
/// final user = await userRepository.getUser('user123');
/// print(user.name);
/// ```
Future<User> getUser(String userId) async {
  // Implementation
}
```

## Commit Messages

Use conventional commits format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat(auth): add password reset functionality

fix(plans): resolve date picker crash on iOS

docs(readme): update Firebase setup instructions

test(auth): add unit tests for login bloc
```

## Pull Request Process

1. Update documentation
2. Add tests for new features
3. Ensure all tests pass
4. Run `flutter analyze` and fix any issues
5. Update CHANGELOG.md (if applicable)
6. Request review from maintainers

### PR Title Format

```
[Type] Brief description
```

Examples:
- `[Feature] Add password reset functionality`
- `[Fix] Resolve date picker crash on iOS`
- `[Docs] Update Firebase setup guide`

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed

## Screenshots (if applicable)
Add screenshots here

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings generated
- [ ] Tests added and passing
```

## Review Process

- At least one maintainer approval required
- All tests must pass
- Code must meet quality standards
- Documentation must be updated

## Questions?

- Open an issue for questions
- Join our community discussions
- Email: support@naamuzhavan.com

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- Project documentation

Thank you for contributing to Naam Uzhavan! 🌾
