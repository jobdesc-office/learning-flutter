import 'package:boilerplate/constants/base_text.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/masters/businesspartner_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();

class BusinessPartnerDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  BusinessPartnerDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(label: Text('BP Company'), columnName: 'bpname'),
      // CustomBsDataColumn(label: Text('BP Email'), columnName: 'bpemail'),
      CustomBsDataColumn(label: Text('BP Phone'), columnName: 'bpphone'),
      CustomBsDataColumn(
        label: Text('Actions'),
        orderable: false,
        searchable: false,
        width: 100,
      ),
    ];
  }

  List<BusinessPartnerModel> get bpartners =>
      response.data.map((data) => BusinessPartnerModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = bpartners[index];
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
          Text(row.bpname),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        // CustomBsDataCell(
        //   Text(row.bpemail),
        //   color: _navigation.darkTheme.value
        //       ? x % 2 == 0
        //           ? ColorPallates.datatableDarkEvenRowColor
        //           : ColorPallates.datatableDarkOddRowColor
        //       : x % 2 == 0
        //           ? ColorPallates.datatableLightEvenRowColor
        //           : ColorPallates.datatableLightOddRowColor,
        // ),
        CustomBsDataCell(
          Text(row.bpphone),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: BaseText.detailHintDatatable(field: row.bpname),
                child: ButtonDetailsDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onDetailsListener(row.bpid),
                ),
              ),
              Tooltip(
                message: BaseText.editHintDatatable(field: row.bpname),
                child: ButtonEditDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onEditListener(row.bpid),
                ),
              ),
              Tooltip(
                message: BaseText.deleteHintDatatable(field: row.bpname),
                child: ButtonDeleteDatatables(
                    onPressed: () => onDeleteListener(row.bpid, row.bpname)),
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
          padding: EdgeInsets.all(9),
        ),
      ],
    );
  }
}
