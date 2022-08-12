import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/ventes/prospect_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/button/button_delete_datatable.dart';
import '../../../../widgets/button/button_details_datatable.dart';
import '../../../../widgets/button/button_edit_datatable.dart';
import '../../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../../widgets/datatables/custom_datatable_tablehead.dart';
import '../_detail_source.dart';

final _navigation = Get.find<NavigationPresenter>();
final src = Get.put(ProspectDetailsSource());

class ProspectContactDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};
  final List<Cstmcontact> data;
  ProspectContactDataTableSource(this.data) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Contact Name'),
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Contact Type'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Contact Value'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
          label: Text('Actions'),
          width: 120,
          orderable: false,
          searchable: false),
    ];
  }

  List<Cstmcontact> get reports => this.data;

  @override
  BsDataRow getRow(int index) {
    final row = reports[index];
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
          Text(row.contacttype!.typename ?? ''),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Tooltip(
                    message:
                        BaseText.detailHintDatatable(field: row.contactname),
                    child: ButtonDetailsDatatables(
                      margin: EdgeInsets.only(right: 5),
                      onPressed: () => onDetailsListener(row.contactpersonid!),
                    ),
                  ),
                  Tooltip(
                    message: BaseText.editHintDatatable(field: row.contactname),
                    child: ButtonEditDatatables(
                      margin: EdgeInsets.only(right: 5),
                      onPressed: () => onEditListener(row.contactpersonid!),
                    ),
                  ),
                  Tooltip(
                    message:
                        BaseText.deleteHintDatatable(field: row.contactname),
                    child: ButtonDeleteDatatables(
                        onPressed: () => onDeleteListener(
                            row.contactpersonid!, row.contactname)),
                  ),
                ],
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
