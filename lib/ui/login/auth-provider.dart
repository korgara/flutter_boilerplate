import '../../models/account-model.dart';
import '../../services/api/login-api.dart';
import '../../services/prefs-service.dart';

abstract class AuthScreenProvider {
  void onLoginCodeRequested(String email);
  void onActionSuccess(Account user);
  void onActionError(String errorTxt);
}

class AuthScreenPresenter {
  AuthScreenProvider _view;
  LoginApi _loginApi = LoginApi();
  AuthScreenPresenter(this._view);

  void requestCode(String email) async {
    try {
      await _loginApi.requestCode(email);
      _view.onLoginCodeRequested(email);
    } catch (e) {
      _view.onActionError(e.toString());
    }
  }

  void doLogin(String email, String code) async {
    try {
      final Map<String, dynamic> response = await _loginApi.requestToken(email, code);
      Account user = Account.fromApiResponse(response);

      PrefsService().storeSession(user);
      _view.onActionSuccess(user);
    } catch (e) {
      _view.onActionError(e.toString());
    }
  }
}
