import 'package:boilerplate/constants/base_text.dart';
import 'package:boilerplate/models/masters/contact_model.dart';
import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/widgets/button/button_delete_datatable.dart';
import 'package:boilerplate/widgets/button/button_details_datatable.dart';
import 'package:boilerplate/widgets/button/button_edit_datatable.dart';
import 'package:boilerplate/widgets/datatables/custom_datatable_tablecell.dart';
import 'package:boilerplate/widgets/datatables/custom_datatable_tablehead.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../presenters/auth_presenter.dart';

final _navigation = Get.find<NavigationPresenter>();
final authPresenter = Get.find<AuthPresenter>();

class ContactDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

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
        columnName: 'contactname',
      ),
      CustomBsDataColumn(
        label: Text('Contact Value'),
        columnName: 'contactvalueid',
      ),
      CustomBsDataColumn(
        label: Text('Contact Customer'),
        columnName: 'contactvalueid',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
          label: Text('Actions'),
          width: 100,
          orderable: false,
          searchable: false),
    ];
  }

  List<ContactModel> get contacts =>
      response.data.map((data) => ContactModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    final row = contacts[index];
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
          Text(row.contactname ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.contactvalueid ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.contactcustomer?.cstmname ?? ''),
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
              Tooltip(
                message: BaseText.detailHintDatatable(field: row.contactname),
                child: ButtonDetailsDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onDetailsListener(row.contactpersonid!),
                ),
              ),
              if (permis
                  .where((element) => element.menunm == 'Settings')
                  .first
                  .children!
                  .where((element) => element.menunm == 'Company Setting')
                  .first
                  .features!
                  .where((element) => element.featslug == 'update')
                  .first
                  .permissions!
                  .hasaccess!)
                Tooltip(
                  message: BaseText.editHintDatatable(field: row.contactname),
                  child: ButtonEditDatatables(
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () => onEditListener(row.contactpersonid!),
                  ),
                ),
              if (permis
                  .where((element) => element.menunm == 'Settings')
                  .first
                  .children!
                  .where((element) => element.menunm == 'Company Setting')
                  .first
                  .features!
                  .where((element) => element.featslug == 'delete')
                  .first
                  .permissions!
                  .hasaccess!)
                Tooltip(
                  message: BaseText.deleteHintDatatable(field: row.contactname),
                  child: ButtonDeleteDatatables(
                      onPressed: () => onDeleteListener(
                          row.contactpersonid!, row.contactname!)),
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
          padding: EdgeInsets.all(9),
        ),
      ],
    );
  }
}
