part of '../../company.dart';

class _TabCompetitor extends GetView implements IndexViewContract {
  final presenter = Get.find<CompetitorPresenter>();
  final datatable = CompetitorDataTableSource();
  final map = Get.put(MapSource());

  _TabCompetitor() {
    presenter.competitorViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomDatabales(
        source: datatable,
        columns: datatable.columns,
        headerActions: [
          ThemeButtonCreate(
            prefix: 'Competitor',
            onPressed: () => presenter.add(context),
          )
        ],
        serverSide: (params) => presenter.datatablesbp(context, params),
        // searchHintText: 'Search by Competitor name, Competitor phone ...',
      ),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    final map = Get.find<MapSource>();
    map.reset();
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().createSuccess();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    final map = Get.find<MapSource>();
    map.reset();
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().deleteSuccess();
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    final map = Get.find<MapSource>();
    map.reset();
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().editSuccess();
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    final map = Get.find<MapSource>();
    presenter.setProcessing(false);
    map.reset();
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
    datatable.onEditListener =
        (countryid) => presenter.edit(context, countryid);
    datatable.onDeleteListener =
        (cstmid, cstmname) => presenter.delete(context, cstmid, cstmname);
  }
}
