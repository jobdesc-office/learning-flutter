import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constants/config_types.dart';
import 'helpers/function.dart';
import 'presenters/auth_presenter.dart';
import 'presenters/navigation_presenter.dart';
import 'routes/route_list.dart';
import 'routes/routes.dart';
import 'services/app_service.dart';
import 'services/auth_service.dart';
import 'utils/session_manager.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ventes',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      initialRoute: RouteList.home.index,
      debugShowCheckedModeBanner: false,
      getPages: AppRoute.routes,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => NavigationPresenter(), fenix: true);
        Get.lazyPut(() => AuthPresenter(), fenix: true);
        Get.lazyPut(() => AuthService());
        Get.lazyPut(() => AppService());
      }),
      onInit: () async {
        final authPresenter = Get.find<AuthService>();
        Response response = await authPresenter.verifyToken();

        if (Get.currentRoute != RouteList.sigin.index) {
          if (response.statusCode == 401) {
            SessionManager.destroy();
            toNameRoute(RouteList.sigin.index);
          }

          final appService = Get.find<AppService>();
          Response appResponse = await appService.init();
          if (appResponse.statusCode == 200) {
            ConfigType.types = appResponse.body;
          }
        }
      },
    );
  }
}
