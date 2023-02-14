part of '../report.dart';

final datatable = ReportDataTableSource();

var startdates = ''.obs;
var enddates = ''.obs;
var dates = DateTime.now().obs;

BsSelectBoxController selectOwner = BsSelectBoxController();

final _navigation = Get.find<NavigationPresenter>();

class DailyActivityTab extends StatefulWidget {
  const DailyActivityTab({Key? key}) : super(key: key);

  @override
  State<DailyActivityTab> createState() => _DailyActivityTabState();
}

class _DailyActivityTabState extends State<DailyActivityTab>
    with TickerProviderStateMixin
    implements IndexViewContract {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    presenter.reportDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    List<Activities> getReportInDate(DateTime date) {
      date = DateTime(date.year, date.month, date.day);
      return source.data.where((element) {
        DateTime startDate = parseDate(element.dayactdate)!;
        bool result = date.isAtSameMomentAs(startDate);

        // if (element.scheenddate != null) {
        //   DateTime endDate = parseDate(element.scheenddate)!;
        //   result = result ||
        //       date.isAtSameMomentAs(endDate) ||
        //       (date.isAfter(startDate) && date.isBefore(endDate));
        // }
        return result;
      }).toList();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_6),
                child: Obx(() => Container(
                      child: TabBar(
                          labelColor: Colors.green,
                          controller: _tabController,
                          unselectedLabelColor: _nav.darkTheme.value
                              ? Colors.white
                              : Colors.black,
                          tabs: [
                            Tab(
                              text: 'Calendar',
                            ),
                            Tab(
                              text: 'List',
                            )
                          ]),
                    )),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: TabBarView(controller: _tabController, children: [
              Container(
                child: Obx(() => SingleChildScrollView(
                      child: Column(
                        children: [
                          if (source.done.value)
                            TableCalendar<Activities>(
                              calendarStyle: CalendarStyle(
                                  todayDecoration: BoxDecoration(
                                      color: ColorPallates.primary,
                                      shape: BoxShape.circle)),
                              rowHeight: 160,
                              daysOfWeekHeight: 24,
                              headerStyle: HeaderStyle(
                                  formatButtonVisible: false,
                                  headerMargin: EdgeInsets.only(bottom: 5),
                                  leftChevronIcon: Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                  ),
                                  rightChevronIcon: Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ),
                                  formatButtonTextStyle:
                                      TextStyle(color: Colors.white),
                                  formatButtonDecoration: BoxDecoration(
                                      border: Border.fromBorderSide(
                                          BorderSide(color: Colors.white)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0))),
                                  titleTextStyle:
                                      TextStyle(color: Colors.white),
                                  decoration: BoxDecoration(
                                      color: _nav.darkTheme.value
                                          ? ColorPallates.sidebarDarkColor
                                          : ColorPallates.primary,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              focusedDay: source.focusedDay.value,
                              firstDay: DateTime.utc(1, 1, 1),
                              lastDay: DateTime.now().add(Duration(days: 365)),
                              eventLoader: getReportInDate,
                              calendarBuilders: CalendarBuilders(
                                outsideBuilder: (context, date, events) =>
                                    source.dayContainer(
                                  context,
                                  date,
                                  outsideDay: true,
                                  color: Color.fromARGB(255, 156, 156, 156),
                                ),
                                todayBuilder: (context, date, events) =>
                                    source.dayContainer(
                                  context,
                                  date,
                                  color: Colors.white,
                                  textBackground: ColorPallates.tertiary,
                                ),
                                defaultBuilder: (context, date, _) =>
                                    source.dayContainer(context, date),
                                markerBuilder: (_, date, reports) {
                                  late List<Dayactuser> employee;
                                  for (var el in reports) {
                                    // ignore: invalid_use_of_protected_member
                                    employee = source.employees.value
                                        .where((element) =>
                                            element.userfullname !=
                                                el.dayactuser?.userfullname &&
                                            parseDate(el.dayactdate) != date)
                                        .toList();
                                    // employee = source.employees.value
                                    //     .skipWhile((value) =>
                                    //         value.userfullname !=
                                    //             el.dayactuser!.userfullname &&
                                    //         parseDate(el.dayactdate) != date)
                                    //     .toList();
                                  }

                                  // for (var item in reports)
                                  // employee.removeWhere((element) =>
                                  //     element.userfullname ==
                                  //     item.dayactuser!.userfullname)
                                  // ;

                                  return reports.isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            source.focusedDay.value = date;
                                            // source.tappedData.value = Reports;
                                            source.isTap.value = true;
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 50),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () =>
                                                      presenter.detailsDayAct(
                                                          context, reports),
                                                  child: Container(
                                                    width: 150,
                                                    height: 20,
                                                    margin: EdgeInsets.only(
                                                        bottom: 5),
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Daily Activity : ${reports.length}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () =>
                                                      presenter.detailsNoDayAct(
                                                          context, employee),
                                                  child: Container(
                                                    width: 150,
                                                    height: 20,
                                                    margin: EdgeInsets.only(
                                                        bottom: 5),
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "No Daily Activity : ${employee.length}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    presenter.detailsEmployees(
                                                        context);
                                                  },
                                                  child: Container(
                                                    width: 150,
                                                    height: 20,
                                                    margin: EdgeInsets.only(
                                                        bottom: 5),
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Employees : ${source.employeesCount.value}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      color: Colors.purple,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.snackbar(
                                                      'Sorry',
                                                      'Other is Coming Soon'),
                                                  child: Container(
                                                    width: 150,
                                                    height: 20,
                                                    margin: EdgeInsets.only(
                                                        bottom: 5),
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Other : 0",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox();
                                },
                              ),
                            )
                          else
                            Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Center(
                                child: Text('Proccessing ...'),
                              ),
                            ),
                        ],
                      ),
                    )),
              ),
              Column(
                children: [
                  CustomDatabales(
                    headerActions: [
                      user(),
                      startdate(context),
                      enddate(context),
                      reset()
                    ],
                    source: datatable,
                    columns: datatable.columns,
                    serverSide: (params) => presenter.datatabless(
                        context, params,
                        start: startdates.value == '' ? null : startdates.value,
                        end: enddates.value == '' ? null : enddates.value,
                        categoryid: selectOwner.getSelectedAsString()),
                    searchable: false,
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    map.reset();
    Snackbar().createSuccess(context!);
    Navigator.pop(context);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    source.done.value = true;
    presenter.setProcessing(false);
    map.reset();
    Snackbar().deleteSuccess(context!);
    Navigator.pop(context);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    map.reset();
    Snackbar().editSuccess(context!);
    Navigator.pop(context);
  }

  @override
  void onErrorRequest(Response response, {context}) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    map.reset();
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
  }

  Widget reset() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: BsButton(
          size: BsButtonSize.btnSm,
          style: BsButtonStyle.danger,
          label: Icon(Icons.close_rounded),
          onPressed: () {
            startdates.value = '';
            enddates.value = '';
            selectOwner.clear();
            datatable.controller.reload();
          }),
    );
  }

  Widget user() {
    return Obx(() => Container(
          width: 200,
          child: CustomSelectBox(
            searchable: true,
            controller: selectOwner,
            hintText: BaseText.hiintSelect(field: 'Category'),
            serverSide: (params) => selectApiProspectCategory(params),
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
        size: BsButtonSize(
            iconSize: 18.0,
            fontSize: 14.0,
            padding: EdgeInsets.fromLTRB(22, 12, 22, 12),
            spaceLabelIcon: 10.0),
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
        size: BsButtonSize(
            iconSize: 18.0,
            fontSize: 14.0,
            padding: EdgeInsets.fromLTRB(22, 12, 22, 12),
            spaceLabelIcon: 10.0),
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
      firstDate: DateTime(1, 1, 1),
      lastDate: DateTime.now(),
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
      firstDate: DateTime(1, 1, 1),
      lastDate: DateTime.now(),
    );
    if (selectedAct != null) {
      enddates.value =
          '${selectedAct.year}-${selectedAct.month}-${selectedAct.day}';
      datatable.controller.reload();
    }
  }
}
