import 'package:get/get.dart';

import '../constants/config_types.dart';
import '../helpers/function.dart';
import '../routes/route_list.dart';
import '../services/app_service.dart';
import '../services/auth_service.dart';
import '../utils/session_manager.dart';

checkJwtToken() async {
  final authPresenter = Get.find<AuthService>();
  Response response = await authPresenter.verifyToken();

  if (Get.currentRoute != RouteList.sigin.index) {
    if (response.statusCode == 401) {
      SessionManager.destroy();
      authPresenter.signOut();
      toNameRoute(RouteList.sigin.index);
    }

    final appService = Get.find<AppService>();
    Response appResponse = await appService.init();
    if (appResponse.statusCode == 200) {
      ConfigType.types = appResponse.body;
    }
  }
}
