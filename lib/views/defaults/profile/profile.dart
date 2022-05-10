import 'package:flutter/material.dart';

import '../../../widgets/breadcrumb.dart';
import '../../skins/tempalte.dart';
import 'profile_profile.dart';
import 'profile_schedule.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  late TabController _tabController;

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
            Container(
              margin: EdgeInsets.only(right: 800),
              width: MediaQuery.of(context).size.width * 0.25,
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
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
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
            )
          ],
        ),
      ),
    );
  }
}
