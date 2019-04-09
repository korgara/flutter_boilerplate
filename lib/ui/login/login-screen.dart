import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/ui/common-widgets/fb-button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FBButton(),
      ),
    );
  }
}
