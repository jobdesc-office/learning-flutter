import 'package:boilerplate/presenters/default/profile_presenter.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../skins/template.dart';
import 'profile_profile.dart';
import 'profile_schedule.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final presenter = Get.find<ProfilePresenter>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        // title: 'Profile',
        // breadcrumbs: [
        //   BreadcrumbWidget('Profile', active: true),
        // ],
        child: Column(
          children: [
            BsRow(
              children: [
                BsCol(
                  sizes: ColScreen(sm: Col.col_3),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(text: 'Profile'),
                        Tab(text: 'Schedules'),
                        // Tab(text: 'Prospects')
                      ],
                    ),
                  ),
                ),
                BsCol(
                  sizes: ColScreen(sm: Col.col_12),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ProfileProfileView(),
                        ProfileScheduleView(),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [Text('Propose Time')],
                        // )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
