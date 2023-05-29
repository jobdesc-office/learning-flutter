part of '../report.dart';

class CalendarsTab extends StatefulWidget {
  const CalendarsTab({Key? key}) : super(key: key);

  @override
  State<CalendarsTab> createState() => _CalendarsTabState();
}

class _CalendarsTabState extends State<CalendarsTab>
    implements CalendarViewContract {
  ReportPresenter presenter = Get.find<ReportPresenter>();
  ScrollController tableScroll = ScrollController();
  List<AttendanceReport> attendanceList = [];

  DateTime _selectedDate = DateTime(2022, 10);
  int numDaysInMonth = 0;
  int currentPage = 1;
  int itemsPerPage = 10;
  int currentPageonAPI = 1;
  int start = 0;
  int end = 49;
  bool isLastPage = false;
  int? totalPages;

  @override
  void initState() {
    super.initState();
    presenter.setProcessing(true);
    presenter.calendarViewContract = this;
    presenter.calendarDatatables(
        month: _selectedDate.month, start: start, end: end);
    initNumDaysInMonth();
  }

  void initNumDaysInMonth() => numDaysInMonth =
      DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;

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
                Container(
                  // height: 290,
                  margin: EdgeInsets.only(bottom: 20, top: 20),
                  child: Row(
                    children: [
                      _generateEmployeesName(),
                      Flexible(
                        child: Scrollbar(
                          controller: tableScroll,
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
                      )
                    ],
                  ),
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
                                  print(currentPage);
                                  presenter.calendarDatatables(
                                      month: _selectedDate.month,
                                      start: start,
                                      end: end);
                                } else if (attendanceList.length > 10) {
                                  if (currentPageonAPI > 1) {
                                    currentPage--;
                                    currentPageonAPI--;
                                    _generateCheckmarks();
                                    _generateEmployeesName();
                                  } else {
                                    currentPage--;
                                    currentPageonAPI = 5;
                                    end = start;
                                    start = start -
                                        50; // 50 is data loaded per APIcall
                                    presenter.calendarDatatables(
                                        month: _selectedDate.month,
                                        start: start,
                                        end: end);
                                  }
                                }
                              } else {
                                if (currentPageonAPI == 1) {
                                  currentPage--;
                                  currentPageonAPI = 5;
                                  end = start;
                                  print(currentPage);
                                  start = start -
                                      50; // 50 is data loaded per APIcall
                                  presenter.calendarDatatables(
                                      month: _selectedDate.month,
                                      start: start,
                                      end: end);
                                } else {
                                  currentPage--;
                                  currentPageonAPI--;
                                  _generateCheckmarks();
                                  print(currentPage);
                                  _generateEmployeesName();
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
                                  end =
                                      end + 50; // 50 is data loaded per APIcall
                                  currentPageonAPI = 1;
                                  currentPage++;
                                  print(currentPage);
                                  presenter.calendarDatatables(
                                      month: _selectedDate.month,
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
                                    : ColorPallates.datatableDarkEvenRowColor,
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

    List<Widget> rows = [];

    for (var index = 0; index < paginatedList.length; index++) {
      List<String> attendanceDates = paginatedList[index].date!;
      List<Widget> cell = [];
      for (var i = 0; i < numDaysInMonth; i++) {
        bool isPresent = attendanceDates.contains(DateFormat('yyyy-MM-dd')
            .format(_selectedDate.add(Duration(days: i)))
            .toString());
        cell.add(
          Container(
            width: 40,
            height: 25,
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
            child: isPresent ? Icon(Icons.check) : SizedBox(),
          ),
        );
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
        height: 30,
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
      rows.add(Container(
          height: 25,
          width: 120,
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              boxShadow: [
                BoxShadow(
                    offset: Offset(6, 0), blurRadius: 4, color: Colors.black26)
              ],
              color: Colors.white),
          child: Text(paginatedList[index].username!)));
    }
    return Column(
      children: rows,
    );
  }

  List<Widget> _buildDateHeaders() {
    final List<Widget> dateHeaders = [];

    final DateTime firstDayOfMonth =
        DateTime(_selectedDate.year, _selectedDate.month, 1);
    final int numDaysInMonth =
        DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;

    for (int i = 0; i < numDaysInMonth; i++) {
      final DateTime currentDate = firstDayOfMonth.add(Duration(days: i));
      dateHeaders.add(
        Container(
          width: 40,
          height: 30,
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.white),
              color: ColorPallates.navbarLightColor),
          child: Text(
            currentDate.day.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return dateHeaders;
  }

  @override
  void onErrorRequest(Response response, {context}) {
    print("error");
  }

  @override
  void onLoadDatatables(Response response) {
    setState(() {
      presenter.setProcessing(false);
      attendanceList = (response.body['data'] as Map<String, dynamic>)
          .values
          .map((json) => AttendanceReport.fromJson(json))
          .toList();
      isLastPage = parseBool(response.body['isLastPage']);
      totalPages = parseInt(response.body['totalPages']);
    });
  }
}

class AttendanceReport {
  String? username;
  List<String>? date;

  AttendanceReport({this.username, this.date});

  AttendanceReport.fromJson(Map<String, dynamic> json) {
    username = json['attusername'];
    date = (json['attdate'] as Map<String, dynamic>)
        .values
        .cast<String>()
        .toList();
  }
}
