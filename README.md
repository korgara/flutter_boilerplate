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

# Available boilerplates
  [**Email auth**](https://github.com/korgara/flutter_boilerplate/tree/phone_auth) - configured boilerplate with authentication via email and code. Contains everything that contains main boilerplate but more. There are 2 screens, with form, form validation, configured api login requests etc. To use it, just switch to branch `phone_auth`.

  `git fetch origin phone_auth` `git checkout phone_auth`

  [**Firebase Cloud Messaging**](https://github.com/korgara/flutter_boilerplate/tree/fcm) - configured boilerplate with no auth, but initialised FCM. See docs [here](https://github.com/korgara/flutter_boilerplate/tree/fcm).

  [**Facebook Login**](https://github.com/korgara/flutter_boilerplate/tree/fb-login) - configured boilerplate with fb auth. See docs [here](https://github.com/korgara/flutter_boilerplate/tree/fb-login).
