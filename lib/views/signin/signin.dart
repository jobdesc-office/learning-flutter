import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../contracts/auth/login_view_contract.dart';
import '../../helpers/function.dart';
import '../../models/auth_model.dart';
import '../../models/session_model.dart';
import '../../presenters/auth_presenter.dart';
import '../../routes/route_list.dart';
import '../../utils/session_manager.dart';
import '../../widgets/login_button.dart';

import '../../widgets/snackbar.dart';
import '_background.dart';
import '_form_source.dart';
import '_source.dart';

class SignInView extends StatefulWidget {
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView>
    with TickerProviderStateMixin
    implements LoginViewContract {
  _SignInViewState() {
    authPresenter.loginViewContract = this;
  }

  final authPresenter = Get.put(AuthPresenter());

  BackgroundAuth _bg = BackgroundAuth();

  final LoginForm _loginForm = LoginForm();

  final controller = Get.put(LoginSource());

  final GlobalKey<FormState> _formStateSignIn = GlobalKey<FormState>();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _bg,
          Container(
            margin: EdgeInsets.only(left: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: 400,
                      margin: EdgeInsets.only(top: Get.height * 0.15),
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Container(child: Text('data')),
                          Container(
                            child: TabBar(
                              controller: _tabController,
                              labelColor: Colors.blue,
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(text: 'Sign In'),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 400,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                Form(
                                  key: _formStateSignIn,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: Obx(
                                          () => Column(
                                            children: [
                                              _loginForm.username(
                                                controller: authPresenter
                                                    .source.value.inputUsername,
                                              ),
                                              _loginForm.password(
                                                  obsecureText: controller
                                                      .showPassword.value,
                                                  controller: authPresenter
                                                      .source
                                                      .value
                                                      .inputPassword,
                                                  onTapSuffixIcon: () {
                                                    controller.showPassword
                                                        .toggle();
                                                  },
                                                  suffixIcon: controller
                                                          .showPassword.isTrue
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  onFieldSubmitted: (value) {
                                                    onClickLogin();
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                      LayoutBuilder(
                                        builder: (context, constraints) =>
                                            Container(
                                          margin: EdgeInsets.fromLTRB(
                                              20, 10, 20, 20),
                                          child: Obx(
                                            () => LoginButton(
                                              disabled: authPresenter
                                                  .isProcessing.value,
                                              width: constraints.maxWidth,
                                              label: authPresenter
                                                      .isProcessing.value
                                                  ? SizedBox(
                                                      child:
                                                          CircularProgressIndicator(
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
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onClickLogin() {
    if (_formStateSignIn.currentState!.validate()) {
      authPresenter.signIn();
      authPresenter.setProcessing(true);
    }
  }

  @override
  void onLoginFailed(String message) {
    Snackbar().loginFailed();
    Get.defaultDialog();
    authPresenter.setProcessing(false);
  }

  @override
  void onLoginSuccess(AuthModel userModel) {
    final box = GetStorage();
    List data = [];
    box.write('name', userModel.userfullname!);
    box.write('id', userModel.userid!);
    box.write('username', userModel.username!);
    for (var item in userModel.userdetails!) {
      data.add(item);
    }
    if (userModel.jwtToken == '') {
      authPresenter.setProcessing(false);
      toNameRoute(RouteList.sigin.index);
    } else {
      SessionManager.setLogin(
        SessionModel(
          userid: userModel.userid,
          jwtToken: userModel.jwtToken,
        ),
      ).then((value) => toNameRoute(RouteList.home.index));
    }
  }

  @override
  void onErrorResponse() {
    authPresenter.setProcessing(false);
    Snackbar().loginFailed();
  }
}
