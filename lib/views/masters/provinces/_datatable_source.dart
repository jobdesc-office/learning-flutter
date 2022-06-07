import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/province_model.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

class ProvinceDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  ProvinceDataTableSource({
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
      CustomBsDataColumn(
          label: Text('Province Name'), columnName: 'Provincenm'),
      CustomBsDataColumn(
          label: Text('Province Country'), columnName: 'Provincenm'),
      CustomBsDataColumn(
          label: Text('Actions'), orderable: false, searchable: false),
    ];
  }

  List<ProvinceModel> get provinces =>
      response.data.map((data) => ProvinceModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = provinces[index];
    int x = controller.start + index + 1;
    return BsDataRow(
      index: index,
      cells: [
        CustomBsDataCell(
          Text('$x'),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.provname),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.countryname),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Row(
            children: [
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.provid),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.provid)),
            ],
          ),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
      ],
    );
  }
}
