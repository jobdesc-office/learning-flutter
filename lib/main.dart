import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'middleware/verifyToken.dart';
import 'presenters/auth_presenter.dart';
import 'presenters/navigation_presenter.dart';
import 'routes/route_list.dart';
import 'routes/routes.dart';
import 'services/app_service.dart';
import 'services/auth_service.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final control = Get.put(NavigationPresenter());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          title: 'Ventes',
          theme: control.darkTheme.value
              ? ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.green,
                  fontFamily: 'Monseratt')
              : ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.green,
                  fontFamily: 'Monseratt'),
          initialRoute: RouteList.ventesProspect.index,
          debugShowCheckedModeBanner: false,
          getPages: AppRoute.routes,
          initialBinding: BindingsBuilder(() {
            Get.lazyPut(() => NavigationPresenter(), fenix: true);
            Get.lazyPut(() => AuthPresenter(), fenix: true);
            Get.lazyPut(() => AuthService());
            Get.lazyPut(() => AppService());
          }),
          onInit: () async {
            await checkJwtToken();
          },
        ));
  }
}
