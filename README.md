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
