part of '../company.dart';

class _TabActivities extends StatefulWidget {
  const _TabActivities({Key? key}) : super(key: key);

  @override
  State<_TabActivities> createState() => _TabActivitiesState();
}

class _TabActivitiesState extends State<_TabActivities>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: BsRow(
        children: [
          BsCol(
            sizes: ColScreen(sm: Col.col_4),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Activity'),
                Tab(text: 'Prospect'),
              ],
            ),
          ),
          BsCol(
            sizes: ColScreen(sm: Col.col_12),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.76,
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text('data'),
                          )
                        ]),
                  ),
                  SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text('data'),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
