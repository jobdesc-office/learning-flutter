import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/type_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';

class TypeChildrenDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  TypeChildrenDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      BsDataColumn(
        label: Text('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      BsDataColumn(label: Text('Name'), columnName: 'typename'),
      BsDataColumn(label: Text('Description'), columnName: 'typedesc'),
      BsDataColumn(label: Text('Actions'), orderable: false, searchable: false),
    ];
  }

  List<TypeModel> get menus =>
      response.data.map((data) => TypeModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = menus[index];
    return BsDataRow(
      index: index,
      cells: <BsDataCell>[
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(Text(row.typename)),
        BsDataCell(Text(row.description)),
        BsDataCell(
          Row(
            children: [
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.typeid),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.typeid)),
            ],
          ),
        ),
      ],
    );
  }
}
