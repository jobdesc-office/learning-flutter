import 'package:boilerplate/constants/base_text.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/user_model.dart';
import '../../../models/ventes/prospect_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_bsdatatable_column.dart';

class ProspectDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  ProspectDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      BsDataColumn(
        label: TextDatatableColumn('No'),
        width: 70,
        searchable: false,
        orderable: false,
      ),
      BsDataColumn(
          label: TextDatatableColumn('Prospect Title'),
          columnName: 'userfullname'),
      BsDataColumn(label: TextDatatableColumn('Prospect Customer')),
      BsDataColumn(
          label: TextDatatableColumn('Prospect Progress'),
          columnName: 'userphone'),
      BsDataColumn(
          label: TextDatatableColumn('Prospect Status'),
          orderable: false,
          searchable: false),
      BsDataColumn(
          label: TextDatatableColumn('Actions'),
          orderable: false,
          searchable: false),
    ];
  }

  List<ProspectModel> get users =>
      response.data.map((data) => ProspectModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = users[index];
    return BsDataRow(
      index: index,
      cells: [
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(Text(row.prospectname!)),
        BsDataCell(Text(row.prospectcust!.sbccstmname.toString())),
        BsDataCell(Text(row.prospectstage!.typename.toString())),
        BsDataCell(Text(row.prospectstatus!.typename.toString())),
        BsDataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonDetailsDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onDetailsListener(row.prospectid!),
              ),
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.prospectid!),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.prospectid!)),
            ],
          ),
        ),
      ],
    );
  }
}
