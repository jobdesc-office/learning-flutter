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
      child: TabHistory(),
    );
  }
}
