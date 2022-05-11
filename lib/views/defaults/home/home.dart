import 'package:boilerplate/contracts/default/home_view_contract.dart';
import 'package:boilerplate/views/defaults/home/_home_source.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/security/home_model.dart';
import '../../../presenters/default/home_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../skins/tempalte.dart';

class HomeView extends StatelessWidget implements HomeViewContract {
  final presenter = Get.find<HomePresenter>();
  final controller = Get.put(HomeSource());

  HomeView() {
    presenter.homeContract = this;
    presenter.index();
  }

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
                      color: Colors.green.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  controller.users.value.toString(),
                                  style: TextStyle(fontSize: 35),
                                ),
                                Icon(Icons.person, size: 70)
                              ],
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Get.toNamed(RouteList.masterUser.index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.shade200,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        controller.users.value > 1
                                            ? 'Active Users'
                                            : 'Active User',
                                        style: TextStyle(fontSize: 18)),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 25,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )))),
            BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(sm: Col.col_3),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  controller.schedules.value.toString(),
                                  style: TextStyle(fontSize: 35),
                                ),
                                Icon(Icons.schedule, size: 70)
                              ],
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Get.toNamed(RouteList.ventesSchedule.index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade200,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        controller.schedules.value > 1
                                            ? 'Schedules Remaining'
                                            : 'Schedule Remaining',
                                        style: TextStyle(fontSize: 18)),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 25,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )))),
            BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(sm: Col.col_3),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  controller.prospects.value.toString(),
                                  style: TextStyle(fontSize: 35),
                                ),
                                Icon(Icons.leaderboard, size: 70)
                              ],
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Get.toNamed(RouteList.ventesProspect.index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.shade200,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        controller.prospects.value > 1
                                            ? 'Prospects Target'
                                            : 'Prospect Target',
                                        style: TextStyle(fontSize: 18)),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 25,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )))),
            BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(sm: Col.col_3),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  controller.partners.value.toString(),
                                  style: TextStyle(fontSize: 35),
                                ),
                                Icon(Icons.domain, size: 70)
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(
                                  RouteList.masterBusinessPartner.index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.purple.shade200,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        controller.partners.value > 1
                                            ? 'Business Partners'
                                            : 'Business Partner',
                                        style: TextStyle(fontSize: 18)),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 25,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )))),
          ],
        ),
      ),
    );
  }

  @override
  void onError(message) {
    print(message);
  }

  @override
  void onSuccess(Response response) {
    HomeModel home = HomeModel.fromJson(response.body);
    controller.users.value = home.users;
    controller.schedules.value = home.schedules;
    controller.prospects.value = home.prospects;
    controller.partners.value = home.partners;
  }
}
