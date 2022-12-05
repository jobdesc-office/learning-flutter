import 'package:boilerplate/models/masters/security_group_model.dart';
import 'package:boilerplate/routes/route_list.dart';
import 'package:boilerplate/views/masters/securitygroup/security_group.dart';
import 'package:boilerplate/widgets/button/button_role_user.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
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

class SecurityGroupDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};
  ValueChanged<SecurityGroupModel> onShowChildren = (value) {};

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(label: Text('Group Code'), columnName: 'sgcode'),
      CustomBsDataColumn(label: Text('Group Name'), columnName: 'sgname'),
      CustomBsDataColumn(label: Text('Actions'), width: 120, orderable: false, searchable: false),
    ];
  }

  List<SecurityGroupModel> get menus => response.data.map((data) => SecurityGroupModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    final row = menus[index];
    int x = controller.start + index + 1;
    return BsDataRow(
      index: index,
      cells: <BsDataCell>[
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
          Text(row.sgcode ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.sgname ?? ''),
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
                message: '${row.sgname} children',
                child: BsButton(
                  size: BsButtonSize(iconSize: 14, padding: EdgeInsets.all(1.5)),
                  prefixIcon: Icons.arrow_right_alt,
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onShowChildren(row),
                ),
              ),
              if (permis
                  .where((element) => element.menunm == 'Settings')
                  .first
                  .children!
                  .where((element) => element.menunm == 'Types')
                  .first
                  .children!
                  .where((element) => element.menunm == 'Type Parents')
                  .first
                  .features!
                  .where((element) => element.featslug == 'update')
                  .first
                  .permissions!
                  .hasaccess!)
                Tooltip(
                  message: BaseText.detailHintDatatable(field: row.sgname),
                  child: ButtonDetailsDatatables(
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () => onDetailsListener(row.sgid!),
                  ),
                ),
              if (permis
                  .where((element) => element.menunm == 'Settings')
                  .first
                  .children!
                  .where((element) => element.menunm == 'Types')
                  .first
                  .children!
                  .where((element) => element.menunm == 'Type Parents')
                  .first
                  .features!
                  .where((element) => element.featslug == 'delete')
                  .first
                  .permissions!
                  .hasaccess!)
                Tooltip(
                  message: BaseText.editHintDatatable(field: row.sgname),
                  child: ButtonEditDatatables(
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () => onEditListener(row.sgid!),
                  ),
                ),
              Tooltip(
                message: BaseText.deleteHintDatatable(field: row.sgname),
                child: ButtonDeleteDatatables(onPressed: () => onDeleteListener(row.sgname, row.sgname)),
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
