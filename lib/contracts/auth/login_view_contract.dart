import 'package:boilerplate/models/auth_model.dart';

abstract class LoginViewContract {
  void onLoginSuccess(AuthModel userModel);

  void onLoginFailed(String message);

  void onErrorResponse();
}
