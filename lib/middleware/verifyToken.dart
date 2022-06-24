import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/widgets/snackbar.dart';
import 'package:get/get.dart';

import '../constants/config_types.dart';
import '../helpers/function.dart';
import '../routes/route_list.dart';
import '../services/app_service.dart';
import '../services/auth_service.dart';
import '../utils/session_manager.dart';

checkJwtToken() async {
  final authPresenter = Get.find<AuthService>();
  final _nav = Get.find<NavigationPresenter>();
  Response response = await authPresenter.verifyToken();

  if (Get.currentRoute != RouteList.sigin.index) {
    if (response.statusCode == 401) {
      SessionManager.destroy();
      authPresenter.signOut();
      _nav.darkTheme.value = false;
      Snackbar().sessionExpired();
      toNameRoute(RouteList.sigin.index);
    }

    final appService = Get.put(AppService());
    Response appResponse = await appService.init();
    if (appResponse.statusCode == 200) {
      ConfigType.types = appResponse.body;
    }
  }
}
