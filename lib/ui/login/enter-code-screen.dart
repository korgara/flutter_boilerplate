import 'package:flutter/material.dart';

import '../../models/account-model.dart';
import '../../utils/common.dart';
import '../common-widgets/main-button.dart';
import './auth-state.dart';
import './auth-provider.dart';

class _EnterCodeScreenState extends State<EnterCodeScreen> with AuthScreenProvider {
  final _formKey = GlobalKey<FormState>();
  bool _isDataSending = false;
  FocusNode _codeFieldFocusNode = new FocusNode();
  TextEditingController _codeFieldController = TextEditingController();
  AuthScreenPresenter _presenter;

  _EnterCodeScreenState() {
    _presenter = AuthScreenPresenter(this);
  }

  @override
  void onActionError(String errorTxt) {
    showAlert(context, errorTxt);
    setState(() {
      _isDataSending = false;
    });
  }

  @override
  void onActionSuccess(Account acc) async {
    Account.current = acc;
    setState(() {
      _isDataSending = false;
    });
    AuthStateProvider().notify(AuthState.LOGGED_IN);
  }

  @override
  void onLoginCodeRequested(String email) {}

  void _onLoginTap() {
    if (_formKey.currentState.validate()) {
      if (!_isDataSending) {
        _presenter.doLogin(widget.email, _codeFieldController.text.trim());
        setState(() {
          _isDataSending = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _codeFieldController.clear();
    _codeFieldFocusNode.dispose();
    super.dispose();
  }

  void _onDidntGetCodeTap() {
    Navigator.of(context).pop();
  }

  Widget _buildCodeInput() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: TextFormField(
          key: Key('code_input'),
          autocorrect: false,
          focusNode: _codeFieldFocusNode,
          controller: _codeFieldController,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Please, enter the code got in email';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Code',
            prefixIcon: Icon(
              Icons.lock_outline,
              size: 18.0,
              color: _codeFieldFocusNode.hasFocus ? Colors.blue : Colors.lightBlue,
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
            _buildCodeInput(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Text('I didn’t get the code'),
                    onTap: _onDidntGetCodeTap,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: MainButton(
                key: Key('login_btn'),
                text: 'LOGIN',
                isLoading: _isDataSending,
                onTap: _onLoginTap,
              ),
            ),
          ]
        )
      ),
    );
  }
}

class EnterCodeScreen extends StatefulWidget {
  EnterCodeScreen({
    this.email,
  });
  final String email;

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}
