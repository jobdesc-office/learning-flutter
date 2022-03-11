import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

class MenuDataTableSource extends BsDatatableSource {
  MenuDataTableSource({List data = const []}) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      BsDataColumn(
        label: Text('No'),
        width: 100,
      ),
      BsDataColumn(label: Text('Name')),
      BsDataColumn(label: Text('Route')),
      BsDataColumn(label: Text('Icon')),
      BsDataColumn(label: Text('Sequence')),
      BsDataColumn(label: Text('Actions')),
    ];
  }

  @override
  BsDataRow getRow(int index) {
    return BsDataRow(index: index, cells: [
      BsDataCell(Text('No')),
      BsDataCell(Text('Nama')),
      BsDataCell(Text('Route')),
      BsDataCell(Text('Icon')),
      BsDataCell(Text('Sequence')),
      BsDataCell(Text('Actions')),
    ]);
  }
}
