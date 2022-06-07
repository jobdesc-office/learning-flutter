import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/type_model.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

class TypeParentDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  TypeParentDataTableSource({
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
      CustomBsDataColumn(label: Text('Parent Code'), columnName: 'typecd'),
      CustomBsDataColumn(label: Text('Parent Name'), columnName: 'typename'),
      CustomBsDataColumn(
          label: Text('Actions'), orderable: false, searchable: false),
    ];
  }

  List<TypeModel> get menus =>
      response.data.map((data) => TypeModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = menus[index];
    int x = controller.start + index + 1;
    return BsDataRow(
      index: index,
      cells: <BsDataCell>[
        CustomBsDataCell(
          Text('$x'),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.typecd),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.typename),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Row(
            children: [
              ButtonDetailsDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onDetailsListener(row.typeid),
              ),
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.typeid),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.typeid)),
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
