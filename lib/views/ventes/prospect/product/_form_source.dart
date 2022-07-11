import 'package:boilerplate/services/ventes/customfield_service.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/address_model.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/auth_presenter.dart';
import '../../../../presenters/masters/customer_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../utils/select_api.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/map/_map_source.dart';
import '../../../../widgets/map/map.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class PProductSource extends GetxController {
  bool isProcessing = false;

  TextEditingController inputName = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'productname': inputName.text,
      'productbpid': authPresenter.bpActiveId.value,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class PProductForm {
  final PProductSource source;
  final map = Get.put(mapSource());
  final CustomerPresenter presenter = Get.find<CustomerPresenter>();

  PProductForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(PProductText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: PProductText.labelName),
        validators: [
          Validators.inputRequired(PProductText.labelName),
          Validators.maxLength(PProductText.labelName, 255),
        ],
      ),
    );
  }
}
