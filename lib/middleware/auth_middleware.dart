import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presenters/auth_presenter.dart';
import '../routes/route_list.dart';

class AuthMiddleware extends GetMiddleware {
  AuthPresenter get authPresenter => Get.find<AuthPresenter>();

  @override
  RouteSettings? redirect(String? route) {
    return authPresenter.isAuthenticated.value
        ? null
        : RouteSettings(name: RouteList.sigin.index);
  }
}
