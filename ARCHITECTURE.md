# Architecture Documentation

## Overview

Naam Uzhavan follows Clean Architecture principles combined with the BLoC (Business Logic Component) pattern for state management. This architecture ensures separation of concerns, testability, and maintainability.

## Architecture Layers

### 1. Presentation Layer

The presentation layer contains UI components and state management:

```
features/{feature_name}/presentation/
├── bloc/           # State management
│   ├── {feature}_bloc.dart
│   ├── {feature}_event.dart
│   └── {feature}_state.dart
├── pages/          # Screen/page widgets
│   └── {feature}_page.dart
└── widgets/        # Reusable UI components
    └── {feature}_widget.dart
```

**Responsibilities:**
- Display data to users
- Handle user interactions
- Emit events to BLoC
- React to state changes

**Example:**
```dart
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    if (state is AuthAuthenticated) {
      return HomePage();
    }
    return LoginPage();
  },
)
```

### 2. Domain Layer

The domain layer contains business logic and entities:

```
features/{feature_name}/domain/
├── entities/       # Business objects
│   └── {entity}.dart
└── repositories/   # Repository interfaces
    └── {repository}.dart
```

**Responsibilities:**
- Define business entities
- Define repository interfaces
- Define use cases (if complex business logic)
- Independent of external dependencies

**Example:**
```dart
abstract class AuthRepository {
  Future<User> signIn(String email, String password);
  Future<void> signOut();
}
```

### 3. Data Layer

The data layer handles data operations:

```
features/{feature_name}/data/
├── models/         # Data models (extends entities)
│   └── {model}.dart
└── repositories/   # Repository implementations
    └── {repository}_impl.dart
```

**Responsibilities:**
- Implement repository interfaces
- Convert between models and entities
- Handle data sources (Firebase, API, local storage)
- Error handling

**Example:**
```dart
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  
  @override
  Future<User> signIn(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseUser(credential.user!);
  }
}
```

## State Management (BLoC)

### BLoC Pattern Flow

```
User Action → Event → BLoC → Repository → Data Source
                       ↓
                     State → UI Update
```

### Event

Events represent user actions or system events:

```dart
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  
  const AuthLoginRequested({
    required this.email,
    required this.password,
  });
}
```

### State

States represent the UI state:

```dart
abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final User user;
  const AuthAuthenticated({required this.user});
}
class AuthUnauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
}
```

### BLoC

BLoC handles events and emits states:

```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
  }
  
  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signIn(
        event.email,
        event.password,
      );
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
```

## Data Flow

### Read Operation

1. User interacts with UI (e.g., taps "Load Plans" button)
2. UI dispatches event: `context.read<PlanBloc>().add(LoadPlansRequested())`
3. BLoC receives event and emits loading state
4. BLoC calls repository method
5. Repository fetches data from Firebase
6. Repository converts Firebase data to domain entities
7. BLoC receives entities and emits loaded state
8. UI receives state and updates display

### Write Operation

1. User fills form and taps "Save"
2. UI dispatches event with data
3. BLoC receives event and emits loading state
4. BLoC calls repository method with data
5. Repository converts entity to model
6. Repository saves to Firebase
7. BLoC emits success state
8. UI shows success message

## Dependency Flow

```
Presentation Layer (depends on)
    ↓
Domain Layer (depends on)
    ↓
Data Layer
```

- Presentation depends on Domain
- Data depends on Domain
- Domain is independent

## Firebase Integration

### Authentication

```dart
FirebaseAuth.instance
  → UserCredential
  → User (Firebase)
  → UserModel (Data)
  → User (Domain)
  → AuthState
  → UI
```

### Firestore

```dart
UI → BLoC → Repository → FirebaseFirestore
  .collection('plans')
  .where('userId', isEqualTo: userId)
  .get()
    → QuerySnapshot
    → List<DocumentSnapshot>
    → List<PlanModel>
    → List<Plan>
    → PlanState
    → UI
```

## Error Handling

### Layered Error Handling

1. **Repository Layer**: Catch Firebase exceptions, convert to custom exceptions
2. **BLoC Layer**: Catch all exceptions, emit error state
3. **UI Layer**: Display error messages to user

```dart
// Repository
try {
  final doc = await _firestore.collection('plans').doc(id).get();
  return PlanModel.fromFirestore(doc);
} catch (e) {
  throw PlanRepositoryException('Failed to fetch plan: $e');
}

// BLoC
try {
  final plan = await repository.getPlan(id);
  emit(PlanLoaded(plan: plan));
} catch (e) {
  emit(PlanError(message: e.toString()));
}

// UI
BlocListener<PlanBloc, PlanState>(
  listener: (context, state) {
    if (state is PlanError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: // ... UI
)
```

## Testing Strategy

### Unit Tests

- Test BLoC logic
- Test repository implementations
- Mock dependencies

```dart
blocTest<AuthBloc, AuthState>(
  'emits [AuthLoading, AuthAuthenticated] when login succeeds',
  build: () {
    when(() => mockRepository.signIn(any(), any()))
        .thenAnswer((_) async => testUser);
    return AuthBloc(authRepository: mockRepository);
  },
  act: (bloc) => bloc.add(AuthLoginRequested(...)),
  expect: () => [AuthLoading(), AuthAuthenticated(user: testUser)],
);
```

### Widget Tests

- Test UI components
- Test user interactions
- Mock BLoC

```dart
testWidgets('displays login form', (tester) async {
  await tester.pumpWidget(MaterialApp(home: LoginPage()));
  
  expect(find.byType(TextField), findsNWidgets(2));
  expect(find.byType(ElevatedButton), findsOneWidget);
});
```

### Integration Tests

- Test complete user flows
- Test Firebase integration
- Use test environment

## Best Practices

1. **Single Responsibility**: Each class has one reason to change
2. **Dependency Inversion**: Depend on abstractions, not concretions
3. **Immutability**: Use `const` constructors, final fields
4. **Null Safety**: Leverage Dart's null safety features
5. **Error Handling**: Always handle errors gracefully
6. **Testing**: Write tests for business logic
7. **Documentation**: Document complex logic
8. **Code Review**: Review all changes

## Performance Considerations

1. **Avoid Rebuilds**: Use `const` constructors
2. **BLoC Efficiency**: Use `buildWhen` and `listenWhen`
3. **Pagination**: Load data in chunks
4. **Caching**: Cache frequently accessed data
5. **Lazy Loading**: Load data on demand

```dart
BlocBuilder<PlanBloc, PlanState>(
  buildWhen: (previous, current) {
    // Only rebuild when plans change
    return previous != current && current is PlansLoaded;
  },
  builder: (context, state) {
    // ...
  },
)
```

## Future Improvements

1. **Use Cases**: Extract complex business logic to use case classes
2. **Dependency Injection**: Use get_it or injectable for DI
3. **Code Generation**: Use freezed for data classes
4. **Error Types**: Create specific error types
5. **Logging**: Add structured logging
6. **Analytics**: Integrate analytics
7. **Feature Flags**: Add feature toggle support

## Resources

- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Architecture Samples](https://github.com/brianegan/flutter_architecture_samples)
- [Firebase Documentation](https://firebase.google.com/docs)
