import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/ventes/customfield_model.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();
final authPresenter = Get.find<AuthPresenter>();
// ignore: invalid_use_of_protected_member
var permis = authPresenter.rolepermis.value;

class CustomFieldDataTableSource extends BsDatatableSource {
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
          label: Text('CustomField Name'), columnName: 'custfname'),
      CustomBsDataColumn(
        label: Text('CustomField Business Partner'),
        columnName: 'route',
        searchable: false,
        orderable: false,
      ),
      // CustomBsDataColumn(label: Text('CustomField Telp'), columnName: 'icon'),
      CustomBsDataColumn(
          label: Text('Actions'),
          width: 100,
          orderable: false,
          searchable: false),
    ];
  }

  List<CustomFieldModel> get customFields =>
      response.data.map((data) => CustomFieldModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = customFields[index];
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
          Text(row.custfname.toString()),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.businesspartner!.bpname.toString()),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        // CustomBsDataCell(Text(row.sbccstmphone.toString())),
        CustomBsDataCell(
          Row(
            children: [
              Tooltip(
                message: BaseText.detailHintDatatable(field: row.custfname),
                child: ButtonDetailsDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onDetailsListener(row.custfid!),
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
                  message: BaseText.editHintDatatable(field: row.custfname),
                  child: ButtonEditDatatables(
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () => onEditListener(row.custfid!),
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
                  message: BaseText.deleteHintDatatable(field: row.custfname),
                  child: ButtonDeleteDatatables(
                      onPressed: () =>
                          onDeleteListener(row.custfid!, row.custfname)),
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
