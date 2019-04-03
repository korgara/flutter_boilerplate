import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import './ui/theme.dart';
import './bloc/application-bloc.dart';
import './services/prefs-service.dart';
import './utils/common.dart';
import './services/env-service.dart';

void main() async {
  CommonUtils.appDocsPath = (await getApplicationDocumentsDirectory()).path;
  final prefsInstance = await SharedPreferences.getInstance();
  EnvService.runningByTestDriver = true;

  await PrefsService.init(prefsInstance).clearSharedPreferences();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: MaterialApp(
        title: 'Flutter Boilerplate',
        theme: AppThemeProvider.mainTheme,
        home: Scaffold(
          body: Center(child: Text('Hello, LitsLink')),
        ),
      ),
    );
  }
}
