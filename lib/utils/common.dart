import 'package:flutter/material.dart';

class CommonUtils {
  static String appDocsPath;
  // TODO: implement special key if needed
  static String pushNotificationNewMsg = 'NEW_MESSAGE';
}

void showAlert(
  BuildContext context,
  String msg,
  { title = 'Alert', List<Widget> actions }
) {
  showDialog<Null>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(child: Text(msg)),
      actions: actions != null ? actions : <Widget>[
        FlatButton(
          child: const Text("CLOSE"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    )
  );
}
