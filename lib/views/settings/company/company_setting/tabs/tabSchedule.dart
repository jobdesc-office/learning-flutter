part of '../company.dart';

class _TabSchedules extends StatefulWidget {
  const _TabSchedules({Key? key}) : super(key: key);

  @override
  State<_TabSchedules> createState() => _TabSchedulesState();
}

class _TabSchedulesState extends State<_TabSchedules>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: BsRow(
        children: [
          BsCol(
            sizes: ColScreen(sm: Col.col_2),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Type'),
              ],
            ),
          ),
          BsCol(
            sizes: ColScreen(sm: Col.col_12),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _TabScheduleType(
                    context,
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
