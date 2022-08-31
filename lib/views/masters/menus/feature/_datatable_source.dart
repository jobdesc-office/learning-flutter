import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/security/feature_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/button/button_delete_datatable.dart';
import '../../../../widgets/button/button_details_datatable.dart';
import '../../../../widgets/button/button_edit_datatable.dart';
import '../../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();

class FeatureDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  FeatureDataTableSource({
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
      CustomBsDataColumn(label: Text('Feature Title'), columnName: 'feattitle'),
      CustomBsDataColumn(
        label: Text('Actions'),
        orderable: false,
        searchable: false,
        width: 100,
      ),
    ];
  }

  List<FeatureModel> get features =>
      response.data.map((data) => FeatureModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = features[index];
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
          Text(row.feattitle!),
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
                message: BaseText.detailHintDatatable(field: row.feattitle),
                child: ButtonDetailsDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onDetailsListener(row.featid!),
                ),
              ),
              Tooltip(
                message: BaseText.editHintDatatable(field: row.feattitle),
                child: ButtonEditDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onEditListener(row.featid!),
                ),
              ),
              Tooltip(
                message: BaseText.deleteHintDatatable(field: row.feattitle),
                child: ButtonDeleteDatatables(
                    onPressed: () =>
                        onDeleteListener(row.featid, row.feattitle)),
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
