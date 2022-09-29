import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/auth/guard_contract.dart';
import '../../helpers/function.dart';
import '../../presenters/auth_presenter.dart';
import '../../routes/route_list.dart';
import '../../views/defaults/404.dart';

class AuthGuard extends StatelessWidget implements GuardContract {
  final authPresenter = Get.find<AuthPresenter>();
  final Widget? child;
  final String? parent;
  final String? parent2;
  final String? route;

  AuthGuard({this.child, this.parent, this.parent2, this.route}) {
    authPresenter.guardContract = this;
    authPresenter.checkLocalSession();
  }

  Widget? get resultPage {
    if (authPresenter.statusCode.value == 200) {
      if (authPresenter.isAuthenticated.value) {
        if (authPresenter.rolepermis.isNotEmpty) {
          try {
            bool perm = false;
            var permis = authPresenter.rolepermis.value
                .where((element) =>
                    element.features
                        ?.where((element) => element.featslug == 'viewable')
                        .first
                        .permissions
                        ?.hasaccess ??
                    false)
                .toList();

            var permission = permis
                .where((element) => element.menunm == parent)
                .first
                .children;

            var per;

            if (parent2 == null)
              per = permission
                  ?.where((element) => element.menuroute == route)
                  .first
                  .features;
            else {
              per = permission
                  ?.where((element) => element.menunm == parent2)
                  .first
                  .children
                  ?.where((element) => element.menuroute == route)
                  .first
                  .features;
            }

            var access = per
                    ?.where((element) => element.featslug == 'viewable')
                    .first
                    .permissions
                    ?.hasaccess ??
                false;

            if (access) {
              return child;
            }
          } catch (e) {
            return Page404();
          }
        }

        // return child;
      }
    }

    // return loadingProcess();

    return Page404();
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
    authPresenter.statusCode.value = 403;

    toNameRoute(RouteList.sigin.index);
  }

  @override
  void onCheckInternalError() {}

  @override
  void onCheckSuccess({bool isOk = true, bool redirect = true}) {
    if (isOk) {
      authPresenter.statusCode.value = 200;
      authPresenter.isAuthenticated.value = true;
    } else {
      onCheckFailed();
    }
  }

  @override
  void onCheckTimeout() {}
}
