import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/masters/city_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_bsdatatable_column.dart';

class CityDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  CityDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      BsDataColumn(
        label: TextDatatableColumn('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      BsDataColumn(
          label: TextDatatableColumn(
            'City Name',
          ),
          columnName: 'Citynm'),
      BsDataColumn(
          label: TextDatatableColumn('City Province'), columnName: 'Citynm'),
      BsDataColumn(
          label: TextDatatableColumn('Actions'),
          orderable: false,
          searchable: false),
    ];
  }

  List<CityModel> get citys =>
      response.data.map((data) => CityModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = citys[index];
    return BsDataRow(
      index: index,
      cells: [
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(Text(row.cityname)),
        BsDataCell(Text(row.provname)),
        BsDataCell(
          Row(
            children: [
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.cityid),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.cityid)),
            ],
          ),
        ),
      ],
    );
  }
}
