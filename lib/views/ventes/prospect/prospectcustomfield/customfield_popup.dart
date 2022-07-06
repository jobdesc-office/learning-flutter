import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/ventes/customfield_contract.dart';
import '../../../../models/ventes/customfield_model.dart';
import '../../../../presenters/auth_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/customfield_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/datatables/custom_datatable.dart';
import '../../customfield/_datatable_source.dart';
import 'customfield_datatable_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class CustomFieldPopup extends GetView implements CustomFieldContract {
  final CustomFieldPresenter presenter = Get.find<CustomFieldPresenter>();
  final datatable = CustomFieldPopUpDataTableSource();
  var data = [].obs;

  CustomFieldPopup() {
    presenter.setCustomFieldContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.xl,
          child: BsModalContent(
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Color(0xfff1f1f1),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text('Available Customize Fields',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                  closeButton: true,
                ),
                BsModalContainer(
                    child: CustomDatabales(
                  // headerActions: [
                  //   ThemeButtonCreate(
                  //       prefix: ProspectText.title,
                  //       onPressed: () => presenter.add(context)),
                  // ],
                  source: datatable,
                  columns: datatable.columns,
                  serverSide: (params) => presenter.allWithBp(context, params),
                ))
              ]),
        ));
  }

  @override
  void onLoadCustomFieldSuccess(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
    datatable.onEditListener = (menuid) => presenter.edit(context, menuid);
    datatable.onDeleteListener =
        (menuid, name) => presenter.delete(context, menuid, name);
  }

  @override
  void onErrorCustomFieldRequest(Response response) {
    print(response.body);
  }
}
