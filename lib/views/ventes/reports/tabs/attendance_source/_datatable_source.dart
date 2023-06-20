import 'package:boilerplate/helpers/function.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../models/ventes/attendance_model.dart';
import '../../../../../presenters/navigation_presenter.dart';
import '../../../../../styles/color_palattes.dart';
import '../../../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();

class AttendanceDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Attendance User'),
        searchable: false,
        orderable: false,
        width: 250,
      ),
      CustomBsDataColumn(
        label: Text('Attendance Date'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
        width: 150,
      ),
      CustomBsDataColumn(
        label: Text('Attendance Clock In'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
        width: 200,
      ),
      CustomBsDataColumn(
        label: Text('Attendance Clock Out'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
        width: 200,
      ),
      CustomBsDataColumn(
        label: Text('Attendance Hours'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
        width: 200,
      ),
      CustomBsDataColumn(
        label: Text('Attendance Address'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
      ),
      // CustomBsDataColumn(
      //   label: Text('Report Type'),
      //   width: 150,
      //   searchable: false,
      //   orderable: false,
      // ),
      // CustomBsDataColumn(
      //   label: Text('Actions'),
      //   orderable: false,
      //   searchable: false,
      //   width: 100,
      // ),
    ];
  }

  List<AttendanceModel> get reports =>
      response.data.map((data) => AttendanceModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = reports[index];
    int x = controller.start + index + 1;
    String hours = '0';
    String minutes = '0';
    if (row.attduration != null) {
      List<String> atthours = row.attduration!.split(':');
      hours = atthours[0];
      minutes = atthours[1];
    }
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
          Text(row.attuser?.userfullname ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.attdate ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.attclockin ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.attclockout ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(hours + ' Jam ' + minutes + ' Menit'),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.attaddressin ?? ''),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        // CustomBsDataCell(
        //   Row(
        //     children: [
        //       Tooltip(
        //         message: BaseText.detailHintDatatable(
        //             field: row.attuser?.userfullname),
        //         child: ButtonDetailsDatatables(
        //           margin: EdgeInsets.only(right: 5),
        //           onPressed: () => onDetailsListener(row.attid!),
        //         ),
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
        //   padding: EdgeInsets.all(11),
        // ),
      ],
    );
  }
}
