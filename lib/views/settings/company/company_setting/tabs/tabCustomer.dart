part of '../company.dart';

class _TabCustomer extends StatefulWidget {
  @override
  State<_TabCustomer> createState() => _TabCustomerState();
}

class _TabCustomerState extends State<_TabCustomer> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final datatable = CompanyCurrencyDataTableSource();
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: BsRow(
          children: [
            BsCol(
              sizes: ColScreen(sm: Col.col_6),
              child: Container(
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Customer'),
                    Tab(text: 'Prospective Customer'),
                    Tab(text: 'Contact'),
                  ],
                ),
              ),
            ),
            BsCol(
              sizes: ColScreen(sm: Col.col_12),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1.5,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _TabCustomers(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
