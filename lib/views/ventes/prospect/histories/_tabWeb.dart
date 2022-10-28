part of '../prospect_detail.dart';

class _TabHistoryWeb extends StatefulWidget {
  const _TabHistoryWeb({Key? key}) : super(key: key);

  @override
  State<_TabHistoryWeb> createState() => _TabHistoryWebState();
}

class _TabHistoryWebState extends State<_TabHistoryWeb>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final _navigation = Get.find<NavigationPresenter>();

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
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
                  // sizes: ColScreen(sm: Col.col_4),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.green,
                    unselectedLabelColor: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black,
                    tabs: [
                      Tab(
                        text: 'Prospect',
                      ),
                      Tab(
                        text: 'Prospect Activity',
                      ),
                      Tab(
                        text: 'Prospect Assign',
                      ),
                      Tab(
                        text: 'Prospect Product',
                      ),
                      Tab(
                        text: 'Prospect File',
                      ),
                      Tab(
                        text: 'Prospect CustomField',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            child: TabBarView(
              controller: _tabController,
              children: [
                TabWebProspect(),
                TabWebProspectActivity(),
                TabWebProspectAssign(),
                TabWebProspectProduct(),
                TabWebProspectFile(),
                TabWebProspectCustomfield()
              ],
            ),
          )
        ],
      ),
    );
  }
}
