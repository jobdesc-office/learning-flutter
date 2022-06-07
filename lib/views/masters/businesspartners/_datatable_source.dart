import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/businesspartner_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

class BusinessPartnerDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  BusinessPartnerDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 20,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
          label: Text('BP Company'), columnName: 'userfullname', width: 180),
      CustomBsDataColumn(
          label: Text('BP Type'), columnName: 'bptypeid', width: 100),
      CustomBsDataColumn(
          label: Text('BP Email'), columnName: 'useremail', width: 240),
      CustomBsDataColumn(
          label: Text('BP Phone'), columnName: 'userphone', width: 130),
      CustomBsDataColumn(
          label: Text('Actions'),
          orderable: false,
          searchable: false,
          width: 90),
    ];
  }

  List<BusinessPartnerModel> get bpartners =>
      response.data.map((data) => BusinessPartnerModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = bpartners[index];
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
        CustomBsDataCell(Text(row.bpname),
            color: x % 2 == 0
                ? ColorPallates.datatableEvenRowColor
                : ColorPallates.datatableOddRowColor),
        CustomBsDataCell(
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     ThemeBadge(child: Text(row.bptype.typename))
            //   ],
            // ),
            Text(row.bptype.typename),
            color: x % 2 == 0
                ? ColorPallates.datatableEvenRowColor
                : ColorPallates.datatableOddRowColor),
        CustomBsDataCell(Text(row.bpemail),
            color: x % 2 == 0
                ? ColorPallates.datatableEvenRowColor
                : ColorPallates.datatableOddRowColor),
        CustomBsDataCell(Text(row.bpphone),
            color: x % 2 == 0
                ? ColorPallates.datatableEvenRowColor
                : ColorPallates.datatableOddRowColor),
        CustomBsDataCell(
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
            color: x % 2 == 0
                ? ColorPallates.datatableEvenRowColor
                : ColorPallates.datatableOddRowColor),
      ],
    );
  }
}
