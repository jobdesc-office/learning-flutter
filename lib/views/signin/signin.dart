import 'package:boilerplate/styles/color_palattes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/auth/login_view_contract.dart';
import '../../helpers/function.dart';
import '../../models/masters/user_model.dart';
import '../../models/session_model.dart';
import '../../presenters/auth_presenter.dart';
import '../../routes/route_list.dart';
import '../../utils/session_manager.dart';
import '../../widgets/login_button.dart';

import '_form_source.dart';

class SignInView extends StatelessWidget implements LoginViewContract {
  final authPresenter = AuthPresenter();

  SignInView() {
    authPresenter.loginViewContract = this;
  }

  final LoginForm _loginForm = LoginForm();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Container(
                      width: 400,
                      margin: EdgeInsets.only(top: Get.height * 0.20),
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                      decoration: BoxDecoration(
                        color: ColorPallates.quaternary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child:
                                Text('Login', style: TextStyle(fontSize: 30)),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text('Welcome back'),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Obx(
                              () => Column(
                                children: [
                                  _loginForm.username(
                                    controller: authPresenter
                                        .source.value.inputUsername,
                                  ),
                                  _loginForm.password(
                                    controller: authPresenter
                                        .source.value.inputPassword,
                                    onTapSuffixIcon: () =>
                                        authPresenter.togglePassword(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) => Container(
                              child: Obx(
                                () => LoginButton(
                                  disabled: authPresenter.isProcessing.value,
                                  width: constraints.maxWidth,
                                  label: authPresenter.isProcessing.value
                                      ? SizedBox(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 1,
                                          ),
                                          width: 20,
                                          height: 20,
                                        )
                                      : Text('Sign In'),
                                  onPressed: onClickLogin,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onClickLogin() {
    if (_formState.currentState!.validate()) {
      authPresenter.signIn();
      authPresenter.setProcessing(true);
    }
  }

  @override
  void onLoginFailed(String message) {
    authPresenter.setProcessing(false);
  }

  @override
  void onLoginSuccess(UserModel userModel) {
    SessionManager.setLogin(
      SessionModel(
        userid: userModel.userid,
        jwtToken: userModel.jwtToken,
      ),
    ).then((value) => toNameRoute(RouteList.home.index));
  }

  @override
  void onErrorResponse() {
    authPresenter.setProcessing(false);
  }
}
