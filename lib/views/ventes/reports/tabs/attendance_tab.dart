part of '../report.dart';

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
            if (show.value)
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [user(), startdate(context), enddate(context)],
                serverSide: (params) => presenter.attenddatatables(
                    context, params,
                    start: startdates.value == ''
                        ? DateTime(2000).toString()
                        : startdates.value,
                    end: enddates.value == ''
                        ? DateTime.now().toString()
                        : enddates.value,
                    userid: selectOwner.getSelectedAsString()),
              ),
          ],
        ));
  }

  var show = true.obs;
  var startdates = ''.obs;
  var enddates = ''.obs;
  var dates = DateTime.now().obs;

  BsSelectBoxController selectOwner = BsSelectBoxController();

  final _navigation = Get.find<NavigationPresenter>();
  Widget user() {
    show.value = false;
    return Obx(() => Container(
          width: 150,
          child: CustomSelectBox(
            searchable: true,
            controller: selectOwner,
            hintText: BaseText.hiintSelect(field: 'User'),
            serverSide: (params) => selectApiProspectOwner(params),
            onChange: (value) {
              show.value = true;
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
        width: 100,
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
        width: 100,
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
    }
  }

  _endDates(BuildContext context) async {
    show.value = false;
    final DateTime? selectedAct = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedAct != null) {
      enddates.value =
          '${selectedAct.year}-${selectedAct.month}-${selectedAct.day}';
      show.value = true;
    } else {
      show.value = true;
    }
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
    datatable = AttendanceDataTableSource();
    map.reset();
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
  }
}
