// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:boilerplate/styles/color_palattes.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../helpers/function.dart';

DateTime kToday = DateTime.now();
DateTime kFirstDay = DateTime(kToday.year, kToday.month - 12, kToday.day);
DateTime kLastDay = DateTime(kToday.year, kToday.month + 12, kToday.day);

final shortWeekNames = {
  1: 'Mon',
  2: 'Tue',
  3: 'Wed',
  4: 'Thu',
  5: 'Fri',
  6: 'Sat',
  7: 'Sun'
};

typedef void OnLoadData(DateTime first, DateTime last, CalendarFormat format);

class CalendarBar {
  CalendarBar({
    required this.label,
    required this.onPressed,
    required this.style,
  });

  final String label;

  final VoidCallback onPressed;

  final CalendarBarStyle style;
}

class CalendarBarStyle {
  CalendarBarStyle({
    this.padding,
    this.color,
    this.borderRadius,
    this.textColor,
    this.fontSize,
  });

  final EdgeInsetsGeometry? padding;

  final Color? color;

  final BorderRadius? borderRadius;

  final Color? textColor;

  final double? fontSize;
}

class CustomCalendar extends StatefulWidget {
  CustomCalendar({
    Key? key,
    this.events = const {},
    this.onLoadEvent,
  }) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();

  Map<DateTime, List> events;

  final Function(DateTime focusedDate)? onLoadEvent;
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();

  OverlayEntry? _overlayDialog;

  _BarDialog? _dialog;

  Size? _size;
  Offset? _offset;

  bool get isOpen => _overlayDialog != null;

  List _events = List.empty(growable: true);

  _openDialog(BuildContext context, GlobalKey _key) {
    if (!isOpen) {
      RenderBox renderBox =
          _key.currentContext!.findRenderObject() as RenderBox;
      if (_size == null) _size = renderBox.size;
      if (_offset == null) _offset = renderBox.localToGlobal(Offset.zero);

      _dialog = _BarDialog(
        onClose: () => _closeDialog(),
        size: _size!,
        offset: _offset!,
        events: _events,
      );

      _overlayDialog = OverlayEntry(builder: (context) => _dialog!);
      Overlay.of(context)!.insert(_overlayDialog!);
    } else
      _closeDialog();
  }

