import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/userdt_model.dart';
import '../../../presenters/masters/user_presenter.dart';
import '../../../routes/route_list.dart';
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
                      // disabled: c.role >= 3 ? true : false,
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
    Navigator.pop(context);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      UserDetailModel menu = UserDetailModel.fromJson(response.body);
      source.value.inputName.text = menu.username;
      // source.value.inputPassword.text = menu.userpassword;
      // source.value.inputConfirmPassword.text = menu.userpassword;

      source.value.selectsBp.add(BsSelectBoxController());
      source.value.selectsRole.add(BsSelectBoxController());
      source.value.selectsRole.forEach((element) {
        element.setSelected(
            BsSelectBoxOption(value: menu.typeid, text: Text(menu.typename)));
      });
      source.value.selectsBp.forEach((element) {
        element.setSelected(
            BsSelectBoxOption(value: menu.bpid, text: Text(menu.bpname)));
      });

      source.value.inputFullName.text = menu.userfullname;
      source.value.inputEmail.text = menu.useremail;
      source.value.inputPhone.text = menu.userphone;
    });
  }
}
