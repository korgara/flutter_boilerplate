import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import './ui/login/login-screen.dart';
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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Hello, LitsLink, you are logged in.'),
                  Account.current.picture != null
                    ? Container(
                        margin: EdgeInsets.only(top: 30.0),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(Account.current.picture.url)
                          )
                        )
                      )
                    : SizedBox(),
                ],
              )
            ),
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
          body: LoginScreen(),
        ),
      );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
