part of '../company.dart';

class _TabCustomizeField extends StatefulWidget {
  const _TabCustomizeField({Key? key}) : super(key: key);

  @override
  State<_TabCustomizeField> createState() => _TabCustomizeFieldState();
}

class _TabCustomizeFieldState extends State<_TabCustomizeField> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final sources = Get.put(CustomizeFieldSource());
    return Container(
      margin: EdgeInsets.all(5),
      child: BsRow(
        children: [
          BsCol(
            sizes: ColScreen(sm: Col.col_3),
            child: Obx(() => TabBar(
                  onTap: (x) {
                    sources.isForm.value = false;
                    sources.isEdit.value = false;
                  },
                  controller: _tabController,
                  labelColor: Colors.green,
                  unselectedLabelColor: _navigation.darkTheme.value ? Colors.white : Colors.black,
                  tabs: [
                    Tab(text: 'Daily Activity'),
                    Tab(text: 'Prospect'),
                    Tab(text: 'Schedule'),
                  ],
                )),
          ),
          BsCol(
            sizes: ColScreen(sm: Col.col_12),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _TabCustomizeFieldDailyActivity(),
                  _TabCustomizeFieldProspect(),
                  _TabCustomizeFieldSchedule(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
