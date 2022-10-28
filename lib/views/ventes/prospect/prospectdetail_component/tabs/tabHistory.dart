part of '../../prospect_detail.dart';

class _TabHistory extends StatefulWidget {
  const _TabHistory({Key? key}) : super(key: key);

  @override
  State<_TabHistory> createState() => _TabHistoryState();
}

class _TabHistoryState extends State<_TabHistory>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final _navigation = Get.find<NavigationPresenter>();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            child: BsRow(
              children: [
                BsCol(
                  sizes: ColScreen(sm: Col.col_4),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.green,
                    unselectedLabelColor: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black,
                    tabs: [
                      Tab(
                        text: 'Web',
                      ),
                      Tab(
                        text: 'Apps',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.9,
            child: TabBarView(
              controller: _tabController,
              children: [_TabHistoryWeb(), _TabHistoryApps()],
            ),
          )
        ],
      ),
    );
  }
}
