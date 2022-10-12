part of '../report.dart';

// ignore: must_be_immutable
class AttendanceTab extends StatelessWidget implements IndexViewContract {
  AttendanceDataTableSource datatable = AttendanceDataTableSource();

  AttendanceTab() {
    presenter.attendFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<ReportPresenter>();

    return Obx(() => Column(
          children: [
            CustomDatabales(
              source: datatable,
              columns: datatable.columns,
              headerActions: [user(), startdate(context), enddate(context)],
              serverSide: (params) => presenter.attenddatatables(
                  context, params,
                  start: startdates.value == '' ? null : startdates.value,
                  end: enddates.value == '' ? null : enddates.value,
                  userid: selectOwner.getSelectedAsString()),
            ),
          ],
        ));
  }

  var startdates = ''.obs;
  var enddates = ''.obs;
  var dates = DateTime.now().obs;

  BsSelectBoxController selectOwner = BsSelectBoxController();

  final _navigation = Get.find<NavigationPresenter>();
  Widget user() {
    return Obx(() => Container(
          width: 200,
          child: CustomSelectBox(
            searchable: true,
            controller: selectOwner,
            hintText: BaseText.hiintSelect(field: 'User'),
            serverSide: (params) => selectApiProspectOwner(params),
            onChange: (value) {
              datatable.controller.reload();
            },
          ),
        ));
  }

  Widget startdate(context) {
    return BsButton(
        margin: EdgeInsets.only(left: 5),
        style: BsButtonStyle(
            color: Color.fromARGB(255, 165, 165, 165),
            backgroundColor: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            borderColor: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        width: 120,
        size: BsButtonSize.btnLg,
        onPressed: () {
          _startDates(context);
        },
        label: Obx(() =>
            Text(startdates.value == '' ? 'Start Date' : startdates.value)));
  }

  Widget enddate(context) {
    return Obx(() => BsButton(
        margin: EdgeInsets.only(left: 5),
        disabled: startdates.value == '' ? true : false,
        style: BsButtonStyle(
            color: Color.fromARGB(255, 165, 165, 165),
            backgroundColor: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            borderColor: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        width: 120,
        size: BsButtonSize.btnLg,
        onPressed: () {
          _endDates(context);
        },
        label: Obx(
            () => Text(enddates.value == '' ? 'End Date' : enddates.value))));
  }

  _startDates(BuildContext context) async {
    final DateTime? selectedAct = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedAct != null) {
      startdates.value =
          '${selectedAct.year}-${selectedAct.month}-${selectedAct.day}';
      dates.value = selectedAct;
      datatable.controller.reload();
    }
  }

  _endDates(BuildContext context) async {
    final DateTime? selectedAct = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedAct != null) {
      enddates.value =
          '${selectedAct.year}-${selectedAct.month}-${selectedAct.day}';
      datatable.controller.reload();
    }
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {}

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {}

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {}

  @override
  void onErrorRequest(Response response) {}

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    map.reset();
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
  }
}
