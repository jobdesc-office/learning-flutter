import 'package:boilerplate/constants/base_text.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/auth_model.dart';
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
        width: 70,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
          label: Text('Prospect Title'), columnName: 'prospectname'),
      CustomBsDataColumn(
        label: Text('Prospect Customer'),
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Prospect Progress'),
        columnName: 'userphone',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
          label: Text('Prospect Status'), orderable: false, searchable: false),
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
          Text(row.prospectname!),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.prospectcust!.sbccstmname.toString()),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.prospectstage!.typename.toString()),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.prospectstatus!.typename.toString()),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: BaseText.detailHintDatatable(field: row.prospectname),
                child: ButtonDetailsDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onDetailsListener(row.prospectid!),
                ),
              ),
              Tooltip(
                message: BaseText.editHintDatatable(field: row.prospectname),
                child: ButtonEditDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onEditListener(row.prospectid!),
                ),
              ),
              Tooltip(
                message: BaseText.deleteHintDatatable(field: row.prospectname),
                child: ButtonDeleteDatatables(
                    onPressed: () =>
                        onDeleteListener(row.prospectid!, row.prospectname)),
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
