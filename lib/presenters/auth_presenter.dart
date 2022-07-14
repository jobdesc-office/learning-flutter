import 'dart:async';

import 'package:get/get.dart';

import '../contracts/auth/guard_contract.dart';
import '../contracts/auth/login_view_contract.dart';
import '../contracts/auth/logout_view_contract.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';
import '../utils/custom_get_controller.dart';
import '../utils/session_manager.dart';
import '../views/signin/_source.dart';
import 'navigation_presenter.dart';

class AuthPresenter extends CustomGetXController {
  var bpActiveId = 0.obs;

  final _authService = Get.find<AuthService>();
  final _navService = Get.find<NavigationPresenter>();

  final source = LoginSource().obs;

  late LoginViewContract _loginViewContract;
  set loginViewContract(LoginViewContract loginViewContract) =>
      _loginViewContract = loginViewContract;

  late LogoutViewContract _logoutViewContract;
  set logoutViewContract(LogoutViewContract logoutViewContract) =>
      _logoutViewContract = logoutViewContract;

  late GuardContract _guardContract;
  set guardContract(GuardContract guardContract) =>
      _guardContract = guardContract;

  // void togglePassword() {
  //   source.update((val) {
  //     source.value.showPassword = !source.value.showPassword;
  //   });
  // }

  void reset() {
    source.value.inputUsername.text = '';
    source.value.inputPassword.text = '';
  }

  void signIn() {
    _authService
        .signIn(
          source.value.inputUsername.text,
          source.value.inputPassword.text,
        )
        .then((value) => value.statusCode != 400
            ? _loginViewContract.onLoginSuccess(AuthModel.fromJson(value.body))
            : _loginViewContract.onErrorResponse())
        .catchError(
          (message) => _loginViewContract.onLoginFailed(message),
        );
  }

  void signOut() {
    _authService.signOut().then((res) {
      reset();
      setProcessing(false);
      _logoutViewContract.onLogoutSuccess();
      isAuthenticated.value = false;
      _navService.darkTheme.value = false;
    });
  }

  final isAuthenticated = true.obs;
  final statusCode = 0.obs;

  void checkApiSession() async {
    try {
      if (await SessionManager.isLogged()) {
        _authService
            .verifyToken()
            .timeout(Duration(seconds: 1))
            .then((res) => _guardContract.onCheckSuccess(isOk: res.isOk));
      } else {
        _guardContract.onCheckSuccess(isOk: false);
      }
    } on TimeoutException catch (_) {
      _guardContract.onCheckTimeout();
    } catch (e) {
      _guardContract.onCheckInternalError();
    }
  }

  void checkLocalSession() async {
    try {
      SessionManager.isLogged()
          .then((value) => _guardContract.onCheckSuccess(isOk: value));
    } catch (e) {
      _guardContract.onCheckFailed();
    }
  }
}
