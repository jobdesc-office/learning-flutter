import 'package:boilerplate/contracts/default/home_view_contract.dart';
import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/views/defaults/home/_home_source.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../models/default/home_model.dart';
import '../../../presenters/default/home_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../skins/template.dart';

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

  final presenter = Get.find<HomePresenter>();

  final controller = Get.put(HomeSource());

  final _navigation = Get.find<NavigationPresenter>();

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
              sizes: ColScreen(sm: Col.col_12),
              child: Container(
                color: Colors.black,
                child: SizedBox(
                  height: 10,
                  width: 500,
                ),
              ),
            ),
            BsCol(
                margin: EdgeInsets.only(left: 8, right: 20),
                sizes: ColScreen(sm: Col.col_8),
                child: BsRow(
                  children: [
                    BsCol(
                      sizes: ColScreen(sm: Col.col_6),
                      child: Column(
                        children: [
                          Container(
                            child: Obx(() => TabBar(
                                  controller: _tabController,
                                  labelColor: Colors.grey,
                                  unselectedLabelColor:
                                      _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black,
                                  tabs: [
                                    Tab(text: 'Activity'),
                                    Tab(text: 'Collaborate'),
                                    Tab(text: 'Details')
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    BsCol(
                      sizes: ColScreen(sm: Col.col_12),
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.elseDarkColor
                                  : ColorPallates.elseLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: double.infinity,
                            height: 150,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BsRow(
                                      children: [
                                        BsCol(
                                            sizes: ColScreen(sm: Col.col_1),
                                            child: Column(
                                              children: [
                                                OutlinedDotIndicator(),
                                                SizedBox(
                                                  height: 50.0,
                                                  child: SolidLineConnector(),
                                                )
                                              ],
                                            )),
                                        BsCol(
                                            sizes: ColScreen(sm: Col.col_2),
                                            child: Text('Today')),
                                        BsCol(
                                            sizes: ColScreen(sm: Col.col_9),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Meeting',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('at Town Hall'),
                                              ],
                                            )),
                                        BsCol(
                                            sizes: ColScreen(sm: Col.col_1),
                                            child: Column(
                                              children: [
                                                OutlinedDotIndicator()
                                              ],
                                            )),
                                        BsCol(
                                            sizes: ColScreen(sm: Col.col_2),
                                            child: Text('Yesterday')),
                                        BsCol(
                                            sizes: ColScreen(sm: Col.col_9),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Meeting',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('at Town Hall'),
                                              ],
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('Activity')],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('Propose Time')],
                                ),
                              ],
                            ),
                          )),
                    ),
                    BsCol(
                      margin: EdgeInsets.only(top: 20),
                      sizes: ColScreen(sm: Col.col_12),
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.elseDarkColor
                                  : ColorPallates.elseLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        BsRow(
                                          children: [
                                            BsCol(
                                                sizes: ColScreen(sm: Col.col_1),
                                                child: Column(
                                                  children: [
                                                    OutlinedDotIndicator(),
                                                    SizedBox(
                                                      height: 50.0,
                                                      child:
                                                          SolidLineConnector(),
                                                    )
                                                  ],
                                                )),
                                            BsCol(
                                                sizes: ColScreen(sm: Col.col_2),
                                                child: Text('Today')),
                                            BsCol(
                                                sizes: ColScreen(sm: Col.col_9),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Meeting',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('at Town Hall'),
                                                  ],
                                                )),
                                            BsCol(
                                                sizes: ColScreen(sm: Col.col_1),
                                                child: Column(
                                                  children: [
                                                    OutlinedDotIndicator()
                                                  ],
                                                )),
                                            BsCol(
                                                sizes: ColScreen(sm: Col.col_2),
                                                child: Text('Yesterday')),
                                            BsCol(
                                                sizes: ColScreen(sm: Col.col_9),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Meeting',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('at Town Hall'),
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                  ],
                )),
            BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(sm: Col.col_4),
                child: BsRow(
                  children: [
                    BsCol(
                      margin: EdgeInsets.only(top: 12, left: 10),
                      sizes: ColScreen(sm: Col.col_12),
                      child: Text('Contacts'),
                    ),
                    BsCol(
                      margin: EdgeInsets.only(top: 20),
                      sizes: ColScreen(sm: Col.col_12),
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.elseDarkColor
                                  : ColorPallates.elseLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Bambang'),
                                          Text('Granfather')
                                        ],
                                      ),
                                      CircleAvatar(child: Icon(Icons.person))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Dadang bin Bambang'),
                                          Text('Father')
                                        ],
                                      ),
                                      CircleAvatar(child: Icon(Icons.person))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Jajang bin Dadang bin Bambang'),
                                          Text('Granchild')
                                        ],
                                      ),
                                      CircleAvatar(child: Icon(Icons.person))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    BsCol(
                      margin: EdgeInsets.only(top: 20, left: 10),
                      sizes: ColScreen(sm: Col.col_12),
                      child: Text('Notes'),
                    ),
                    BsCol(
                      margin: EdgeInsets.only(top: 20),
                      sizes: ColScreen(sm: Col.col_12),
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.elseDarkColor
                                  : ColorPallates.elseLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(sm: Col.col_12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Bambang'),
                                              Text('2 minutes ago')
                                            ],
                                          )),
                                      BsCol(
                                          margin: EdgeInsets.only(top: 10),
                                          sizes: ColScreen(sm: Col.col_12),
                                          child: Text(
                                            'HUSS',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    BsCol(
                      margin: EdgeInsets.only(top: 20),
                      sizes: ColScreen(sm: Col.col_12),
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.elseDarkColor
                                  : ColorPallates.elseLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(sm: Col.col_12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  'Jajang bin Dadang bin Bambang'),
                                              Text('1 hours ago')
                                            ],
                                          )),
                                      BsCol(
                                          margin: EdgeInsets.only(top: 10),
                                          sizes: ColScreen(sm: Col.col_12),
                                          child: Text(
                                            'Innalillahi wa innailaihi rajiun, Alhamdulillah warisan cair',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    BsCol(
                      margin: EdgeInsets.only(top: 20),
                      sizes: ColScreen(sm: Col.col_12),
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.elseDarkColor
                                  : ColorPallates.elseLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(sm: Col.col_12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Dadang bin Bambang'),
                                              Text('2 hours ago')
                                            ],
                                          )),
                                      BsCol(
                                          margin: EdgeInsets.only(top: 10),
                                          sizes: ColScreen(sm: Col.col_12),
                                          child: Text(
                                            'Nak, Mbah mu sedo',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    )
                  ],
                )),
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
