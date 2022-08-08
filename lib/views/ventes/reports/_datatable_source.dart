import 'package:boilerplate/constants/base_text.dart';
import 'package:boilerplate/helpers/function.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/ventes/report_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';
import '_report_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class ReportDetailDataTableSource extends BsDatatableSource {
  final controllers = Get.put(ReportHelper());
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  ReportDetailDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 65,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Daily Task User'),
        columnName: 'ReportDetailname',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Daily Task Type'),
        searchable: false,
        orderable: false,
      ),
    ];
  }

  List<Activities> get users => controllers.act.value;

  @override
  BsDataRow getRow(int index) {
    final row = users[index];
    int x = controller.start + index + 1;
    return BsDataRow(
      index: index,
      cells: [
        CustomBsDataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$x'),
              Text(''),
              if (_navigation.isCollapse.value) Text(''),
            ],
          ),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.dayactuser!.userfullname ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.dayactcat!.typename ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
      ],
    );
  }
}
