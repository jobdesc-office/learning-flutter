import 'package:boilerplate/widgets/theme_badge.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/ventes/bpcustomer_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_bsdatatable_column.dart';

class BpCustomerDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  BpCustomerDataTableSource({
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
          label: TextDatatableColumn('BpCustomer Name'),
          columnName: 'BpCustomernm'),
      BsDataColumn(
          label: TextDatatableColumn('BpCustomer Business Partner'),
          columnName: 'route'),
      // BsDataColumn(label: Text('BpCustomer Telp'), columnName: 'icon'),
      BsDataColumn(
          label: TextDatatableColumn('BpCustomer Type'), columnName: 'route'),
      BsDataColumn(
          label: TextDatatableColumn('Actions'),
          orderable: false,
          searchable: false),
    ];
  }

  List<BusinessPartnerCustomerModel> get BpCustomers => response.data
      .map((data) => BusinessPartnerCustomerModel.fromJson(data))
      .toList();

  @override
  BsDataRow getRow(int index) {
    final row = BpCustomers[index];
    return BsDataRow(
      index: index,
      cells: [
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(Text(row.sbccstmname.toString())),
        BsDataCell(Text(row.sbcbp!.bpname.toString())),
        // BsDataCell(Text(row.sbccstmphone.toString())),
        BsDataCell(Text(row.sbccstmstatus!.typename.toString())),
        BsDataCell(
          Row(
            children: [
              ButtonDetailsDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onDetailsListener(row.sbcid!),
              ),
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.sbcid!),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.sbcid!)),
            ],
          ),
        ),
      ],
    );
  }
}
