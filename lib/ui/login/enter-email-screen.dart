import 'package:flutter/material.dart';

import '../../models/account-model.dart';
import '../../utils/common.dart';
import '../common-widgets/main-button.dart';
import './enter-code-screen.dart';
import './auth-provider.dart';

class _EnterEmailScreenState extends State<EnterEmailScreen> with AuthScreenProvider {
  bool _isDataSending = false;
  final _formKey = GlobalKey<FormState>();
  FocusNode _emailFieldFocusNode = new FocusNode();
  TextEditingController _emailFieldController = TextEditingController();
  AuthScreenPresenter _presenter;

  _EnterEmailScreenState() {
    _presenter = AuthScreenPresenter(this);
  }

  @override
  void onLoginCodeRequested(String email) {
    setState(() {
      _isDataSending = false;
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EnterCodeScreen(email: email),
      ),
    );
    _emailFieldController.clear();
  }

  @override
  void onActionError(String errorTxt) {
    showAlert(context, errorTxt);
    setState(() {
      _isDataSending = false;
    });
  }

  @override
  void onActionSuccess(Account user) {
  }

  @override
  dispose() {
    _emailFieldController.clear();
    _emailFieldFocusNode.dispose();
    super.dispose();
  }

  Function _handleNext() {
    if (_isDataSending) return null;

    return () {
      if (_formKey.currentState.validate()) {
        setState(() {
          _isDataSending = true;
        });
        _presenter.requestCode(_emailFieldController.text.trim());
      }
    };
  }

  Widget _buildEmailInput() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: TextFormField(
          key: Key('email_input'),
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          validator: (String value) {
            Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value)) {
              return 'Enter Valid Email';
            }
            return null;
          },
          controller: _emailFieldController,
          focusNode: _emailFieldFocusNode,
          decoration: InputDecoration(
            hintText: 'Email Address',
            prefixIcon: Icon(
              Icons.mail_outline,
              size: 18.0,
              color: _emailFieldFocusNode.hasFocus ? Colors.blue : Colors.lightBlue,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF8B8B99)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF8B8B99)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
              child: Text(
                'Please enter your email address to get a login code',
                textAlign: TextAlign.center,
              ),
            ),
            _buildEmailInput(),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: MainButton(
                key: Key('request_code_btn'),
                text: 'REQUEST LOGIN CODE',
                isLoading: _isDataSending,
                onTap: _handleNext(),
              ),
            ),
          ]
        )
      ),
    );
  }
}

class EnterEmailScreen extends StatefulWidget {
  @override
  _EnterEmailScreenState createState() => _EnterEmailScreenState();
}
