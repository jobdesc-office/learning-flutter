import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/navigation_presenter.dart';
import '../../styles/color_palattes.dart';

final _navigation = Get.find<NavigationPresenter>();

// ignore: must_be_immutable
class CustomBsDataColumn extends BsDataColumn {
  CustomBsDataColumn({
    Key? key,
    this.width,
    this.height = 20.0,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 15.0),
    this.textStyle,
    this.border,
    this.orderable = true,
    this.searchable = true,
    this.searchValue = '',
    this.searchRegex = 'false',
    this.columnName,
    this.columnKey,
    this.columnData,
    this.orderState = const BsOrderColumn(),
    required this.label,
  }) : super(key: key, label: label);

  final Widget label;

  final double? width;

  final double height;

  final AlignmentGeometry? alignment;

  final EdgeInsetsGeometry padding;

  final TextStyle? textStyle;

  final BoxBorder? border;

  final bool orderable;

  final bool searchable;

  final String searchValue;

  final String searchRegex;

  BsOrderColumn orderState;

  final dynamic columnKey;

  final String? columnName;

  final String? columnData;

  Widget orderIcon(BuildContext context) {
    Widget icon = Container();
    icon = Row(
      children: [
        if (orderState.ordered) Icon(Icons.search),
        Stack(
          children: [
            Positioned(
              child: Container(
                child: Icon(
                  Icons.arrow_drop_up,
                  color: (orderState.ordered &&
                              orderState.orderType == BsOrderColumn.asc
                          ? Colors.black
                          : Colors.grey)
                      .withOpacity(orderable ? 0.8 : 0),
                  size: Theme.of(context).textTheme.bodyText1!.fontSize! + 5.0,
                ),
              ),
            ),
            Positioned(
              child: Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: (orderState.ordered &&
                              orderState.orderType == BsOrderColumn.desc
                          ? Colors.black
                          : Colors.grey)
                      .withOpacity(orderable ? 0.8 : 0),
                  size: Theme.of(context).textTheme.bodyText1!.fontSize! + 5.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return icon;
  }

  // Widget searchBy(BuildContext context) {
  //   Widget icon = Container();
  //   icon = Stack(
  //     children: [
  //       if (orderState.ordered)
  //         Container(
  //           margin: EdgeInsets.only(bottom: 15.0),
  //           child: RotationTransition(
  //             turns: AlwaysStoppedAnimation(95 / 360),
  //             child: Icon(
  //               Icons.search,
  //               size: Theme.of(context).textTheme.bodyText1!.fontSize! + 9.0,
  //               color: orderState.ordered
  //                   ? ColorPallates.primary
  //                   : Colors.transparent,
  //             ),
  //             turns: AlwaysStoppedAnimation(335 / 360),
  //             child: Text(
  //               'Search By',
  //               style: TextStyle(
  //                 color: orderState.ordered
  //                     ? ColorPallates.primary
  //                     : Colors.transparent,
  //                 fontSize:
  //                     Theme.of(context).textTheme.bodyText1!.fontSize! - 4.0,
  //               ),
  //             ),
  //           ),
  //         )
  //       else
  //         Container(),
  //     ],
  //   );

  //   return icon;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Obx(() => Container(
                  color: _navigation.darkTheme.value
                      ? ColorPallates.datatableDarkTableHeadColor
                      : ColorPallates.datatableLightTableHeadColor,
                  alignment: alignment,
                  padding: padding,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: ColorPallates.datatableLightTableHeadTextColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ).merge(textStyle),
                    child: Row(
                      children: [
                        // if (searchable) searchBy(context),
                        Expanded(child: label),
                        orderIcon(context),
                      ],
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
