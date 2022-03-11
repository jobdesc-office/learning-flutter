import 'package:boilerplate/models/masters/user_model.dart';

abstract class LoginViewContract {
  void onLoginSuccess(UserModel userModel);

  void onLoginFailed(String message);

  void onErrorResponse();
}
