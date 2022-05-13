import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/styles/theme_datatables_styles.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/navigation_presenter.dart';

typedef CustomizeHeaderDatatable = Widget Function(BsDatatableElement _);
final _navigation = Get.find<NavigationPresenter>();

class CustomDatabales extends BsDatatable {
  CustomDatabales({
    required BsDatatableSource source,
    required List<BsDataColumn> columns,
    CustomizeHeaderDatatable? customizeLeftHeader,
    CustomizeHeaderDatatable? customizeRightHeader,
    List<Widget> headerActions = const [],
    BsDatatableServerSide? serverSide,
  }) : super(
          source: source,
          columns: columns,
          serverSide: serverSide,
          style: BsDatatableStyle(borderColor: ColorPallates.secondary),
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
                      Container(
                        child: customizeRightHeader == null
                            ? Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Row(children: headerActions),
                                  ),
                                  el.searchForm(
                                    decoration:
                                        ThemeDatatablesStyles.searchDecoration,
                                    inputDecoration: ThemeDatatablesStyles
                                        .searchInputDecoration,
                                    builderLabel: null,
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
