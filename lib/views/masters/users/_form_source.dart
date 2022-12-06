import 'dart:convert';

import 'package:boilerplate/views/masters/users/_text.dart';
import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';

final _navigation = Get.find<NavigationPresenter>();

class UserSource extends GetxController {
  var id = 0.obs;

  var role = 1.obs;
  var partner = 1.obs;
  var isAdd = true;
  var isChange = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  increase() {
    selectsRole.add(BsSelectBoxController());
    selectsBp.add(BsSelectBoxController());
  }

  reset() {
    id.value = 0;

    role.value = 0;
    partner.value = 0;
    isChange.value = false;

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;

    inputName.text = '';
    inputPassword.text = '';
    inputConfirmPassword.text = '';
    inputFullName.text = '';
    inputEmail.text = '';
    inputPhone.text = '';
  }

  bool isProcessing = false;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputConfirmPassword = TextEditingController();
  TextEditingController inputFullName = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPhone = TextEditingController();

  List<BsSelectBoxController> selectsRole = List<BsSelectBoxController>.filled(1, BsSelectBoxController(), growable: true);

  BsSelectBoxController selectRole = BsSelectBoxController();
  BsSelectBoxController selectSecurityGroup = BsSelectBoxController();
  List<BsSelectBoxController> selectsBp = List<BsSelectBoxController>.empty(growable: true);

  List<Map<String, dynamic>> jsonRoles() {
    final box = GetStorage();
    return [
      {
        'roleid': selectRole.getSelectedAsString(),
        'bpid': box.read('mybpid').toString(),
      }
    ];
  }

  List<Map<String, dynamic>> jsonSecurityGroup() {
    return [
      {
        'sgid': selectSecurityGroup.getSelectedAsString(),
      }
    ];
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
      'isactive': isactive.value,
      'roles': jsonEncode(jsonRoles()),
      'securitygroups': jsonEncode(jsonSecurityGroup())
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
          // int index = source.selectsRole.indexOf(controller);
          // var selectRole = source.selectsRole[index];
          return FormGroup(
            label: Text(UserText.labelRole),
            child: CustomSelectBox(
              searchable: false,
              disabled: source.isProcessing,
              controller: source.selectRole,
              hintText: BaseText.hiintSelect(field: UserText.labelRole),
              // hintText: BaseText.hiintSelect(
              //     field: UserText.labelRole + ' ${index + 1}'),
              serverSide: (params) => selectApiRole(params),
              validators: [
                // Validators.selectRequired(UserText.labelRole + ' ${index + 1}')
                Validators.selectRequired(UserText.labelRole)
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget selectRole() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelRole, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectRole,
        hintText: BaseText.hiintSelect(field: UserText.labelRole),
        // hintText: BaseText.hiintSelect(
        //     field: UserText.labelRole + ' ${index + 1}'),
        serverSide: (params) => selectApiRole(params),
        validators: [
          // Validators.selectRequired(UserText.labelRole + ' ${index + 1}')
          Validators.selectRequired(UserText.labelRole)
        ],
      ),
    );
  }

  Widget selectSecurityGroup() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelSecurityGroup, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectSecurityGroup,
        hintText: BaseText.hiintSelect(field: UserText.labelSecurityGroup),
        // hintText: BaseText.hiintSelect(
        //     field: UserText.labelRole + ' ${index + 1}'),
        serverSide: (params) => selectApiSecurityGroup(params),
        validators: [
          // Validators.selectRequired(UserText.labelRole + ' ${index + 1}')
          Validators.selectRequired(UserText.labelSecurityGroup)
        ],
      ),
    );
  }

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelUsername, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
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
      label: Obx(() => Text(UserText.labelPassword, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: Obx(() => CustomInput(
            onChange: (value) {
              if (value != '')
                source.isChange.value = true;
              else
                source.isChange.value = false;
              {}
            },
            maxLines: 1,
            passwordText: true,
            disabled: source.isProcessing,
            controller: source.inputPassword,
            hintText: BaseText.hintText(field: UserText.labelPassword),
            validators: [
              if (c.isAdd) Validators.maxLength(UserText.labelPassword, 100),
              if (c.isAdd) Validators.minLength(UserText.labelPassword, 7),
            ],
          )),
    );
  }

  Widget inputConfirmPassword() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelConfirmPassword, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: Obx(() => CustomInput(
            maxLines: 1,
            passwordText: true,
            disabled: source.isProcessing,
            controller: source.inputConfirmPassword,
            hintText: BaseText.hintText(field: UserText.labelConfirmPassword),
            validators: [
              if (source.isChange.value)
                BsInputValidator(validator: ((value) {
                  if (value != source.inputPassword.text) {
                    return 'Confirm password is different';
                  }
                  return null;
                })),
            ],
          )),
    );
  }

  Widget inputFullName() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelFullName, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
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
      label: Obx(() => Text(UserText.labelEmail, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputEmail,
        hintText: BaseText.hintText(field: UserText.labelEmail),
        validators: [Validators.maxLength(UserText.labelEmail, 100), Validators.inputEmail()],
      ),
    );
  }

  Widget inputPhone() {
    return FormGroup(
      label: Obx(() => Text(UserText.labelPhone, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
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
