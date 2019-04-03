import 'package:flutter/material.dart';
import './ui/login/enter-email-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import './models/account-model.dart';
import './ui/login/auth-state.dart';
import './ui/theme.dart';
import './bloc/application-bloc.dart';
import './services/prefs-service.dart';
import './utils/common.dart';

void main() async {
  CommonUtils.appDocsPath = (await getApplicationDocumentsDirectory()).path;
  final prefsInstance = await SharedPreferences.getInstance();
  PrefsService.init(prefsInstance);
  Account.current = await PrefsService().restoreSession();
  runApp(MyApp());
}


class _MyAppState extends State<MyApp> implements AuthStateListener {
  _MyAppState() {
    AuthStateProvider()..subscribe(this);
  }

  @override
  void onAuthStateChanged(AuthState state) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Account.current != null
      ? BlocProvider<ApplicationBloc>(
        bloc: ApplicationBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppThemeProvider.mainTheme,
          home: Scaffold(
            body: Center(child: Text('Hello, LitsLink, you are logged in.')),
            appBar: AppBar(),
            drawer: Drawer(
              child: SafeArea(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('Logout'),
                      onTap: () {
                        AuthStateProvider().logout();
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ) : MaterialApp(
        title: 'Flutter Demo',
        theme: AppThemeProvider.mainTheme,
        home: Scaffold(
          body: EnterEmailScreen(),
        ),
      );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
