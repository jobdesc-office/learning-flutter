import 'package:flutter/material.dart';

import '../../../widgets/breadcrumb.dart';
import '../../skins/tempalte.dart';

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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Profile',
        breadcrumbs: [
          BreadcrumbWidget('Profile', active: true),
        ],
        child: Column(
          children: [
            Container(
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Profile'),
                  Tab(text: 'Schedules'),
                  Tab(text: 'Prospects')
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Notes')],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Activity')],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Propose Time')],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
