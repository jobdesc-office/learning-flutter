import 'package:boilerplate/constants/base_text.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/ventes/customfield_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/button/button_X_datatable.dart';
import '../../../../widgets/button/button_check_datatable.dart';
import '../../../../widgets/button/button_details_datatable.dart';
import '../../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../../widgets/datatables/custom_datatable_tablehead.dart';
import '../_detail_source.dart';

final _navigation = Get.find<NavigationPresenter>();
final controllers = Get.put(ProspectDetailsSource());

class CustomFieldPopUpDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDetailsListener = (value) {};
  ValueChanged<int> onEditListener = (value) {};
  Function onDeleteListener = (value, name) {};

  CustomFieldPopUpDataTableSource({
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
      CustomBsDataColumn(
          label: Text('CustomField Name'), columnName: 'custfname'),
      CustomBsDataColumn(
        label: Text('CustomField Format'),
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(
          label: Text('Actions'),
          width: 100,
          orderable: false,
          searchable: false),
    ];
  }

  List<CustomFieldModel> get users => response.data.map((data) {
        return CustomFieldModel.fromJson(data);
      }).toList();

  @override
  BsDataRow getRow(int index) {
    // print(users.indexWhere((element) =>
    //     element.onlyinnewprospect == true &&
    //     element.lastprospectid! > controllers.prospectid.value));
    // print(users.removeAt(users.indexWhere((element) =>
    //     element.onlyinnewprospect == true &&
    //     element.lastprospectid! > controllers.prospectid.value)));
    // print(users.length);

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
          Text(row.custfname!),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
        ),
        CustomBsDataCell(
          Text(row.custftype!.typename!),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: BaseText.detailHintDatatable(field: row.custfname),
                child: ButtonDetailsDatatables(
                  margin: EdgeInsets.only(right: 5),
                  onPressed: () => onDetailsListener(row.custfid!),
                ),
              ),
              if (row.onlyinnewprospect! &&
                  row.lastprospectid! > controllers.prospectid.value)
                Tooltip(
                  message: '${row.custfname} is Not Available',
                  child: ButtonXDatatables(
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () {
                      // Get.defaultDialog(
                      //     title: '${row.custfname} is Not Available',
                      //     middleText:
                      //         'Because This Custom Field is Only for New Prospect');
                    },
                  ),
                )
              else
                Tooltip(
                  message: '${row.custfname} is Available',
                  child: ButtonCheckDatatables(
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () {},
                  ),
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
