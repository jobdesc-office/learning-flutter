import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/masters/contact_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();

class ContactDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  ContactDataTableSource({
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
        label: Text(
          'Contact Name',
        ),
        columnName: 'cstmname',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Contact Value'),
        columnName: 'contactvalueid',
      ),
      CustomBsDataColumn(
        label: Text('Contact Type'),
        columnName: 'Contactnm',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
          label: Text('Actions'), orderable: false, searchable: false),
    ];
  }

  List<ContactModel> get Contacts =>
      response.data.map((data) => ContactModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = Contacts[index];
    int x = controller.start + index + 1;
    return BsDataRow(
      index: index,
      cells: [
        CustomBsDataCell(
          Text('$x'),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.contactcustomer!.cstmname!),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.contactvalueid!),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.contacttype!.typename!),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Row(
            children: [
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.contactpersonid!),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.contactpersonid!)),
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
      ],
    );
  }
}
