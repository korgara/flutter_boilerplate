# Quick-start boilerplate
  Main boilerplate contains **bloc-provider and application bloc, environment service, shared-prefferences service, basic api service, flutter test-friver for integrational tests.**

# Get Started
 1. Clone the repo.
 2. Change repo's origin `git remote set-url origin your_repo_url`.
 3. Either run `flutter packages get` or go to `pubspec.yaml` and press appropriate button.
 4. Go to `lib/services/api/base-api.dart` and change values of host variables:
 ```dart
  const releaseHost = 'https://google.com';
  const stagingHost = 'https://google.com';
  ```

# Tests
  To run integrational tests use `flutter drive --target=./test_driver/main-flow.dart`

## How does auth work?
  There are 2 main screens with auth ui - `enter-code-screen` and `enter-email-screen`. Each of them implements `AuthProvider` and subscribes itself to `AuthScreenPresenter`.

  ```dart
  _EnterCodeScreenState() {
    _presenter = AuthScreenPresenter(this);
  }
  ```

  Meanwhile *main* screen listens to `AuthStateProvider`.

  ```dart
  class _MyAppState extends State<MyApp> implements AuthStateListener {
    _MyAppState() {
      AuthStateProvider()..subscribe(this);
    }

    @override
    void onAuthStateChanged(AuthState state) {
      setState(() {});
    }
  }
  ```

  If any of login calls succeed, `AuthStateProvider` mast be notified,

  ```dart
  @override
  void onActionSuccess(Account acc) async {
    Account.current = acc;
    setState(() {
      _isDataSending = false;
    });
    AuthStateProvider().notify(AuthState.LOGGED_IN);
  }
  ```
  so main screen can update its state and build appropriate screen.

  ```dart
  return Account.current != null
    ? BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppThemeProvider.mainTheme,
        home: Scaffold(),
      ),
    ) : MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemeProvider.mainTheme,
      home: Scaffold(
        body: EnterEmailScreen(),
      ),
    );
  ```
