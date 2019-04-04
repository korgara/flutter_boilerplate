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
5. Quick search for key `com.example.flutter_boilerplate`, and replace it **everywhere** (you will need to do it anyway, either you won't be able to release your app to play-store).
6. Go through all steps described here in [firebase_messaging docs](https://pub.dartlang.org/packages/firebase_messaging#getting-started).
7. Check all TODOs in project.

# Tests
  To run integrational tests use `flutter drive --target=./test_driver/main-flow.dart`

# How does FCM work?
  There is `PushNotifBloc`, which has currently only one stream for new messages.
  ```dart
    BehaviorSubject<Map<String, dynamic>> _newMsgsController = BehaviorSubject();
    Stream<Map<String, dynamic>> get outNewMessages => _newMsgsController.stream;
    Sink<Map<String, dynamic>> get _inNewMessages => _newMsgsController.sink;
  ```
  Really important to run `PushNotifBloc.init()` only one. For now we implement it in `main` method, before app launches.

  To handle tap on push notification alert go to *main.dart*

  ```dart
    _onReceivePushNotification(Map<String, dynamic> message) {
      // TODO: implement tap on Push notification
      print('---------- _onReceivePushNotification ---------- \n $message');
    }
  ```
