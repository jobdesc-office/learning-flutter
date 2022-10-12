import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/masters/city_model.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();

final authPresenter = Get.find<AuthPresenter>();

class CityDataTableSource extends BsDatatableSource {
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
            'City Name',
          ),
          columnName: 'cityname'),
      CustomBsDataColumn(
        label: Text('City Province'),
        columnName: 'Citynm',
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

  List<CityModel> get citys =>
      response.data.map((data) => CityModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    final row = citys[index];
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
          Text(row.cityname ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.cityprov?.provname ?? ''),
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
              if (permis
                  .where((element) => element.menunm == 'Settings')
                  .first
                  .children!
                  .where((element) => element.menunm == 'Regions')
                  .first
                  .children!
                  .where((element) => element.menunm == 'Cities')
                  .first
                  .features!
                  .where((element) => element.featslug == 'update')
                  .first
                  .permissions!
                  .hasaccess!)
                Tooltip(
                  message: BaseText.editHintDatatable(field: row.cityname),
                  child: ButtonEditDatatables(
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () => onEditListener(row.cityid!),
                  ),
                ),
              if (permis
                  .where((element) => element.menunm == 'Settings')
                  .first
                  .children!
                  .where((element) => element.menunm == 'Regions')
                  .first
                  .children!
                  .where((element) => element.menunm == 'Cities')
                  .first
                  .features!
                  .where((element) => element.featslug == 'delete')
                  .first
                  .permissions!
                  .hasaccess!)
                Tooltip(
                  message: BaseText.deleteHintDatatable(field: row.cityname),
                  child: ButtonDeleteDatatables(
                      onPressed: () =>
                          onDeleteListener(row.cityid, row.cityname)),
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
