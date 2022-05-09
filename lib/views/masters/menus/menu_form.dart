import 'package:boilerplate/views/skins/tempalte.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../models/security/menu_model.dart';
import '../../../presenters/masters/menu_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';
import '_menu_type.dart';
import '_text.dart';

class MenuFormView extends StatelessWidget
    implements EditViewContract, MenuTypeViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final MenuPresenter presenter = Get.find<MenuPresenter>();
  final source = MenuSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late MenuForm menuForm;

  MenuFormView({required this.onSave}) {
    presenter.menuFetchDataContract = this;
    presenter.menuTypeViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        activeRoutes: [RouteList.master.index, RouteList.masterMenu.index],
        child: Obx(() {
          menuForm = MenuForm(source.value);
          return Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                menuForm.menuType(),
                menuForm.inputName(),
                menuForm.selectParent(),
                menuForm.inputIcon(),
                menuForm.inputRoute(),
                menuForm.inputColor(),
                menuForm.inputSequence(),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ThemeButtonSave(
                        disabled: presenter.isProcessing.value,
                        processing: presenter.isProcessing.value,
                        margin: EdgeInsets.only(right: 5),
                        onPressed: () => onClickSaveModal(context),
                      ),
                      ThemeButtonCancel(
                        disabled: presenter.isProcessing.value,
                        margin: EdgeInsets.only(right: 5),
                        onPressed: () => onClickCancelModal(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate()) onSave(await source.toJson());
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void onLoadSuccess(Response response) {
    source.update((val) {
      source.value.menuTypeController.options = List<TypeModel>.from(
        response.body.map((data) {
          return TypeModel.fromJson(data);
        }),
      );
    });
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      MenuModel menu = MenuModel.fromJson(response.body);
      source.value.menuTypeController.selected = menu.menutype;
      source.value.inputName.text = menu.menunm;
      source.value.selectParent.setSelected(
          BsSelectBoxOption(value: menu.menuid, text: Text(menu.menunm)));
      source.value.inputColor.text = menu.color;
      source.value.inputIcon.text = menu.icon;
      source.value.inputRoute.text = menu.route;
      source.value.inputSequence.text = menu.seq.toString();
    });
  }
}
