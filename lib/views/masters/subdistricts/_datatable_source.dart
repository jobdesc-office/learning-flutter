import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/subdistrict_model.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

class SubdistrictDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  SubdistrictDataTableSource({
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
          label: Text('Subdistrict Name'), columnName: 'Subdistrictnm'),
      CustomBsDataColumn(
          label: Text('Subdistrict City'), columnName: 'Subdistrictnm'),
      CustomBsDataColumn(
          label: Text('Actions'), orderable: false, searchable: false),
    ];
  }

  List<SubdistrictModel> get Subdistricts =>
      response.data.map((data) => SubdistrictModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = Subdistricts[index];
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
          Text(row.subdistrictname),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.cityname),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Row(
            children: [
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.subdistrictid),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.subdistrictid)),
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
