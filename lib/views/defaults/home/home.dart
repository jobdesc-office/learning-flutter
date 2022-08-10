import 'package:boilerplate/contracts/default/home_view_contract.dart';
import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../models/default/home_model.dart';
import '../../../presenters/default/home_presenter.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/custom_shape.dart';
import '../../../widgets/breadcrumb.dart';
import '../../skins/template.dart';
import '_source.dart';

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
    _tabController = TabController(length: 3, vsync: this);
  }

  late TabController _tabController;

  final schedulePresenter = Get.find<SchedulePresenter>();
  final presenter = Get.find<HomePresenter>();

  final _navigation = Get.find<NavigationPresenter>();

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
                    width: 200,
                    height: 70,
                    child: Text('data'),
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
