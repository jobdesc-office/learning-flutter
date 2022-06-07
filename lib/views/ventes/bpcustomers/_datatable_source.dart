import 'package:boilerplate/widgets/theme_badge.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/ventes/bpcustomer_model.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

class BpCustomerDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  BpCustomerDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
          label: Text('BpCustomer Name'), columnName: 'BpCustomernm'),
      CustomBsDataColumn(
          label: Text('BpCustomer Business Partner'), columnName: 'route'),
      // CustomBsDataColumn(label: Text('BpCustomer Telp'), columnName: 'icon'),
      CustomBsDataColumn(label: Text('BpCustomer Type'), columnName: 'route'),
      CustomBsDataColumn(
          label: Text('Actions'), orderable: false, searchable: false),
    ];
  }

  List<BusinessPartnerCustomerModel> get BpCustomers => response.data
      .map((data) => BusinessPartnerCustomerModel.fromJson(data))
      .toList();

  @override
  BsDataRow getRow(int index) {
    final row = BpCustomers[index];
    int x = controller.start + index + 1;
    return BsDataRow(
      index: index,
      cells: [
        CustomBsDataCell(
          Text('$x'),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.sbccstmname.toString()),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.sbcbp!.bpname.toString()),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        // CustomBsDataCell(Text(row.sbccstmphone.toString())),
        CustomBsDataCell(
          Text(row.sbccstmstatus!.typename.toString()),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
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
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
      ],
    );
  }
}
