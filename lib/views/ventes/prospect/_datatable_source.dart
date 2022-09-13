import 'package:boilerplate/constants/base_text.dart';
import 'package:boilerplate/helpers/function.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/ventes/prospect_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();

class ProspectDataTableSource extends BsDatatableSource {
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  ProspectDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 65,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
          label: Text('Prospect Title'), columnName: 'prospectname'),
      CustomBsDataColumn(
        label: Text('Prospect Stage'),
        searchable: false,
        orderable: false,
        width: 180,
      ),
      CustomBsDataColumn(
        label: Text('Prospect Status'),
        searchable: false,
        orderable: false,
        width: 145,
      ),
      CustomBsDataColumn(
        label: Text('Prospect Value'),
        searchable: false,
        orderable: false,
        width: 150,
      ),
      CustomBsDataColumn(
        label: Text('Prospect Customer'),
        searchable: false,
        orderable: false,
      ),
      // CustomBsDataColumn(
      //     label: Text('Prospect Status'), orderable: false, searchable: false),
      CustomBsDataColumn(
          label: Text('Actions'),
          width: 100,
          orderable: false,
          searchable: false),
    ];
  }

  List<ProspectModel> get users =>
      response.data.map((data) => ProspectModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = users[index];
    int x = controller.start + index + 1;
    var contact;
    if (row.prospectcust!.sbccstm!.cstmcontact!.isNotEmpty) {
      if (_navigation.isCollapse.value) {
        contact = Row(
          children: [
            Text(' | '),
            Text(row.prospectcust!.sbccstm!.cstmcontact!.first.contactvalueid ??
                '-'),
          ],
        );
      } else {
        contact = Text('');
      }
    } else {
      contact = Text('');
    }
    return BsDataRow(
      index: index,
      cells: [
        CustomBsDataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$x'),
              Text(''),
              if (_navigation.isCollapse.value) Text(''),
            ],
          ),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_navigation.isCollapse.value)
                Text(row.prospectname!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))
              else
                Column(
                  children: [
                    Text(row.prospectname!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('')
                  ],
                ),
              if (_navigation.isCollapse.value)
                Text(
                  'Created at ' +
                      row.createddate! +
                      ' by\n' +
                      row.prospectby!.userfullname!,
                  style: TextStyle(fontSize: 12),
                ),
            ],
          ),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(row.prospectstage?.typename ?? ''),
              Text(''),
              if (_navigation.isCollapse.value) Text(''),
            ],
          ),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (row.prospectstatus?.typename == 'Closed Won')
                Container(
                  child: Text(
                    row.prospectstatus!.typename.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                )
              else if (row.prospectstatus?.typename == 'Closed Lost')
                Container(
                  child: Text(
                    row.prospectstatus!.typename.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                )
              else
                Text(row.prospectstatus?.typename ?? ''),
              Text(''),
              if (_navigation.isCollapse.value) Text(''),
            ],
          ),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(currencyFormatter
                  .format(parseDouble(row.prospectvalue ?? 0.0))
                  .replaceAll(',00', '')
                  .replaceAll('.', ',')),
              Text(''),
              if (_navigation.isCollapse.value) Text(''),
            ],
          ),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(row.prospectcust!.sbccstmname.toString(),
                  style: TextStyle(fontSize: 14.2)),
              Row(
                children: [
                  Text(
                    row.prospectcust!.sbccstmphone ?? '-',
                    style: TextStyle(fontSize: 13),
                  ),
                  contact
                  // Text(row.prospectcust!.sbccstmphone ?? '-',
                  //     style: TextStyle(fontSize: 13))
                ],
              ),
              if (_navigation.isCollapse.value) Text(''),
            ],
          ),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        // CustomBsDataCell(
        //   Text(row.prospectstatus!.typename.toString()),
        //   color: _navigation.darkTheme.value
        //       ? x % 2 == 0
        //           ? ColorPallates.datatableDarkEvenRowColor
        //           : ColorPallates.datatableDarkOddRowColor
        //       : x % 2 == 0
        //           ? ColorPallates.datatableLightEvenRowColor
        //           : ColorPallates.datatableLightOddRowColor,
        // ),
        CustomBsDataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Tooltip(
                    message:
                        BaseText.detailHintDatatable(field: row.prospectname),
                    child: ButtonDetailsDatatables(
                      margin: EdgeInsets.only(right: 5),
                      onPressed: () => onDetailsListener(row.prospectid!),
                    ),
                  ),
                  Tooltip(
                    message:
                        BaseText.editHintDatatable(field: row.prospectname),
                    child: ButtonEditDatatables(
                      margin: EdgeInsets.only(right: 5),
                      onPressed: () => onEditListener(row.prospectid!),
                    ),
                  ),
                  Tooltip(
                    message:
                        BaseText.deleteHintDatatable(field: row.prospectname),
                    child: ButtonDeleteDatatables(
                        onPressed: () => onDeleteListener(
                            row.prospectid!, row.prospectname)),
                  ),
                ],
              ),
              Text(''),
              if (_navigation.isCollapse.value) Text(''),
            ],
          ),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
          padding: EdgeInsets.all(9),
        ),
      ],
    );
  }
}
