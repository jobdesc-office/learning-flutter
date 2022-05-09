import 'package:boilerplate/contracts/default/home_view_contract.dart';
import 'package:boilerplate/views/defaults/home/_home_source.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../skins/tempalte.dart';

class HomeView extends StatelessWidget implements HomeViewContract {
  final c = Get.put(HomeSource());
  HomeView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Dashboard',
        breadcrumbs: [
          BreadcrumbWidget('Dashboard', active: true),
        ],
        activeRoutes: [RouteList.home.index],
        child: BsRow(
          children: [
            BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(sm: Col.col_3),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(() => Text(
                                  c.users.value.toString(),
                                  style: TextStyle(fontSize: 35),
                                )),
                            Icon(Icons.person, size: 70)
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('Active Users',
                              style: TextStyle(fontSize: 15)),
                        )
                      ],
                    ))),
            BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(sm: Col.col_3),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(() => Text(
                                  c.schedules.value.toString(),
                                  style: TextStyle(fontSize: 35),
                                )),
                            Icon(Icons.schedule, size: 70)
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('Schedule Remaining',
                              style: TextStyle(fontSize: 15)),
                        )
                      ],
                    ))),
            BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(sm: Col.col_3),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(() => Text(
                                  c.prospects.value.toString(),
                                  style: TextStyle(fontSize: 35),
                                )),
                            Icon(Icons.leaderboard, size: 70)
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('Prospect Target',
                              style: TextStyle(fontSize: 15)),
                        )
                      ],
                    ))),
            BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(sm: Col.col_3),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(() => Text(
                                  c.partners.value.toString(),
                                  style: TextStyle(fontSize: 35),
                                )),
                            Icon(Icons.domain, size: 70)
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text('Business Partners',
                              style: TextStyle(fontSize: 15)),
                        )
                      ],
                    ))),
          ],
        ),
      ),
    );
  }

  @override
  void onError(message) {
    // TODO: implement onError
  }

  @override
  void onSuccess(Response response) {
    // TODO: implement onSuccess
  }
}
