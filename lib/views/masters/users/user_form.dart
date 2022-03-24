import 'package:boilerplate/models/masters/userdt_model.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/user_model.dart';
import '../../../presenters/masters/user_presenter.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';
import '_form_source.dart';
import '_text.dart';

class UserFormView extends GetView implements EditViewContract{
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final UserPresenter presenter = Get.find<UserPresenter>();
  final source = UserSource().obs;
  final Function(Map<String, dynamic> body) onSave;
  List<Widget> role = UserDetailModel().role.value;

  UserFormView({required this.onSave}) {
    presenter.userFetchDataContract = this;
  }

  late UserForm userForm;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: BsModal(
        context: context,
        dialog: BsModalDialog(
          child: BsModalContent(children: [
            BsModalContainer(
              title: Text(UserText.title),
              closeButton: true,
            ),
            BsModalContainer(
              child: Obx(() {
                userForm = UserForm(source.value);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userForm.inputName(),
                    userForm.inputPassword(),
                    userForm.inputConfirmPassword(),
                    userForm.inputFullName(),
                    userForm.inputEmail(),
                    userForm.inputPhone(),
                    userForm.btnRole(),
                    userForm.inputRole(),
                  ],
                );
              }),
            ),
            BsModalContainer(
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ThemeButtonCancel(
                      disabled: presenter.isProcessing.value,
                      margin: EdgeInsets.only(right: 5),
                      onPressed: () => onClickCancelModal(context),
                    ),
                    ThemeButtonSave(
                      disabled: presenter.isProcessing.value,
                      processing: presenter.isProcessing.value,
                      margin: EdgeInsets.only(right: 5),
                      onPressed: () => onClickSaveModal(context),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
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
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      UserModel menu = UserModel.fromJson(response.body);
      source.value.inputName.text = menu.username;
      source.value.inputPassword.text = menu.userpassword;
      source.value.inputConfirmPassword.text = menu.userpassword;
      source.value.inputFullName.text = menu.userfullname;
      source.value.inputEmail.text = menu.useremail;
      source.value.inputPhone.text = menu.userphone;
    });
  }

}