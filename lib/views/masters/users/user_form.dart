import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/user_model.dart';
import '../../../presenters/masters/user_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_role_user.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';
import '_form_source.dart';

class UserFormView extends GetView implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final UserPresenter presenter = Get.find<UserPresenter>();
  final UserSource c = Get.put(UserSource());
  final source = UserSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  UserFormView({required this.onSave}) {
    presenter.userFetchDataContract = this;
  }

  late UserForm userForm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'User Form',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Users', back: true),
          BreadcrumbWidget('User Form', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterUser.index],
        child: Obx(() {
          userForm = UserForm(source.value);
          return Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userForm.inputName(),
                userForm.inputFullName(),
                userForm.inputPassword(),
                userForm.inputConfirmPassword(),
                userForm.inputEmail(),
                userForm.inputPhone(),
                Row(
                  children: [
                    ButtonRoleUser(
                      onPressed: onClickAddRole,
                      disabled:
                          source.value.selectsRole.length > 260 ? true : false,
                    )
                  ],
                ),
                userForm.formDetail(onRemoveItem: onClickRemoveRoleItem),
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

  void onClickAddRole() {
    source.update((val) {
      source.value.selectsRole.add(BsSelectBoxController());
      source.value.selectsBp.add(BsSelectBoxController());
    });
  }

  void onClickRemoveRoleItem(int index) {
    source.update((val) {
      source.value.selectsRole.removeAt(index);
      source.value.selectsBp.removeAt(index);
    });
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate())
      onSave(await source.toJson());
    else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    c.isAdd = true;
    Navigator.pop(context);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      UserModel menu = UserModel.fromJson(response.body);
      source.value.inputName.text = menu.username!;
      // source.value.inputPassword.text = menu.userpassword;
      // source.value.inputConfirmPassword.text = menu.userpassword;

      source.value.inputFullName.text = menu.userfullname!;
      source.value.inputEmail.text = menu.useremail!;
      source.value.inputPhone.text = menu.userphone!;
      for (var item in menu.userdetails!) {
        source.value.selectsRole.add(BsSelectBoxController(selected: [
          BsSelectBoxOption(
              value: item.usertype!.typeid,
              text: Text(item.usertype!.typename!))
        ]));
        source.value.selectsBp.add(BsSelectBoxController(selected: [
          BsSelectBoxOption(
              value: item.businesspartner!.bpid,
              text: Text(item.businesspartner!.bpname!))
        ]));
      }
    });
  }
}
