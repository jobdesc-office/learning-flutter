import 'package:boilerplate/views/masters/users/_text.dart';
import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/masters/userdt_model.dart';
import '../../../models/session_model.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/button/button_role_user.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';

class UserSource{
  bool isProcessing = false;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputConfirmPassword = TextEditingController();
  TextEditingController inputFullName = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPhone = TextEditingController();

  BsSelectBoxController selectRole = BsSelectBoxController();

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
    };
  }
}

class UserForm {
  final UserSource source;
  final UserDetailModel c = Get.put(UserDetailModel());

  UserForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Text(UserText.labelUsername),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(UserText.labelUsername),
          Validators.maxLength(UserText.labelUsername, 100),
        ],
      ),
    );
  }
  Widget inputPassword() {
    return FormGroup(
      label: Text(UserText.labelPassword),
      child: CustomInput(
        passwordText: true,
        disabled: source.isProcessing,
        controller: source.inputPassword,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(UserText.labelPassword),
          Validators.minLength(UserText.labelPassword, 7),
        ],
      ),
    );
  }

  Widget inputConfirmPassword() {
    return FormGroup(
      label: Text(UserText.labelConfirmPassword),
      child: CustomInput(
        passwordText: true,
        disabled: source.isProcessing,
        controller: source.inputConfirmPassword,
        hintText: BaseText.hintText(),
        validators: [
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
      label: Text(UserText.labelFullName),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputFullName,
        hintText: BaseText.hintText(),
        validators: [],
      ),
    );
  }

  Widget inputEmail() {
    return FormGroup(
      label: Text(UserText.labelEmail),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputEmail,
        hintText: BaseText.hintText(),
        validators: [
          Validators.maxLength(UserText.labelEmail, 100),
          Validators.inputEmail()
        ],
      ),
    );
  }

  Widget inputPhone() {
    return FormGroup(
      label: Text(UserText.labelPhone),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputPhone,
        hintText: BaseText.hintText(),
        validators: [
          Validators.maxLength(UserText.labelPhone, 15),
        ],
      ),
    );
  }

  Widget btnIncrease() {
    return ButtonRoleUser(
        onPressed: c.increase,
        // disabled: c.role >= 3 ? true : false,
      );
  }

  Widget btnDecrease() {
    return ButtonRoleUser2(
      margin: EdgeInsets.only(left: 10),
        onPressed: c.decrease,
        disabled: c.role > 1 ? false : true,
      );
  }
  
  Widget inputRole() {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(left: 5, top: 3),
          sizes: ColScreen(lg: Col.col_2),
          child: FormGroup(
          child: btnDecrease(),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(right: 5),
          sizes: ColScreen(lg: Col.col_5),
          child: FormGroup(
          child: CustomSelectBox(
            searchable: true,
            disabled: source.isProcessing,
            controller: source.selectRole,
            hintText: BaseText.hiintSelect(),
            serverSide: (params) => selectRole(params),
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
            controller: source.selectRole,
            hintText: BaseText.hiintSelect(),
            serverSide: (params) => selectRole(params),
          ),
          ),
        )
      ],
    );
  }

  Widget btnUp() {
    return ButtonRoleUser3(
        onPressed: c.up,
        // disabled: c.role >= 3 ? true : false,
      );
  }

  Widget btnDown() {
    return ButtonRoleUser2(
      margin: EdgeInsets.only(left: 10),
        onPressed: c.down,
        disabled: c.partner > 1 ? false : true,
      );
  }

  Widget inputPartner() {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(left: 5, top: 3),
          sizes: ColScreen(lg: Col.col_2),
          child: FormGroup(
          child: btnDown(),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(right: 5),
          sizes: ColScreen(lg: Col.col_5),
          child: FormGroup(
          child: CustomSelectBox(
            searchable: true,
            disabled: source.isProcessing,
            controller: source.selectRole,
            hintText: BaseText.hiintSelect(),
            serverSide: (params) => selectPartner(params),
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
            controller: source.selectRole,
            hintText: BaseText.hiintSelect(),
            serverSide: (params) => selectPartner(params),
          ),
          ),
        )
      ],
    );
  }
}