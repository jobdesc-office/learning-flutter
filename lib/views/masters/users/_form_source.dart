import 'dart:convert';

import 'package:boilerplate/views/masters/users/_text.dart';
import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/button/button_role_user.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';

final _navigation = Get.find<NavigationPresenter>();

class UserSource extends GetxController {
  var role = 1.obs;
  var partner = 1.obs;
  var isAdd = true;

  increase() {
    selectsRole.add(BsSelectBoxController());
    selectsBp.add(BsSelectBoxController());
  }

  bool isProcessing = false;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputConfirmPassword = TextEditingController();
  TextEditingController inputFullName = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPhone = TextEditingController();

  List<BsSelectBoxController> selectsRole =
      List<BsSelectBoxController>.empty(growable: true);
  List<BsSelectBoxController> selectsBp =
      List<BsSelectBoxController>.empty(growable: true);

  List<Map<String, dynamic>> jsonRoles() {
    return List<Map<String, dynamic>>.from(selectsRole.map((controller) {
      int index = selectsRole.indexOf(controller);
      return {
        'roleid': selectsRole[index].getSelectedAsString(),
        'bpid': selectsBp[index].getSelectedAsString(),
      };
    }));
  }

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'username': inputName.text,
      'userpassword': inputPassword.text,
      'userfullname': inputFullName.text,
      'useremail': inputEmail.text,
      'userphone': inputPhone.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': true,
      'roles': jsonEncode(jsonRoles())
    };
  }
}

class UserForm {
  final UserSource source;
  final UserSource c = Get.put(UserSource());

  UserForm(this.source);

  Widget formDetail({required ValueChanged<int> onRemoveItem}) {
    return FormGroup(
      child: Column(
        children: source.selectsRole.map((controller) {
          int index = source.selectsRole.indexOf(controller);
          var selectRole = source.selectsRole[index];
          var selectBp = source.selectsBp[index];
          return BsRow(
            children: [
              BsCol(
                margin: EdgeInsets.only(right: 5),
                sizes: ColScreen(lg: Col.col_5),
                child: FormGroup(
                  child: CustomSelectBox(
                    searchable: false,
                    disabled: source.isProcessing,
                    controller: selectRole,
                    hintText: BaseText.hiintSelect(
                        field: UserText.labelRole + ' ${index + 1}'),
                    serverSide: (params) => selectApiRole(params),
                  ),
                ),
              ),
              BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(lg: Col.col_5),
                child: FormGroup(
                  child: CustomSelectBox(
                    searchable: true,
                    disabled: source.isProcessing,
                    controller: selectBp,
                    hintText: BaseText.hiintSelect(
                        field: UserText.labelBp + ' ${index + 1}'),
                    serverSide: (params) => selectApiPartner(params),
                  ),
                ),
              ),
              BsCol(
                margin: EdgeInsets.only(left: 5, top: 3),
                sizes: ColScreen(lg: Col.col_2),
                child: FormGroup(
                  child: ButtonMultipleCancel(
                    margin: EdgeInsets.only(left: 10),
                    onPressed: () => onRemoveItem(index),
                    disabled: source.selectsRole.length > 1 ? false : true,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelUsername,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: UserText.labelUsername),
        validators: [
          Validators.inputRequired(UserText.labelUsername),
          Validators.maxLength(UserText.labelUsername, 50),
        ],
      ),
    );
  }

  Widget inputPassword() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelPassword,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        maxLines: 1,
        passwordText: true,
        disabled: source.isProcessing,
        controller: source.inputPassword,
        hintText: BaseText.hintText(field: UserText.labelPassword),
        validators: [
          if (c.isAdd) Validators.inputRequired(UserText.labelPassword),
          if (c.isAdd) Validators.maxLength(UserText.labelPassword, 100),
          if (c.isAdd) Validators.minLength(UserText.labelPassword, 7),
        ],
      ),
    );
  }

  Widget inputConfirmPassword() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelConfirmPassword,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        maxLines: 1,
        passwordText: true,
        disabled: source.isProcessing,
        controller: source.inputConfirmPassword,
        hintText: BaseText.hintText(field: UserText.labelConfirmPassword),
        validators: [
          if (c.isAdd)
            BsInputValidator(validator: ((value) {
              if (value != source.inputPassword.text) {
                return 'Confirm password is different';
              }
              return null;
            })),
        ],
      ),
    );
  }

  Widget inputFullName() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelFullName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputFullName,
        hintText: BaseText.hintText(field: UserText.labelFullName),
        validators: [
          Validators.maxLength(UserText.labelFullName, 100),
        ],
      ),
    );
  }

  Widget inputEmail() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelEmail,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputEmail,
        hintText: BaseText.hintText(field: UserText.labelEmail),
        validators: [
          Validators.maxLength(UserText.labelEmail, 100),
          Validators.inputEmail()
        ],
      ),
    );
  }

  Widget inputPhone() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelPhone,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputPhone,
        hintText: BaseText.hintText(field: UserText.labelPhone),
        validators: [
          Validators.maxLength(UserText.labelPhone, 15),
        ],
      ),
    );
  }
}
