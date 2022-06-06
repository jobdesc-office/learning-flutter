import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/province_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_bsdatatable_column.dart';

class ProvinceDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  ProvinceDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      BsDataColumn(
        label: TextDatatableColumn('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      BsDataColumn(
          label: TextDatatableColumn('Province Name'),
          columnName: 'Provincenm'),
      BsDataColumn(
          label: TextDatatableColumn('Province Country'),
          columnName: 'Provincenm'),
      BsDataColumn(
          label: TextDatatableColumn('Actions'),
          orderable: false,
          searchable: false),
    ];
  }

  List<ProvinceModel> get provinces =>
      response.data.map((data) => ProvinceModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = provinces[index];
    return BsDataRow(
      index: index,
      cells: [
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(Text(row.provname)),
        BsDataCell(Text(row.countryname)),
        BsDataCell(
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
        ),
      ],
    );
  }
}
