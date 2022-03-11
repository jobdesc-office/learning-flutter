import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_palattes.dart';
import '../../contracts/auth/guard_contract.dart';
import '../../helpers/function.dart';
import '../../presenters/auth_presenter.dart';
import '../../routes/route_list.dart';

class GuardGuest extends StatelessWidget implements GuardContract {
  final authPresenter = Get.find<AuthPresenter>();

  GuardGuest({
    Key? key,
    this.child,
  }) {
    authPresenter.guardContract = this;
    authPresenter.check();
  }

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!authPresenter.isOnProcess.value &&
          !authPresenter.isAuthenticated.value) return Container(child: child);

      return errorPage();
    });
  }

  Widget errorPage() {
    if (authPresenter.statusCode.value == 408)
      return timeoutPage();
    else if (authPresenter.statusCode.value == 500) return internalErrorPage();

    return loadingPage();
  }

  Widget loadingPage() {
    return Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          color: ColorPallates.dark,
          strokeWidth: 1.5,
        ),
      ),
    );
  }

  Widget timeoutPage() {
    return Material(
      child: Center(
        child: Text(
          'Opps, timeout',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget internalErrorPage() {
    return Material(
      child: Center(
        child: Text(
          'Internal error',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  void onCheckFailed() {
    print("error auth guest");
  }

  @override
  void onCheckSuccess() {
    if (authPresenter.isAuthenticated.value) toNameRoute(RouteList.home.index);
  }
}
