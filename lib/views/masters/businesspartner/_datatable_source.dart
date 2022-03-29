import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/businesspartner_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';

class BusinessPartnerDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  BusinessPartnerDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      BsDataColumn(
        label: Text('No'),
        width: 20,
        searchable: false,
        orderable: false,
      ),
      BsDataColumn(label: Text('Company'), columnName: 'userfullname', width: 180),
      BsDataColumn(label: Text('Type'), columnName: 'bptypeid', width: 100),
      BsDataColumn(label: Text('Email'), columnName: 'useremail',width: 240),
      BsDataColumn(label: Text('Phone'), columnName: 'userphone', width: 130),
      BsDataColumn(label: Text('Actions'), orderable: false, searchable: false, width: 90),
    ];
  }

  List<BusinessPartnerModel> get bpartners =>
      response.data.map((data) => BusinessPartnerModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = bpartners[index];
    return BsDataRow(
      index: index,
      cells: [
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(Text(row.bpname)),
        BsDataCell(
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     ThemeBadge(child: Text(row.bptype.typename))
          //   ],
          // ),
          Text(row.bptype.typename)
        ),
        BsDataCell(Text(row.bpemail)),
        BsDataCell(Text(row.bpphone)),
        BsDataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonDetailsDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onDetailsListener(row.bpid),
              ),
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.bpid),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.bpid)),
            ],
          ),
        ),
      ],
    );
  }
}