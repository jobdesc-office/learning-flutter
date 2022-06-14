import 'package:boilerplate/utils/select_api.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/input/custom_input_number.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../widgets/form_group.dart';

import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ProductSource {
  bool isProcessing = false;

  TextEditingController inputName = TextEditingController();

  BsSelectBoxController selectBp = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'productname': inputName.text,
      'productbpid': selectBp.getSelectedAsString(),
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class ProductForm {
  final ProductSource source;

  ProductForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(ProductText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: ProductText.labelName),
        validators: [
          Validators.inputRequired(ProductText.labelName),
          Validators.maxLength(ProductText.labelName, 255),
        ],
      ),
    );
  }

  Widget selectBp() {
    return FormGroup(
      label: Obx(() => Text(ProductText.labelBp,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectBp,
        hintText: BaseText.hiintSelect(field: ProductText.labelBp),
        serverSide: (params) => selectApiPartner(params),
        validators: [
          Validators.selectRequired(ProductText.labelBp),
        ],
      ),
    );
  }
}
