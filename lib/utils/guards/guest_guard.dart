import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/auth/guard_contract.dart';
import '../../helpers/function.dart';
import '../../presenters/auth_presenter.dart';
import '../../routes/route_list.dart';

class GuestGuard extends StatelessWidget implements GuardContract {
  final authPresenter = Get.find<AuthPresenter>();

  final Widget? child;

  GuestGuard({this.child}) {
    authPresenter.guardContract = this;
    authPresenter.checkLocalSession();
  }

  Widget? get resultPage {
    if (authPresenter.statusCode.value == 200) {
      if (!authPresenter.isAuthenticated.value) return child;
    } else if (authPresenter.statusCode.value == 500) {
      return errorPage();
    } else if (authPresenter.statusCode.value == 403 &&
        Get.currentRoute != RouteList.sigin.index) {
      toNameRoute(RouteList.sigin.index, pushReplace: true);
    }

    return loadingProcess();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Material(
        child: Container(child: resultPage),
      );
    });
  }

  Widget loadingProcess() {
    return Center(
      child: SizedBox(
        width: 80,
        height: 80,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            Text(
              'Processing',
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  Widget errorPage() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Text(
          '500 Internal Server Error',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void onCheckFailed() {
    authPresenter.isAuthenticated.value = false;
    authPresenter.statusCode.value = 500;
  }

  @override
  void onCheckInternalError() {}

  @override
  void onCheckSuccess({bool isOk = true, bool redirect = true}) {
    authPresenter.isAuthenticated.value = isOk;
    authPresenter.statusCode.value = 200;

    if (isOk) toNameRoute(RouteList.ventesProspect.index);
  }

  @override
  void onCheckTimeout() {}
}
