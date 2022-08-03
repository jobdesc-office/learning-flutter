import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/config_types.dart';
import '../helpers/function.dart';
import '../models/auth_model.dart';
import '../presenters/auth_presenter.dart';
import '../routes/route_list.dart';
import '../services/app_service.dart';
import '../services/auth_service.dart';
import '../utils/session_manager.dart';

checkJwtToken() async {
  final box = GetStorage();
  final authService = Get.find<AuthService>();
  final authPresenter = Get.find<AuthPresenter>();
  final _nav = Get.find<NavigationPresenter>();
  Response response = await authService.verifyToken();

  if (Get.currentRoute != RouteList.sigin.index) {
    if (response.statusCode == 401) {
      SessionManager.destroy();
      authService.signOut();
      _nav.darkTheme.value = false;
      authPresenter.isProcessing.value = false;
      Snackbar().sessionExpired();
      toNameRoute(RouteList.sigin.index);
    }
    if (authPresenter.detailUser.isEmpty) {
      List data = box.read('details');

      // if (data.isNotEmpty) {
      //   authPresenter.detailUser.value = data;
      // }
      List<Userdetails> datas = [];
      data.forEach((element) => datas.add(Userdetails.fromJson(element)));
      authPresenter.detailUser.value = datas;
    }

    final appService = Get.put(AppService());
    Response appResponse = await appService.init();
    if (appResponse.statusCode == 200) {
      ConfigType.types = appResponse.body;
    }
  }
}
