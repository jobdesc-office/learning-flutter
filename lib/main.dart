import 'package:boilerplate/presenters/auth_presenter.dart';
import 'package:boilerplate/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presenters/navigation_presenter.dart';
import 'routes/route_list.dart';
import 'routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteList.home.index,
      debugShowCheckedModeBanner: false,
      getPages: AppRoute.routes,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => NavigationPresenter(), fenix: true);
        Get.lazyPut(() => AuthPresenter(), fenix: true);
        Get.lazyPut(() => AuthService());
      }),
    );
  }
}
