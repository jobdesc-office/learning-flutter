import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../contracts/auth/login_view_contract.dart';
import '../../contracts/default/information_view_contract.dart';
import '../../helpers/function.dart';
import '../../models/auth_model.dart';
import '../../models/default/information_model.dart';
import '../../models/rolepermission_model.dart';
import '../../models/session_model.dart';
import '../../presenters/auth_presenter.dart';
import '../../presenters/default/information_presenter.dart';
import '../../routes/route_list.dart';
import '../../services/app_service.dart';
import '../../styles/color_palattes.dart';
import '../../utils/session_manager.dart';
import '../../widgets/login_button.dart';

import '../../widgets/snackbar.dart';
import '_form_source.dart';
import '_source.dart';

class SignInView extends StatefulWidget {
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView>
    with TickerProviderStateMixin
    implements LoginViewContract, InformationViewContract {
  _SignInViewState() {
    authPresenter.loginViewContract = this;
    presenter.infoContract = this;
  }

  final presenter = Get.put(InformationPresenter());

  final authPresenter = Get.put(AuthPresenter());

  final appService = Get.put(AppService());

  final LoginForm _loginForm = LoginForm();

  final controller = Get.put(LoginSource());

  final GlobalKey<FormState> _formStateSignIn = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f1f1),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: BsRow(
                children: [
                  BsCol(
                    sizes: ColScreen(sm: Col.col_2),
                  ),
                  BsCol(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: Offset(0, 0),
                          blurRadius: 20,
                          spreadRadius: 10,
                        )
                      ],
                    ),
                    sizes: ColScreen(sm: Col.col_8),
                    child: BsRow(
                      children: [
                        BsCol(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0)),
                          ),
                          height: MediaQuery.of(context).size.height * 0.55,
                          alignment: Alignment.center,
                          sizes: ColScreen(sm: Col.col_6),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/ventes-logo.svg',
                                  width: 250,
                                  height: 75,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Form(
                                    key: _formStateSignIn,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                      .source
                                                      .value
                                                      .inputUsername,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        BsCol(
                          color: ColorPallates.primary,
                          height: MediaQuery.of(context).size.height * 0.55,
                          sizes: ColScreen(sm: Col.col_6),
                          child: Obx(() => Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.what.toggle();
                                            if (controller.about.value &&
                                                controller.what.value) {
                                              controller.about.value =
                                                  !controller.what.value;
                                            }
                                            if (controller.what.value) {
                                              controller.isProcessing.value =
                                                  true;
                                              presenter.getInfo('whatsventes');
                                            }
                                          },
                                          child: Text("What's Ventes ?",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.about.toggle();
                                            if (controller.what.value &&
                                                controller.about.value) {
                                              controller.what.value =
                                                  !controller.about.value;
                                            }
                                            if (controller.about.value) {
                                              controller.isProcessing.value =
                                                  true;
                                              presenter
                                                  .getInfo('abouthyperdata');
                                            }
                                          },
                                          child: Text('About Hyperdata',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    padding: EdgeInsets.all(10),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          if (!controller.isProcessing.value)
                                            if (!controller.about.value &&
                                                !controller.what.value)
                                              Image.asset(
                                                  'assets/images/bg_auth.png'),
                                          if (!controller.isProcessing.value)
                                            if (controller.about.value ||
                                                controller.what.value)
                                              Container(
                                                  decoration: BoxDecoration(
                                                    // border: Border.all(
                                                    //     color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                  ),
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      controller.desc.value,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )),
                                          if (controller.isProcessing.value)
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: SizedBox(
                                                      width: 80,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 10),
                                                            child:
                                                                CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Processing',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  BsCol(
                    sizes: ColScreen(sm: Col.col_2),
                  ),
                ],
              ),
            )
          ],
        ),
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
  void onLoginSuccess(AuthModel userModel) async {
    final box = GetStorage();
    List<Userdetails> data = [];
    box.write('usermodel', userModel.toJson());
    box.write('name', userModel.userfullname!);
    box.write('id', userModel.userid!);
    box.write('username', userModel.username!);
    box.write('role', userModel.userdetails?.first.usertype?.typeid);
    for (var item in userModel.userdetails!) {
      data.add(item);
    }
    box.write('details', data);
    box.write('mybpid', data.first.businesspartner!.bpid);
    authPresenter.detailUser.value = data;
    if (userModel.jwtToken == '') {
      authPresenter.setProcessing(false);
      toNameRoute(RouteList.sigin.index);
    } else {
      SessionManager.setLogin(
        SessionModel(
          userid: userModel.userid,
          jwtToken: userModel.jwtToken,
        ),
      ).then((value) async {
        Response roleResponse = await appService.role();
        List<RolePermissionModel> role = [];
        List rawrole = [];
        if (roleResponse.statusCode == 200) {
          for (var item in roleResponse.body) {
            rawrole.add(item);
            role.add(RolePermissionModel.fromJson(item));
          }
          authPresenter.rolepermis.value = role;
          authPresenter.rawrolepermis.value = rawrole;
        }
        toNameRoute(RouteList.home.index);
      });
    }
  }

  @override
  void onErrorResponse() {
    authPresenter.setProcessing(false);
    Snackbar().loginFailed();
  }

  @override
  void onSuccess(Response response) {
    controller.isProcessing.value = false;
    InformationModel model = InformationModel.fromJson(response.body);
    controller.desc.value = model.infodesc ?? '';
  }
}
