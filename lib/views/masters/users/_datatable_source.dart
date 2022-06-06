import 'package:boilerplate/constants/base_text.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/user_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_bsdatatable_column.dart';

class UserDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  UserDataTableSource({
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
          label: TextDatatableColumn('User Name'),
          columnName: 'userfullname',
          width: 300),
      BsDataColumn(
          label: TextDatatableColumn('User Email'),
          columnName: 'useremail',
          width: 250),
      BsDataColumn(
          label: TextDatatableColumn('User Phone'), columnName: 'userphone'),
      // BsDataColumn(
      //     label: Text('User Status'),
      //     columnName: 'isactive',
      //     width: 110,
      //     orderable: false,
      //     searchable: false),
      BsDataColumn(
          label: TextDatatableColumn('Actions'),
          orderable: false,
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
        // BsDataCell(Card(
        //   color: row.isactive ? Colors.blue.shade300 : Colors.red.shade300,
        //   child: Center(
        //       child: Text(
        //     row.isactive ? BaseText.active : BaseText.nonactive,
        //   )),
        // )),
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
