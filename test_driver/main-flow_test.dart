import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';

void main() {
  group('Main flow test', () {
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Test', () async {

    });
  });
}

Future sleep(amount) async {
  await Future<Null>.delayed(Duration(milliseconds: amount));
}
