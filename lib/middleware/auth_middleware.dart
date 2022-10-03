import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presenters/auth_presenter.dart';
import '../routes/route_list.dart';

class AuthMiddleware extends GetMiddleware {
  AuthPresenter get authPresenter => Get.find<AuthPresenter>();

  @override
  RouteSettings? redirect(String? route) {
    if (!authPresenter.isAuthenticated.value &&
        route != RouteList.sigin.index) {
      return RouteSettings(name: RouteList.sigin.index);
    } else if (authPresenter.isAuthenticated.value &&
        route == RouteList.sigin.index) {
      return RouteSettings(name: RouteList.home.index);
    }

    return null;
  }
}
