import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/default/home_view_contract.dart';
import '../../../models/default/home_model.dart';
import '../../../presenters/default/home_presenter.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../skins/template.dart';
import '_source.dart';
import 'chart/_leads_users_chart.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin
    implements HomeViewContract {
  @override
  void initState() {
    super.initState();
    presenter.homeContract = this;
    presenter.index();
  }

  final schedulePresenter = Get.find<SchedulePresenter>();
  final presenter = Get.find<HomePresenter>();

  final source = Get.put(HomeSource());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
          title: 'Dashboard',
          breadcrumbs: [
            BreadcrumbWidget('Insight'),
            BreadcrumbWidget('Dashboard', active: true),
          ],
          activeRoutes: [RouteList.home.index],
          child: BsRow(children: [
            BsCol(
                margin: EdgeInsets.all(3),
                sizes: ColScreen(sm: Col.col_3),
                child: Container(
                    padding: EdgeInsets.all(5),
                    width: 200,
                    child: LeadsUsersChart(),
                    color: Colors.white)),
            BsCol(
                margin: EdgeInsets.all(3),
                sizes: ColScreen(sm: Col.col_3),
                child: Container(
                    width: 200,
                    height: 70,
                    child: Text('data'),
                    color: Colors.white)),
            BsCol(
                margin: EdgeInsets.all(3),
                sizes: ColScreen(sm: Col.col_6),
                child: Container(
                    width: 200,
                    height: 70,
                    child: Text('data'),
                    color: Colors.white)),
          ])),
    );
  }

  @override
  void onError(message) {
    print(message);
  }

  @override
  void onSuccess(Response response) {
    int x = 0;
    List dataSchedule = [];
    List dataScheduleGuest = [];
    var home = HomeModel.fromJson(response.body);
    if (home.mySchedules != null) {
      for (var item in home.mySchedules!) {
        dataSchedule.add(item);
        x++;
      }
    }
    if (home.mySchedulesGuest != null) {
      for (var item in home.mySchedulesGuest!) {
        dataScheduleGuest.add(item);
      }
    }

    source.dataSchedule.value = dataSchedule;
    source.dataScheduleGuest.value = dataScheduleGuest;
    source.x.value = x;
  }
}
