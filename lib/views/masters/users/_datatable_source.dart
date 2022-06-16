import 'package:boilerplate/constants/base_text.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/masters/user_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_details_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();

class UserDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  UserDataTableSource({
    List data = const [],
  }) : super(data: data);

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 70,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(label: Text('User Name'), columnName: 'userfullname'),
      CustomBsDataColumn(
          label: Text('User Email'), columnName: 'useremail', width: 250),
      // CustomBsDataColumn(
      //     label: Text('User Phone'), width: 150, columnName: 'userphone'),
      // CustomBsDataColumn(
      //     label: Text('User Status'),
      //     columnName: 'isactive',
      //     width: 110,
      //     orderable: false,
      //     searchable: false),
      CustomBsDataColumn(
          label: Text('Actions'),
          orderable: false,
          width: 100,
          searchable: false),
    ];
  }

  List<UserModel> get users =>
      response.data.map((data) => UserModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = users[index];
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
          Text(row.userfullname!),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.useremail!),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        // CustomBsDataCell(
        //   Text(row.userphone),
        //   color: _navigation.darkTheme.value
        //       ? x % 2 == 0
        //           ? ColorPallates.datatableDarkEvenRowColor
        //           : ColorPallates.datatableDarkOddRowColor
        //       : x % 2 == 0
        //           ? ColorPallates.datatableLightEvenRowColor
        //           : ColorPallates.datatableLightOddRowColor,
        // ),
        // CustomBsDataCell(Card(
        //   color: row.isactive ? Colors.blue.shade300 : Colors.red.shade300,
        //   child: Center(
        //       child: Text(
        //     row.isactive ? BaseText.active : BaseText.nonactive,
        //   )),
        // )),
        CustomBsDataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: BaseText.detailHintDatatable(field: row.userfullname),
                child: ButtonDetailsDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onDetailsListener(row.userid!),
                ),
              ),
              Tooltip(
                message: BaseText.editHintDatatable(field: row.userfullname),
                child: ButtonEditDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onEditListener(row.userid!),
                ),
              ),
              Tooltip(
                message: BaseText.deleteHintDatatable(field: row.userfullname),
                child: ButtonDeleteDatatables(
                    onPressed: () =>
                        onDeleteListener(row.userid, row.userfullname)),
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
