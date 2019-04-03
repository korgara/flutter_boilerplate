import './base-api.dart';

class LoginApi extends API {
  Future<Null> requestCode(String email) async {
    // TODO: implment requestCode
    final url = '/api/request-code';
    await API.post(
      url: url,
      body: { 'email': email },
      debugLogBody: true,
    );
    return null;
  }

  Future<Map<String, dynamic>> requestToken(String email, String code) async {
    // TODO: implement requestToken
    return await API.post(
      url: '/api/request-token',
      body: { 'email': email, 'code': code },
      debugLogBody: true,
    );
  }
}
