part of '../company.dart';

class _TabProspect extends StatefulWidget {
  const _TabProspect({Key? key}) : super(key: key);

  @override
  State<_TabProspect> createState() => _TabProspectState();
}

class _TabProspectState extends State<_TabProspect>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: BsRow(
        children: [
          BsCol(
            sizes: ColScreen(sm: Col.col_9),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Category'),
                Tab(text: 'Customer Label'),
                Tab(text: 'Lost Reason'),
                Tab(text: 'Stage'),
                Tab(text: 'Status'),
                Tab(text: 'Type'),
                Tab(text: 'Competitor'),
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
                  _TabProspectCategory(context),
                  _TabProspectCustomerLabel(context),
                  _TabProspectLostReason(context),
                  _TabProspectStage(context),
                  _TabProspectStatus(context),
                  _TabProspectType(context),
                  _TabCompetitor(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
