import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/masters/type_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../../widgets/datatables/custom_datatable_tablehead.dart';
import '../_permission_source.dart';

final _navigation = Get.find<NavigationPresenter>();
final _source = Get.find<PermissionSource>();

class PermissionRoleDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  PermissionRoleDataTableSource({
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
          label: Text('Permission Role'), orderable: false, searchable: false),
      CustomBsDataColumn(
          label: Text('Actions'),
          width: 100,
          orderable: false,
          searchable: false),
    ];
  }

  // ignore: invalid_use_of_protected_member
  List<TypeModel> get permissions => _source.role.value;

  @override
  BsDataRow getRow(int index) {
    final row = permissions[index];
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
          Text(row.typename ?? ''),
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
                message: '${row.typename} Permissions',
                child: BsButton(
                  size:
                      BsButtonSize(iconSize: 14, padding: EdgeInsets.all(1.5)),
                  prefixIcon: Icons.settings,
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onDeleteListener(row.typeid, row.typename),
                ),
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
