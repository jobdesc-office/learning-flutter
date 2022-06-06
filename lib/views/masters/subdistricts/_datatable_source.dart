import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/subdistrict_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_bsdatatable_column.dart';

class SubdistrictDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  SubdistrictDataTableSource({
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
          label: TextDatatableColumn('Subdistrict Name'),
          columnName: 'Subdistrictnm'),
      BsDataColumn(
          label: TextDatatableColumn('Subdistrict City'),
          columnName: 'Subdistrictnm'),
      BsDataColumn(
          label: TextDatatableColumn('Actions'),
          orderable: false,
          searchable: false),
    ];
  }

  List<SubdistrictModel> get Subdistricts =>
      response.data.map((data) => SubdistrictModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = Subdistricts[index];
    return BsDataRow(
      index: index,
      cells: [
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(Text(row.subdistrictname)),
        BsDataCell(Text(row.cityname)),
        BsDataCell(
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
        ),
      ],
    );
  }
}
