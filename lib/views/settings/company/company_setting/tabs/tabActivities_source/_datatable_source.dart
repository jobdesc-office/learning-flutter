import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constants/base_text.dart';
import '../../../../../../models/ventes/bpcustomer_model.dart';
import '../../../../../../presenters/auth_presenter.dart';
import '../../../../../../presenters/navigation_presenter.dart';
import '../../../../../../styles/color_palattes.dart';
import '../../../../../../widgets/button/button_delete_datatable.dart';
import '../../../../../../widgets/button/button_details_datatable.dart';
import '../../../../../../widgets/button/button_edit_datatable.dart';
import '../../../../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();
final authPresenter = Get.find<AuthPresenter>();

class CustomersActivityDataTableSource extends BsDatatableSource {
  ValueChanged<int> onSetAnytime = (value) {};
  ValueChanged<int> onSetWithAttendance = (value) {};

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(label: Text('Customer Name'), columnName: 'sbccstmname'),
      CustomBsDataColumn(
        label: Text('Allow Without Attendance'),
        orderable: false,
        searchable: false,
        width: 220,
      ),
    ];
  }

  Map<int, bool> cetekanState = {};

  List<BusinessPartnerCustomerModel> get customers => response.data.map((data) => BusinessPartnerCustomerModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = customers[index];
    int x = controller.start + index + 1;
    print(cetekanState);
    if (!cetekanState.containsKey(index)) cetekanState[index] = row.sbcactivitytype?.sbttypename == "Anytime";
    // var permis = authPresenter.rolepermis.value;
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
          Text(row.sbccstmname ?? ''),
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
            children: [
              Cetekan(cetekanState[index]!, onTap: (value) {
                cetekanState[index] = value;
                if (value) {
                  onSetAnytime(row.sbcid!);
                } else {
                  onSetWithAttendance(row.sbcid!);
                }
              }),
            ],
          ),
          color: _navigation.darkTheme.value
              ? x % 2 == 0
                  ? ColorPallates.datatableDarkEvenRowColor
                  : ColorPallates.datatableDarkOddRowColor
              : x % 2 == 0
                  ? ColorPallates.datatableLightEvenRowColor
                  : ColorPallates.datatableLightOddRowColor,
          padding: EdgeInsets.all(1),
        ),
      ],
    );
  }
}

class Cetekan extends StatelessWidget {
  Function(bool)? onTap;
  Cetekan(bool value, {this.onTap}) {
    isActive = Rx(value);
  }
  late Rx<bool> isActive;
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isActive.toggle();
        onTap?.call(isActive.value);
      },
      child: Obx(() {
        return Icon(
          isActive.value ? Icons.toggle_on : Icons.toggle_off,
          size: 35,
          color: isActive.value ? ColorPallates.onDarkMode : ColorPallates.red,
        );
      }),
    );
  }
}
