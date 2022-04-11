import 'package:boilerplate/constants/base_text.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/ventes/schedule_model.dart';
import '../../../models/masters/user_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';

class ScheduleDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  // ValueChanged<int> onEditListener = (value) {};
  // ValueChanged<int> onDeleteListener = (value) {};

  ScheduleDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      BsDataColumn(
        label: Text('No'),
        width: 70,
        searchable: false,
        orderable: false,
      ),
      BsDataColumn(
          label: Text('Schedule'), columnName: 'schedulename', width: 250),
      BsDataColumn(label: Text('PIC'), columnName: 'userfullname', width: 250),
      BsDataColumn(label: Text('Type'), columnName: 'typename', width: 150),
      BsDataColumn(
          label: Text('Business Partner'), columnName: 'bpname', width: 250),
      BsDataColumn(label: Text('Actions'), orderable: false, searchable: false),
    ];
  }

  List<ScheduleModel> get schedules =>
      response.data.map((data) => ScheduleModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = schedules[index];
    return BsDataRow(
      index: index,
      cells: [
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(Text(row.schenm)),
        BsDataCell(Text(row.userfullname)),
        BsDataCell(Text(row.typename)),
        BsDataCell(Text(row.bpname)),
        BsDataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonDetailsDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onDetailsListener(row.scheid),
              ),
              // ButtonEditDatatables(
              //   margin: EdgeInsets.only(right: 5),
              //   onPressed: () => onEditListener(row.scheid),
              // ),
              // ButtonDeleteDatatables(
              //     onPressed: () => onDeleteListener(row.scheid)),
            ],
          ),
        ),
      ],
    );
  }
}
