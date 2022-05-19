import 'package:boilerplate/widgets/theme_badge.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/country_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';

class CountryDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  CountryDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      BsDataColumn(
        label: Text('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      BsDataColumn(label: Text('Country Name'), columnName: 'Countrynm'),
      BsDataColumn(label: Text('Actions'), orderable: false, searchable: false),
    ];
  }

  List<CountryModel> get countrys =>
      response.data.map((data) => CountryModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = countrys[index];
    return BsDataRow(
      index: index,
      cells: [
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(Text(row.countryname)),
        BsDataCell(
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
        ),
      ],
    );
  }
}
