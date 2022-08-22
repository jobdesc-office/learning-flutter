import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/ventes/customfield_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();

class CompanyCurrencyDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  CompanyCurrencyDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      // CustomBsDataColumn(
      //   label: Text('No'),
      //   width: 100,
      //   searchable: false,
      //   orderable: false,
      // ),
      CustomBsDataColumn(
        label: Text('Fullname'),
        columnName: 'custfname',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Symbol'),
        columnName: 'route',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Decimal Point'),
        columnName: 'route',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Code'),
        columnName: 'route',
        searchable: false,
        orderable: false,
      ),
      // CustomBsDataColumn(label: Text('CustomField Telp'), columnName: 'icon'),
      // CustomBsDataColumn(
      //     label: Text('Actions'),
      //     width: 100,
      //     orderable: false,
      //     searchable: false),
    ];
  }

  List get customFields => [
        'data',
        'data',
        'data',
        'data',
      ];

  @override
  BsDataRow getRow(int index) {
    final row = customFields[index];
    int x = controller.start + index + 1;
    return BsDataRow(
      index: index,
      cells: [
        // CustomBsDataCell(
        //   Text('$x'),
        //   color: _navigation.darkTheme.value
        //       ? x % 2 == 0
        //           ? ColorPallates.datatableDarkEvenRowColor
        //           : ColorPallates.datatableDarkOddRowColor
        //       : x % 2 == 0
        //           ? ColorPallates.datatableLightEvenRowColor
        //           : ColorPallates.datatableLightOddRowColor,
        // ),
        CustomBsDataCell(
          Text(row),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        // CustomBsDataCell(Text(row.sbccstmphone.toString())),
        // CustomBsDataCell(
        //   Row(
        //     children: [
        //       Tooltip(
        //         message: BaseText.detailHintDatatable(field: row.custfname),
        //         child: ButtonDetailsDatatables(
        //           margin: EdgeInsets.only(right: 5),
        //           onPressed: () => onDetailsListener(row.custfid!),
        //         ),
        //       ),
        //       Tooltip(
        //         message: BaseText.editHintDatatable(field: row.custfname),
        //         child: ButtonEditDatatables(
        //           margin: EdgeInsets.only(right: 5),
        //           onPressed: () => onEditListener(row.custfid!),
        //         ),
        //       ),
        //       Tooltip(
        //         message: BaseText.deleteHintDatatable(field: row.custfname),
        //         child: ButtonDeleteDatatables(
        //             onPressed: () =>
        //                 onDeleteListener(row.custfid!, row.custfname)),
        //       ),
        //     ],
        //   ),
        //   color: _navigation.darkTheme.value
        //       ? x % 2 == 0
        //           ? ColorPallates.datatableDarkEvenRowColor
        //           : ColorPallates.datatableDarkOddRowColor
        //       : x % 2 == 0
        //           ? ColorPallates.datatableLightEvenRowColor
        //           : ColorPallates.datatableLightOddRowColor,
        //   padding: EdgeInsets.all(9),
        // ),
      ],
    );
  }
}
