import 'package:boilerplate/models/masters/businesspartner_model.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../presenters/auth_presenter.dart';
import '../../../../../../presenters/navigation_presenter.dart';
import '../../../../../../styles/color_palattes.dart';
import '../../../../../../widgets/datatables/custom_datatable_tablecell.dart';
import '../../../../../../widgets/datatables/custom_datatable_tablehead.dart';

final _navigation = Get.find<NavigationPresenter>();
final authPresenter = Get.find<AuthPresenter>();
// ignore: invalid_use_of_protected_member
var permis = authPresenter.rolepermis.value;

class CustomersActivityDataTableSource extends BsDatatableSource {
  ValueChanged<int> onDayActAllow = (value) {};
  ValueChanged<int> onDayActDisallow = (value) {};
  ValueChanged<int> onProsActAllow = (value) {};
  ValueChanged<int> onProsActDisallow = (value) {};

  List<BsDataColumn> get columns {
    return <BsDataColumn>[
      CustomBsDataColumn(
        label: Text('No'),
        width: 100,
        searchable: false,
        orderable: false,
      ),
      CustomBsDataColumn(label: Text('Business Partner'), columnName: 'bpname'),
      CustomBsDataColumn(
        label: Text('Allow Daily Activity Any Time'),
        orderable: false,
        searchable: false,
        width: 300,
      ),
      CustomBsDataColumn(
        label: Text('Allow Prospect Activity Any Time'),
        orderable: false,
        searchable: false,
        width: 300,
      ),
    ];
  }

  Map<int, bool> cetekanDayActState = {};
  Map<int, bool> cetekanProsActState = {};

  List<BusinessPartnerModel> get customers => response.data.map((data) => BusinessPartnerModel.fromJson(data)).toList();

  @override
  BsDataRow getRow(int index) {
    final row = customers[index];
    int x = controller.start + index + 1;
    if (!cetekanDayActState.containsKey(index)) cetekanDayActState[index] = row.bpdayactanytime ?? false;
    if (!cetekanProsActState.containsKey(index)) cetekanProsActState[index] = row.bpprosactanytime ?? false;
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
          Text(row.bpname ?? ''),
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
              Cetekan(cetekanDayActState[index]!, onTap: (value) {
                cetekanDayActState[index] = value;
                if (value) {
                  onDayActAllow(row.bpid!);
                } else {
                  onDayActDisallow(row.bpid!);
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
        CustomBsDataCell(
          Row(
            children: [
              Cetekan(cetekanProsActState[index]!, onTap: (value) {
                cetekanProsActState[index] = value;
                if (value) {
                  onProsActAllow(row.bpid!);
                } else {
                  onProsActDisallow(row.bpid!);
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

// ignore: must_be_immutable
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
