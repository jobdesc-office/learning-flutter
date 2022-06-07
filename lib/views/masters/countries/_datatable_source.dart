import 'package:boilerplate/widgets/theme_badge.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/country_model.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

class CountryDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  CountryDataTableSource({
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
      CustomBsDataColumn(label: Text('Country Name'), columnName: 'Countrynm'),
      CustomBsDataColumn(
          label: Text('Actions'), orderable: false, searchable: false),
    ];
  }

  List<CountryModel> get countrys =>
      response.data.map((data) => CountryModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = countrys[index];
    int x = controller.start + index + 1;
    return BsDataRow(
      index: index,
      cells: [
        CustomBsDataCell(
          Text('$x'),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.countryname),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
        CustomBsDataCell(
          Row(
            children: [
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.countryid),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.countryid)),
            ],
          ),
          color: x % 2 == 0
              ? ColorPallates.datatableEvenRowColor
              : ColorPallates.datatableOddRowColor,
        ),
      ],
    );
  }
}