  _closeDialog() {
    if (isOpen) {
      _overlayDialog!.remove();

      _size = null;
      _offset = null;
      _overlayDialog = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scrollbar(
          child: SingleChildScrollView(
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: TableCalendar(
                firstDay: kFirstDay,
                focusedDay: _focusedDay,
                lastDay: kLastDay,
                eventLoader: (DateTime day) {
                  return widget.events[
                          parseDate(dateFormat(day, format: 'Y-m-d'))] ??
                      [];
                },
                headerStyle: HeaderStyle(
                  headerMargin: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: ColorPallates.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  leftChevronIcon:
                      Icon(Icons.chevron_left, color: Colors.white),
                  rightChevronIcon:
                      Icon(Icons.chevron_right, color: Colors.white),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonDecoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                rowHeight: 52,
                daysOfWeekHeight: 16,
                calendarBuilders: CalendarBuilders(
                  outsideBuilder: (context, date, events) => _dayContainer(
                    context,
                    date,
                    outsideDay: true,
                    color: Color(0xffc7c7c7),
                  ),
                  selectedBuilder: (context, day, focusedDay) => _dayContainer(
                    context,
                    day,
                    color: Colors.white,
                    textBackground: Color(0xff00796b),
                  ),
                  todayBuilder: (context, date, events) => _dayContainer(
                    context,
                    date,
                    color: Colors.white,
                    textBackground: Color(0xff00796b).withOpacity(.5),
                  ),
                  defaultBuilder: (context, date, _) =>
                      _dayContainer(context, date),
                  dowBuilder: (context, date) {
                    Color txtColor = Colors.black;
                    if (date.weekday == 7) txtColor = Colors.red;

                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        shortWeekNames[date.weekday]!,
                        style: TextStyle(
                          color: txtColor,
                        ),
                      ),
                    );
                  },
                  markerBuilder: (context, date, events) {
                    List<Widget> children = List<Widget>.empty(growable: true);
                    GlobalKey _key = GlobalKey();

                    if (events.isNotEmpty) {
                      children.add(
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: _buildMarkers(_key, date, events),
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: children,
                    );
                  },
                ),
                onCalendarCreated: (pageController) {
                  if (widget.onLoadEvent != null)
                    widget.onLoadEvent!(DateTime.now());
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                  if (widget.onLoadEvent != null)
                    widget.onLoadEvent!(focusedDay);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dayContainer(
    BuildContext context,
    DateTime day, {
    bool outsideDay = false,
    Color color = Colors.black,
    Color textBackground = Colors.transparent,
  }) {
    if (day.weekday == 7 && !outsideDay)
      color = Colors.red;
    else if (day.weekday == 7 && outsideDay)
      color = Colors.red.withOpacity(0.3);

    return Container(
      padding: EdgeInsets.all(2),
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xfff1f1f1)),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: textBackground,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  day.day.toString(),
                  style: TextStyle(color: color, fontSize: 12),
                  textWidthBasis: TextWidthBasis.parent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMarkers(GlobalKey _key, DateTime date, List events) {
    return LayoutBuilder(
      key: _key,
      builder: (BuildContext context, BoxConstraints constraints) {
        List<Widget> _children = List<Widget>.empty(growable: true);

        double countHeight = 20;
        for (int i = 0; i < events.length; i++) {
          CalendarBar bar = events[i];

          if (countHeight < 90) {
            _children.add(Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
              child: ButtonTheme(
                padding: EdgeInsets.zero,
                height: 10.0,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    bar.onPressed();
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: bar.style.padding != null
                        ? bar.style.padding
                        : EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 5),
                    decoration: BoxDecoration(
                      color: bar.style.color,
                      borderRadius: bar.style.borderRadius != null
                          ? bar.style.borderRadius
                          : BorderRadius.circular(3),
                    ),
                    child: Text(
                      bar.label,
                      style: TextStyle(
                        color: bar.style.textColor != null
                            ? bar.style.textColor
                            : Colors.white,
                        fontSize: bar.style.fontSize != null
                            ? bar.style.fontSize
                            : 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ));
          }

          countHeight += 20;
        }

        if (_children.length != events.length) {
          _children.add(Container(
            margin: EdgeInsets.only(left: 8, right: 8, bottom: 2),
            child: ButtonTheme(
              padding: EdgeInsets.zero,
              height: 10.0,
              child: FlatButton(
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  _events = events;
                  _openDialog(context, _key);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    (events.length - _children.length).toString() + '+ more',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ));
        }

        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _children,
          ),
        );
      },
    );
  }
}

class _BarDialog extends StatefulWidget {
  _BarDialog({
    Key? key,
    required this.size,
    required this.offset,
    required this.onClose,
    // this.onSearch,
    required this.events,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BarDialogState();
  }

  final Size size;

  final Offset offset;

  final VoidCallback onClose;

  // final VoidCallback? onSearch;

  final List events;

  late Function updateState;
}

class _BarDialogState extends State<_BarDialog> {
  Size get size => widget.size;
  Offset get offset => widget.offset;

  List get events => widget.events;

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = List<Widget>.empty(growable: true);

    events.map((bar) {
      contents.add(Container(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 2),
        child: ButtonTheme(
          padding: EdgeInsets.zero,
          height: 10.0,
          child: FlatButton(
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              widget.onClose();
              bar.onPressed();
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: bar.style.padding != null
                  ? bar.style.padding
                  : EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
              decoration: BoxDecoration(
                color: bar.style.color,
                borderRadius: bar.style.borderRadius != null
                    ? bar.style.borderRadius
                    : BorderRadius.circular(3),
              ),
              child: Text(
                bar.label,
                style: TextStyle(
                    color: bar.style.textColor != null
                        ? bar.style.textColor
                        : Colors.white,
                    fontSize:
                        bar.style.fontSize != null ? bar.style.fontSize : 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ));
    }).toList();

    double height = events.length * 20.0 > 250 ? 250 : 250;

    return Stack(
      children: [
        GestureDetector(
          onTap: () => widget.onClose(),
        ),
        Positioned(
          left: offset.dx - 15,
          top: offset.dy - 15,
          width: size.width + 30,
          height: height,
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ]),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: contents,
              ),
            ),
          ),
        ),
        Positioned(
          left: offset.dx + size.width - 5,
          top: offset.dy - 10,
          child: GestureDetector(
            onTap: () => widget.onClose(),
            child: Icon(Icons.close, size: 14),
          ),
        ),
      ],
    );
  }
}
