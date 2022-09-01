import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/styles/theme_datatables_styles.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/navigation_presenter.dart';

typedef CustomizeHeaderDatatable = Widget Function(BsDatatableElement _);
final _navigation = Get.find<NavigationPresenter>();

class CustomDatabales extends BsDatatable {
  CustomDatabales(
      {required BsDatatableSource source,
      required List<BsDataColumn> columns,
      CustomizeHeaderDatatable? customizeLeftHeader,
      CustomizeHeaderDatatable? customizeRightHeader,
      List<Widget> headerActions = const [],
      BsDatatableServerSide? serverSide,
      String searchHintText = 'Search By Marked Column',
      bool searchable = true,
      Widget? notFoundText})
      : super(
          source: source,
          columns: columns,
          serverSide: serverSide,
          style: BsDatatableStyle(borderColor: Colors.transparent),
          notFoundText: Obx(() => Text(
                'No Data Found',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _navigation.darkTheme.value
                      ? ColorPallates.elseLightColor
                      : ColorPallates.elseDarkColor,
                ),
              )),
          customizeLayout: (el) => Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: customizeLeftHeader == null
                            ? null
                            : customizeLeftHeader(el),
                      ),
                      if (searchable)
                        Obx(() => Container(
                              child: customizeRightHeader == null
                                  ? Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Row(children: headerActions),
                                        ),
                                        el.searchForm(
                                          decoration: BoxDecoration(
                                            color: _navigation.darkTheme.value
                                                ? ColorPallates.elseDarkColor
                                                : Color(0xfff1f1f1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          inputDecoration: ThemeDatatablesStyles
                                              .searchInputDecoration(
                                                  hintText: searchHintText),
                                          builderLabel: null,
                                        ),
                                      ],
                                    )
                                  : customizeRightHeader(el),
                            ))
                      else
                        Container(
                          child: customizeRightHeader == null
                              ? Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Row(children: headerActions),
                                    ),
                                  ],
                                )
                              : customizeRightHeader(el),
                        ),
                    ],
                  ),
                ),
                Obx(() => Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: _navigation.darkTheme.value
                            ? ColorPallates.elseDarkColor
                            : ColorPallates.elseLightColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: el.table(),
                    )),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      el.informationData(),
                      el.pagination(),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
}
