import 'package:Ventes/widgets/theme_badge.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

import '../../../models/security/menu_model.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';

class MenuDataTableSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (value) {};
  ValueChanged<int> onDeleteListener = (value) {};

  MenuDataTableSource({
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
      BsDataColumn(label: Text('Menu Name'), columnName: 'menunm'),
      BsDataColumn(label: Text('Menu Route'), columnName: 'route'),
      BsDataColumn(label: Text('Menu Icon'), columnName: 'icon'),
      BsDataColumn(label: Text('Menu Sequence'), columnName: 'seq'),
      BsDataColumn(label: Text('Actions'), orderable: false, searchable: false),
    ];
  }

  List<MenuModel> get menus =>
      response.data.map((data) => MenuModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = menus[index];
    return BsDataRow(
      index: index,
      cells: [
        BsDataCell(Text('${controller.start + index + 1}')),
        BsDataCell(
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ThemeBadge(child: Text(row.menutype.typename)),
              Text(row.menunm)
            ],
          ),
        ),
        BsDataCell(Text(row.route)),
        BsDataCell(Text(row.icon)),
        BsDataCell(Text(row.seq.toString())),
        BsDataCell(
          Row(
            children: [
              ButtonEditDatatables(
                margin: EdgeInsets.only(right: 5),
                onPressed: () => onEditListener(row.menuid),
              ),
              ButtonDeleteDatatables(
                  onPressed: () => onDeleteListener(row.menuid)),
            ],
          ),
        ),
      ],
    );
  }
}
