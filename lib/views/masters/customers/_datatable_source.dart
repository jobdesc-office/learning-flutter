import 'package:boilerplate/widgets/theme_badge.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/customer_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';

class CustomerDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  CustomerDataTableSource({
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
      BsDataColumn(label: Text('Customer Name'), columnName: 'Customernm'),
      BsDataColumn(label: Text('Customer Type'), columnName: 'route'),
      BsDataColumn(label: Text('Customer Telp'), columnName: 'icon'),
      BsDataColumn(label: Text('Actions'), orderable: false, searchable: false),
    ];
  }

  List<CustomerModel> get customers =>
      response.data.map((data) => CustomerModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = customers[index];
    return BsDataRow(
      index: index,
      cells: [
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(Text(row.cstmname)),
        BsDataCell(Text(row.typename)),
        BsDataCell(Text(row.cstmphone)),
        BsDataCell(
          Row(
            children: [
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.cstmid),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.cstmid)),
            ],
          ),
        ),
      ],
    );
  }
}
