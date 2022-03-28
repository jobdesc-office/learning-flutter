import 'package:boilerplate/models/masters/userdt_model.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
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
  final UserDetailModel c = Get.put(UserDetailModel());
  final source = UserSource().obs;
  final Function(Map<String, dynamic> body) onSave;

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
          size: BsModalSize.lg,
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
                    BsRow(
                      children: [
                        BsCol(
                          margin: EdgeInsets.only(right: 5),
                          sizes: ColScreen(lg: Col.col_6),
                          child: userForm.inputName(),
                        ),
                        BsCol(
                          margin: EdgeInsets.only(left: 5),
                          sizes: ColScreen(lg: Col.col_6),
                          child: userForm.inputFullName(),
                        ),
                      ],
                    ),
                    BsRow(
                      children: [
                        BsCol(
                          margin: EdgeInsets.only(right: 5),
                          sizes: ColScreen(lg: Col.col_6),
                          child: userForm.inputPassword(),
                        ),
                        BsCol(
                          margin: EdgeInsets.only(left: 5),
                          sizes: ColScreen(lg: Col.col_6),
                          child: userForm.inputConfirmPassword(),
                        ),
                      ],
                    ),
                    BsRow(
                      children: [
                        BsCol(
                          margin: EdgeInsets.only(right: 5),
                          sizes: ColScreen(lg: Col.col_6),
                          child: userForm.inputEmail(),
                        ),
                        BsCol(
                          margin: EdgeInsets.only(left: 5),
                          sizes: ColScreen(lg: Col.col_6),
                          child: userForm.inputPhone(),
                        ),
                      ],
                    ),
                    BsRow(
                      children: [
                        BsCol(
                          sizes: ColScreen(sm: Col.col_12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Role', style: TextStyle(fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  userForm.btnIncrease(),
                                  userForm.btnDecrease()
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      itemCount: c.role.value,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return userForm.inputRole();
                    }))
                    
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