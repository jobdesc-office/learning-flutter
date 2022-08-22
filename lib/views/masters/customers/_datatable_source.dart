import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/masters/customer_model.dart';
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

class CustomerDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  CustomerDataTableSource({
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
      CustomBsDataColumn(label: Text('Customer Name'), columnName: 'cstmname'),
      CustomBsDataColumn(
        label: Text('Customer Phone'),
        columnName: 'cstmphone',
      ),
      CustomBsDataColumn(
        label: Text('Actions'),
        orderable: false,
        searchable: false,
        width: 100,
      ),
    ];
  }

  List<CustomerModel> get customers =>
      response.data.map((data) => CustomerModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = customers[index];
    int x = controller.start + index + 1;
    var permis = authPresenter.rolepermis.value;
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
          Text(row.cstmname ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.cstmphone ?? ''),
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
                message: BaseText.detailHintDatatable(field: row.cstmname),
                child: ButtonDetailsDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onDetailsListener(row.cstmid!),
                ),
              ),
              if (permis
                  .where((element) => element.menu?.menunm == 'Customers')
                  .where((element) => element.feature?.feattitle == 'Update')
                  .first
                  .hasaccess!)
                Tooltip(
                  message: BaseText.editHintDatatable(field: row.cstmname),
                  child: ButtonEditDatatables(
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () => onEditListener(row.cstmid!),
                  ),
                ),
              if (permis
                  .where((element) => element.menu?.menunm == 'Customers')
                  .where((element) => element.feature?.feattitle == 'Delete')
                  .first
                  .hasaccess!)
                Tooltip(
                  message: BaseText.deleteHintDatatable(field: row.cstmname),
                  child: ButtonDeleteDatatables(
                      onPressed: () =>
                          onDeleteListener(row.cstmid, row.cstmname)),
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
