import 'package:boilerplate/constants/base_text.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/settings/stbptype_model.dart';
import '../../../../../../presenters/navigation_presenter.dart';
import '../../../../../../styles/color_palattes.dart';
import '../../../../../../widgets/button/button_X_datatable.dart';
import '../../../../../../widgets/button/button_check_datatable.dart';
import '../../../../../../widgets/button/button_delete_datatable.dart';
import '../../../../../../widgets/button/button_edit_datatable.dart';
import '../../../../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();

class ActivityCatDataTableSource extends BsDatatableSource {
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  Function onDetailsListener = (value, bool status) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  ActivityCatDataTableSource({
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
      CustomBsDataColumn(label: Text('Name'), columnName: 'sbtname'),
      CustomBsDataColumn(label: Text('Type Name'), columnName: 'sbttypename'),
      CustomBsDataColumn(label: Text('Actions'), width: 100, orderable: false, searchable: false),
    ];
  }

  List<StbptypeModel> get users => response.data.map((data) => StbptypeModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = users[index];
    int x = controller.start + index + 1;
    return BsDataRow(
      index: index,
      cells: <BsDataCell>[
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
          Text(row.sbtname ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.sbttypename ?? ''),
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
                message: BaseText.editHintDatatable(field: row.sbtname),
                child: ButtonEditDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onEditListener(row.sbtid!),
                ),
              ),
              if (row.isactive!)
                Tooltip(
                  message: BaseText.activeHintDatatable(field: row.sbtname),
                  child: ButtonCheckDatatables(
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () => onDetailsListener(row.sbtid!, row.isactive),
                  ),
                )
              else
                Tooltip(
                  message: BaseText.nonactiveHintDatatable(field: row.sbtname),
                  child: ButtonXDatatables(
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () => onDetailsListener(row.sbtid!, row.isactive),
                  ),
                ),
              Tooltip(
                message: BaseText.deleteHintDatatable(field: row.sbtname),
                child: ButtonDeleteDatatables(onPressed: () => onDeleteListener(row.sbtid, row.sbtname)),
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
