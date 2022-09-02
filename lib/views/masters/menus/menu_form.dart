import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../models/security/menu_model.dart';
import '../../../presenters/masters/menu_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';
import '_menu_type.dart';

// ignore: must_be_immutable
class MenuFormView extends StatelessWidget
    implements EditViewContract, MenuTypeViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final MenuPresenter presenter = Get.find<MenuPresenter>();
  final source = MenuSource().obs;
  final Function(Map<String, dynamic> body) onSave;
  final _navigation = Get.find<NavigationPresenter>();

  late MenuForm menuForm;

  MenuFormView({required this.onSave}) {
    Get.delete<MenuSource>();
    presenter.menuFetchDataContract = this;
    presenter.menuTypeViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Menu Form',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Menus', back: true),
          BreadcrumbWidget('Menu Form', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterMenu.index],
        child: Obx(() {
          menuForm = MenuForm(source.value);
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _navigation.darkTheme.value
                  ? ColorPallates.elseDarkColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
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
                  if (source.value.isAdd.value == false) menuForm.checkbox(),
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
            ),
          );
        }),
      ),
    );
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate())
      onSave(await source.toJson());
    else
      presenter.setProcessing(false);
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
      source.value.isAdd.value = true;
      MenuModel menu = MenuModel.fromJson(response.body);
      source.value.menuTypeController.selected = menu.menutype;
      source.value.inputName.text = menu.menunm ?? '';
      source.value.selectParent.setSelected(BsSelectBoxOption(
          value: menu.parent?.menuid!, text: Text(menu.parent?.menunm ?? '')));
      source.value.inputColor.text = menu.menucolor ?? '';
      source.value.inputIcon.text = menu.menuicon ?? '';
      source.value.inputRoute.text = menu.menuroute ?? '';
      source.value.inputSequence.text = menu.menuseq.toString();
    });
  }
}
