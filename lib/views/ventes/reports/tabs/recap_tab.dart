part of '../report.dart';

class RecapTab extends StatefulWidget {
  const RecapTab({Key? key}) : super(key: key);

  @override
  State<RecapTab> createState() => _RecapTabState();
}

class _RecapTabState extends State<RecapTab> implements RecapViewContract {
  ReportPresenter presenter = Get.find<ReportPresenter>();
  ScrollController tableScroll = ScrollController();
  List<AttendanceReport> attendanceList = [];
  List<IndonesiaHoliday> holidayList = [];

  double cellHeight = 25;
  double headersHeight = 50;

  int numDaysInMonth = 0;
  int currentPage = 1;
  int itemsPerPage = 10;
  int currentPageonAPI = 1;
  int start = 0;
  int end = 49;
  bool isLastPage = false;
  int? totalPages;

  Map<String, String> typecodes = {};
  List<TypeModel> summary = List<TypeModel>.empty(growable: true);

  String startdates = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(Duration(days: 30)));
  String enddates = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    presenter.setProcessing(true);
    presenter.recapViewContract = this;

    presenter.recapDatatables(
        start: start, end: end, startdate: startdates, enddate: enddates);
    presenter.indonesiaHolidays();
  }

  BsSelectBoxController filterController = BsSelectBoxController(options: [
    for (int i = 1; i <= 12; i++)
      BsSelectBoxOption(
          value: i.toString(),
          text:
              Text(DateFormat('MMMM').format(DateTime(DateTime.now().year, i))))
  ]);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: presenter.isProcessing.value
          ? Center(child: Text("Processing attendance..."))
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    attendanceList.length != 0
                        ? exportExcel(context)
                        : Container(),
                    SizedBox(width: 30),
                    startdate(context),
                    SizedBox(width: 30),
                    enddate(context),
                  ],
                ),
                if (attendanceList.length != 0)
                  Container(
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _generateEmployeesName(),
                            Flexible(
                              child: Scrollbar(
                                controller: tableScroll,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: ScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  controller: tableScroll,
                                  child: Column(
                                    children: [
                                      Row(children: _buildDateHeaders()),
                                      _generateCheckmarks(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            _generateEmployeesSummary(),
                          ],
                        ),
                        Container(
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MouseRegion(
                                cursor: !isLastPage
                                    ? currentPage > 1
                                        ? SystemMouseCursors.click
                                        : SystemMouseCursors.basic
                                    : SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    if (currentPage > 1) {
                                      if (isLastPage) {
                                        if (attendanceList.length <= 10) {
                                          currentPage--;
                                          currentPageonAPI = 5;
                                          end = start;
                                          start = start -
                                              50; // 50 is data loaded per APIcall
                                          presenter.recapDatatables(
                                              startdate: startdates,
                                              enddate: enddates,
                                              start: start,
                                              end: end);
                                        } else if (attendanceList.length > 10) {
                                          if (currentPageonAPI > 1) {
                                            currentPage--;
                                            currentPageonAPI--;
                                            _generateCheckmarks();
                                            _generateEmployeesName();
                                            _generateEmployeesSummary();
                                          } else {
                                            currentPage--;
                                            currentPageonAPI = 5;
                                            end = start;
                                            start = start -
                                                50; // 50 is data loaded per APIcall
                                            presenter.recapDatatables(
                                                start: start,
                                                end: end,
                                                startdate: startdates,
                                                enddate: enddates);
                                          }
                                        }
                                      } else {
                                        if (currentPageonAPI == 1) {
                                          currentPage--;
                                          currentPageonAPI = 5;
                                          end = start;
                                          start = start -
                                              50; // 50 is data loaded per APIcall
                                          presenter.recapDatatables(
                                            start: start,
                                            end: end,
                                            startdate: startdates,
                                            enddate: enddates,
                                          );
                                        } else {
                                          currentPage--;
                                          currentPageonAPI--;
                                          _generateCheckmarks();
                                          _generateEmployeesName();
                                          _generateEmployeesSummary();
                                        }
                                      }
                                    }
                                  }),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: !isLastPage
                                            ? currentPage > 1
                                                ? ColorPallates.secondary
                                                : ColorPallates
                                                    .datatableDarkEvenRowColor
                                            : ColorPallates.secondary,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 8,
                                            color: Colors.black38,
                                            offset: Offset(4, 4),
                                          )
                                        ]),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Text("Page $currentPage of $totalPages"),
                              MouseRegion(
                                cursor: currentPage < totalPages!
                                    ? SystemMouseCursors.click
                                    : SystemMouseCursors.basic,
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    if (currentPage < totalPages!) {
                                      if (isLastPage) {
                                        if (currentPage % 5 != 0) {
                                          currentPage++;
                                          currentPageonAPI++;
                                        }
                                      } else if (!isLastPage) {
                                        if (currentPage % 5 != 0) {
                                          currentPageonAPI++;
                                          currentPage++;
                                        } else if (currentPage % 5 == 0) {
                                          start = end;
                                          end = end +
                                              50; // 50 is data loaded per APIcall
                                          currentPageonAPI = 1;
                                          currentPage++;
                                          presenter.recapDatatables(
                                              startdate: startdates,
                                              enddate: enddates,
                                              start: start,
                                              end: end);
                                        }
                                      }
                                    }
                                  }),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: currentPage < totalPages!
                                            ? ColorPallates.secondary
                                            : ColorPallates
                                                .datatableDarkEvenRowColor,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 8,
                                            color: Colors.black38,
                                            offset: Offset(4, 4),
                                          )
                                        ]),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                if (attendanceList.length == 0)
                  Center(
                    child: Text("No data on current start and end date"),
                  )
              ],
            ),
    );
  }

  int countTotalPage() {
    return (attendanceList.length / 10).ceil();
  }

  Widget _generateCheckmarks() {
    final subStart = (currentPageonAPI - 1) * itemsPerPage;
    final subEnd = subStart + itemsPerPage;
    final paginatedList = subEnd <= attendanceList.length
        ? attendanceList.sublist(subStart, subEnd)
        : attendanceList.sublist(subStart, attendanceList.length);

    DateTime endDate = DateTime.parse(
        DateFormat('yyyy-MM-dd').format(DateTime.parse(enddates)));

    List<Widget> rows = [];

    for (int i = 0; i < paginatedList.length; i++) {
      var entry = paginatedList[i];
      List<Map<String, dynamic>>? attendanceData = entry.attendance;
      List<Widget> cell = [];

      List<String> attendanceDates = attendanceData
              ?.map((attendance) => attendance['attdate'].toString())
              .toList() ??
          [];

      DateTime startDate = DateTime.parse(startdates);
      paginatedList[i].attsummary?[ConfigType.attalpha] = 0;

      while (isLessThanOrEqual(startDate, endDate)) {
        String currentDate =
            DateFormat('yyyy-MM-dd').format(startDate).toString();
        int weekday = startDate.weekday;
        bool isWeekend = weekday == 6 || weekday == 7;
        bool isHoliday = holidayList
            .any((element) => isDateMatch(element.date, currentDate));

        Map<String, dynamic>? attendanceEntry = attendanceData?.firstWhere(
          (attendance) => attendance['attdate'] == currentDate,
          orElse: () => {'atttype': null},
        );

        String attendanceType =
            parseString(attendanceEntry?['atttypecd'] ?? "");
        String attendanceTypeDesc =
            parseString(attendanceEntry?['atttypedesc'] ?? "");

        bool isPresent = attendanceDates.contains(currentDate);
        String attendanceDuration = attendanceEntry?['attduration'] ?? "";
        List<String> timeParts = [];
        int hours = 0;
        int minutes = 0;
        if (attendanceDuration.isNotEmpty) {
          timeParts = attendanceDuration.split(':');
          hours = int.parse(timeParts[0]);
          minutes = int.parse(timeParts[1]);
        }
        Widget child;
        if (attendanceType == ConfigType.attpresent || attendanceType == '') {
          if (isPresent) {
            child = attendanceDuration.isNotEmpty
                ? Icon(Icons.check,
                    color: hours >= 8 ? Colors.green : Colors.red)
                : Icon(Icons.check, color: Colors.black26);
          } else {
            if (!isWeekend && !isHoliday) {
              child = Text(
                "A",
                textAlign: TextAlign.center,
              );
              paginatedList[i].attsummary?[ConfigType.attalpha]++;
            } else {
              child = Container();
            }
          }
        } else {
          child = Text(
            attendanceTypeDesc,
            textAlign: TextAlign.center,
          );
        }
        cell.add(
          Tooltip(
            message: attendanceDuration.isNotEmpty
                ? hours.toString() + " Jam " + minutes.toString() + " Menit"
                : !isWeekend
                    ? isPresent
                        ? "No clock out data recorded"
                        : ""
                    : "",
            child: Container(
              width: 40,
              height: cellHeight,
              decoration: BoxDecoration(border: Border.all(width: 0.5)),
              child: child,
            ),
          ),
        );
        startDate = startDate.add(Duration(days: 1));
      }
      rows.add(Row(children: cell));
    }

    return Column(
      children: rows,
    );
  }

  Widget _generateEmployeesName() {
    final subStart = (currentPageonAPI - 1) * itemsPerPage;
    final subEnd = subStart + itemsPerPage;
    final paginatedList = subEnd <= attendanceList.length
        ? attendanceList.sublist(subStart, subEnd)
        : attendanceList.sublist(subStart, attendanceList.length);

    List<Widget> rows = [
      Container(
        width: 120,
        height: headersHeight,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: ColorPallates.navbarLightColor,
          border: Border.all(width: 0.5),
          boxShadow: [
            BoxShadow(offset: Offset(6, 0), blurRadius: 8, color: Colors.white)
          ],
        ),
        child: Text(
          "Name",
          style: TextStyle(color: Colors.white),
        ),
      )
    ];

    for (var index = 0; index < paginatedList.length; index++) {
      rows.add(
        Container(
          height: cellHeight,
          width: 120,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              boxShadow: [
                BoxShadow(
                    offset: Offset(6, 0), blurRadius: 4, color: Colors.black26)
              ],
              color: Colors.white),
          child: Column(
            children: [
              Text(
                paginatedList[index].attuser?.userfullname ?? "User name null",
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: rows,
    );
  }

  Widget _generateEmployeesSummary() {
    final subStart = (currentPageonAPI - 1) * itemsPerPage;
    final subEnd = subStart + itemsPerPage;
    final paginatedList = subEnd <= attendanceList.length
        ? attendanceList.sublist(subStart, subEnd)
        : attendanceList.sublist(subStart, attendanceList.length);

    double rowLength = 50;

    List<Widget> column = summary.map((type) {
      List<Widget> cells = [
        Container(
          width: rowLength,
          height: headersHeight / 2,
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: ColorPallates.navbarLightColor,
            border: Border.all(width: 0.5),
          ),
          child: Center(
            child: type.typecd == ConfigType.attpresent
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : Text(
                    type.typedesc.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
      ];

      for (var index = 0; index < paginatedList.length; index++) {
        int typesummary = paginatedList[index].attsummary?[type.typecd];
        cells.add(
          Container(
            height: cellHeight,
            width: rowLength,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(6, 0),
                      blurRadius: 4,
                      color: Colors.black26)
                ],
                color: Colors.white),
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: Text(typesummary.toString(), textAlign: TextAlign.center),
            ),
          ),
        );
      }

      return Column(children: cells);
    }).toList();

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(offset: Offset(-6, 0), blurRadius: 4, color: Colors.black26)
        ],
      ),
      child: Column(
        children: [
          Container(
            height: headersHeight / 2,
            width: rowLength * column.length,
            decoration: BoxDecoration(
              color: ColorPallates.navbarLightColor,
              border: Border.all(width: 0.5),
            ),
            child: Text(
              "Summary",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Row(
            children: column,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDateHeaders() {
    final List<Widget> dateHeaders = [];

    DateTime endDate = DateTime.parse(
        DateFormat('yyyy-MM-dd').format(DateTime.parse(enddates)));
    DateTime startDate = DateTime.parse(
        DateFormat('yyyy-MM-dd').format(DateTime.parse(startdates)));

    while (isLessThanOrEqual(startDate, endDate)) {
      final int weekday = startDate.weekday;
      final bool isWeekend = weekday == 6 || weekday == 7;
      String currentDate = DateFormat('yyyy-MM-dd').format(startDate);
      bool isHoliday = false;
      String holidayName = '';

      for (var element in holidayList) {
        if (isDateMatch(element.date, currentDate)) {
          isHoliday = true;
          holidayName = element.holiday!;
          break;
        }
      }

      dateHeaders.add(
        Tooltip(
          message: holidayName,
          child: Container(
            width: 40,
            height: headersHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.white),
                color: ColorPallates.navbarLightColor),
            child: Text(
              startDate.day.toString(),
              style: TextStyle(
                  color: isWeekend || isHoliday ? Colors.red : Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
      startDate = startDate.add(Duration(days: 1));
    }

    return dateHeaders;
  }

  Widget exportExcel(context) {
    return BsButton(
        margin: EdgeInsets.only(left: 5),
        style: BsButtonStyle(
            color: Colors.white,
            backgroundColor: ColorPallates.navbarLightColor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        width: 150,
        size: BsButtonSize(
            iconSize: 18.0,
            fontSize: 14.0,
            padding: EdgeInsets.fromLTRB(22, 12, 22, 12),
            spaceLabelIcon: 10.0),
        onPressed: () {
          presenter.exportExcelRecap(
              start: start, end: end, startdate: startdates, enddate: enddates);
        },
        label: Text("Export to Excel"));
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
        label: Text(startdates == '' ? 'Start Date' : startdates));
  }

  Widget enddate(context) {
    return BsButton(
        margin: EdgeInsets.only(left: 5),
        disabled: startdates == '' ? true : false,
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
        label: Text(enddates == '' ? 'End Date' : enddates));
  }

  _startDates(BuildContext context) async {
    final DateTime? selectedAct = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1, 1, 1),
      lastDate: DateTime.now(),
    );
    if (selectedAct != null) {
      setState(() {
        String selectedStartDate = DateFormat('yyyy-MM-dd').format(selectedAct);
        presenter.recapDatatables(
            start: start,
            end: end,
            startdate: selectedStartDate,
            enddate: enddates);
        startdates = selectedStartDate;
      });
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
      setState(() {
        String selectedEndDate = DateFormat('yyyy-MM-dd').format(selectedAct);
        presenter.recapDatatables(
            start: start,
            end: end,
            startdate: startdates,
            enddate: selectedEndDate);
        enddates = selectedEndDate;
      });
    }
  }

  bool isLessThanOrEqual(DateTime date1, DateTime date2) {
    return date1.isBefore(date2) || date1.isAtSameMomentAs(date2);
  }

  bool isDateMatch(DateTime? date, String? currentDate) {
    if (date != null && currentDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      return formattedDate == currentDate;
    }
    return false;
  }

  @override
  void onErrorRequest(Response response, {context}) {
    print("error");
  }

  @override
  void onLoadDatatables(Response response) {
    setState(() {
      presenter.setProcessing(false);
      attendanceList = response.body['data'].length != 0
          ? (response.body['data'] as Map<String, dynamic>)
              .values
              .map((json) => AttendanceReport.fromJson(json))
              .toList()
          : [];
      isLastPage = parseBool(response.body['isLastPage']);
      totalPages = parseInt(response.body['totalPages']);
      summary = (response.body['typecodes'] as List<dynamic>)
          .map((json) => TypeModel.fromJson(json))
          .toList();
    });
  }

  @override
  void onLoadHolidays(Response response) {
    setState(() {
      presenter.setProcessing(false);
      List<dynamic> responseItems = response.body['items'];
      responseItems.forEach((item) {
        if (item['status'] == 'confirmed') {
          holidayList.add(IndonesiaHoliday.fromJson(item));
        }
      });
    });
  }
}

class AttendanceReport {
  UserModel? attuser;
  List<Map<String, dynamic>>? attendance;
  Map<String, dynamic>? attsummary;

  AttendanceReport({this.attuser, this.attendance, this.attsummary});

  AttendanceReport.fromJson(Map<String, dynamic> json) {
    attuser =
        json['attuser'] != null ? UserModel.fromJson(json['attuser']) : null;
    attendance = (json['attendance'] as List<dynamic>)
        .map((item) => item as Map<String, dynamic>)
        .toList();
    attsummary = json['attsummary'];
  }
}

class IndonesiaHoliday {
  String? holiday;
  DateTime? date;

  IndonesiaHoliday({this.holiday, this.date});

  IndonesiaHoliday.fromJson(Map<String, dynamic> json) {
    holiday = parseString(json['summary']);
    date = DateTime.parse(json['start']['date']);
  }
}
