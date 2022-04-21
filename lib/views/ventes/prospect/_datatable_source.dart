import 'package:boilerplate/constants/base_text.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/user_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';

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
        label: Text('No'),
        width: 70,
        searchable: false,
        orderable: false,
      ),
      BsDataColumn(
          label: Text('Prospect Title'),
          columnName: 'userfullname',
          width: 200),
      BsDataColumn(
          label: Text('Prospect Description'),
          columnName: 'useremail',
          width: 300),
      BsDataColumn(label: Text('Prospect Progress'), columnName: 'userphone'),
      BsDataColumn(
          label: Text('Prospect Status'),
          columnName: 'isactive',
          width: 180,
          orderable: false,
          searchable: false),
      BsDataColumn(
          label: Text('Actions'),
          orderable: false,
          width: 110,
          searchable: false),
    ];
  }

  List<UserModel> get users =>
      response.data.map((data) => UserModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = users[index];
    return BsDataRow(
      index: index,
      cells: [
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(Text(row.userfullname)),
        BsDataCell(Text(row.useremail)),
        BsDataCell(Text(row.userphone)),
        BsDataCell(Card(
          color: row.isactive ? Colors.blue.shade300 : Colors.red.shade300,
          child: Center(
              child: Text(
            row.isactive ? BaseText.active : BaseText.nonactive,
          )),
        )),
        BsDataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonDetailsDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onDetailsListener(row.userid),
              ),
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.userid),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.userid)),
            ],
          ),
        ),
      ],
    );
  }
}
