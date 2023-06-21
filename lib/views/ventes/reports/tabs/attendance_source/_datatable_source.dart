import 'package:boilerplate/helpers/function.dart';
import 'package:boilerplate/models/settings/file_model.dart';
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

  final BuildContext context;

  AttendanceDataTableSource(this.context);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 80,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('User'),
        searchable: false,
        orderable: false,
        width: 250,
      ),
      CustomBsDataColumn(
        label: Text('Date'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
        width: 100,
      ),
      CustomBsDataColumn(
        label: Text('Clock In'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
        width: 100,
      ),
      CustomBsDataColumn(
        label: Text('Clock Out'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
        width: 110,
      ),
      CustomBsDataColumn(
        label: Text('Duration'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
        width: 100,
      ),
      CustomBsDataColumn(
        label: Text('Address'),
        columnName: 'comptproductname',
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
        label: Text('Image'),
        width: 150,
        searchable: false,
        orderable: false,
      ),
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
  List<FileModel> get image =>
      response.data.map((data) => FileModel.fromJson(data)).toList();

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

    final img = image[index];
    String imageUrl = img.url ?? '';
    String showImageUrl = imageUrl.replaceFirst('medium-thumbnail', 'medium');
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
        CustomBsDataCell(
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                    child: Image.network(showImageUrl),
                  ),
                ),
              );
            },
            child: Image.network(imageUrl),
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
