import 'package:boilerplate/widgets/theme_badge.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/masters/Product_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();

class ProductDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  ProductDataTableSource({
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
          label: Text('Product Name'), columnName: 'productname'),
      CustomBsDataColumn(
        label: Text('Product Partner'),
        columnName: 'Productnm',
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

  List<ProductModel> get Products =>
      response.data.map((data) => ProductModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = Products[index];
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
          Text(row.productname),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.bpname),
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
                onPressed: () => onEditListener(row.productid),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.productid)),
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
