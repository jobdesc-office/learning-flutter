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
            sizes: ColScreen(sm: Col.col_2),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Category'),
                Tab(text: 'Type'),
              ],
            ),
          ),
          BsCol(
            sizes: ColScreen(sm: Col.col_12),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _TabCategory(),
                  _TabType(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TabCategory extends StatelessWidget implements IndexViewContract {
  final presenter = Get.find<StBpTypePresenter>();
  final datatable = ActivityCatDataTableSource();
  _TabCategory() {
    presenter.StBpTypeViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CustomDatabales(
            source: datatable,
            columns: datatable.columns,
            serverSide: (params) => presenter.datatables(
                context, params, ConfigType.activitycategory)),
      ]),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onCreateSuccess
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onDeleteSuccess
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onEditSuccess
  }

  @override
  void onErrorRequest(Response response) {
    // TODO: implement onErrorRequest
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    // datatable.onDetailsListener =
    //     (typeid) => presenter.details(context, typeid);
    // datatable.onEditListener = (typeid) => presenter.edit(context, typeid);
    // if (btn.btnDeleteDisabled.value)
    //   datatable.onDeleteListener =
    //       (typeid, name) => presenter.delete(context, typeid, name);
    // else
    //   datatable.onDeleteListener =
    //       (typeid, name) => Snackbar().regionDeletePermission();
  }
}

class _TabType extends StatelessWidget {
  const _TabType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text('data'),
        )
      ]),
    );
  }
}
