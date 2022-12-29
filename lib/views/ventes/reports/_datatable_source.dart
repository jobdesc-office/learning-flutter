import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/ventes/report_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();

class ReportDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Daily Activity Date'),
        searchable: false,
        orderable: false,
        width: 160,
      ),
      CustomBsDataColumn(
        label: Text('Daily Activity Category'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Daily Activity Reference'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Daily Activity Customer'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
      ),
      // CustomBsDataColumn(
      //   label: Text('Report Type'),
      //   width: 150,
      //   searchable: false,
      //   orderable: false,
      // ),
      CustomBsDataColumn(
        label: Text('Actions'),
        orderable: false,
        searchable: false,
        width: 100,
      ),
    ];
  }

  List<Activities> get reports => response.data.map((data) => Activities.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = reports[index];
    int x = controller.start + index + 1;
    return BsDataRow(
      index: index,
      cells: [
        CustomBsDataCell(
          Text('$x'),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.dayactdate ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.dayactcat?.sbttypename ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.dayactreftype != null ? row.dayactreftype!.typename! + ' - ' + row.refprospect!.prospectcode! : 'Daily Activity'),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.dayactcust?.sbccstmname ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Row(
            children: [
              Tooltip(
                message: BaseText.detailHintDatatable(field: row.dayactcat?.sbttypename),
                child: ButtonDetailsDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onDetailsListener(row.dayactid!),
                ),
              ),
            ],
          ),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
          padding: EdgeInsets.all(11),
        ),
      ],
    );
  }
}
