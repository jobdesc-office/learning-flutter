import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospect_detail_presenter.dart';
import '../../../../utils/select_api.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '../_chat_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();
final sources = Get.put(ChatSource());

class ChatRefSource extends GetxController {
  bool isProcessing = false;

  BsSelectBoxController selectType = BsSelectBoxController();
}

class ChatRefForm {
  final ChatRefSource source;

  ChatRefForm(this.source);

  Widget selectReport() {
    return FormGroup(
      label: Obx(() => Text(ChatRefText.labelCategory,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: ChatRefText.labelCategory),
        serverSide: (params) => selectApiChatRefType(params),
        validators: [
          Validators.selectRequired(ChatRefText.labelCategory),
        ],
        onChange: (value) {
          if (value.getOtherValue()['typename'] == 'Prospect') {
            sources.isProspect.value = true;
            sources.isActivity.value = false;
          } else {
            sources.isActivity.value = true;
            sources.isProspect.value = false;
          }
          sources.reftype.value = value.getOtherValue()['typeid'];
          print(sources.reftype.value);
        },
      ),
    );
  }

  Widget selectProspect(context) {
    return FormGroup(
      label: Obx(() => Text(ChatRefText.labelProspect,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        controller: sources.selectRef,
        hintText: BaseText.hiintSelect(field: ChatRefText.labelProspect),
        serverSide: (params) => selectApiProspect(params),
        validators: [
          Validators.selectRequired(ChatRefText.labelProspect),
        ],
        onChange: (value) {
          sources.name.value = value.getOtherValue().prospectname;
          sources.personname.value =
              value.getOtherValue().prospectcust.sbccstmname;
          sources.ref.value = value.getValue();

          sources.selectRef.clear();
          source.selectType.clear();

          Navigator.pop(context);
        },
      ),
    );
  }

  Widget selectActivity(context) {
    return FormGroup(
      label: Obx(() => Text('Activity',
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        controller: sources.selectRef,
        hintText: BaseText.hiintSelect(field: 'Activity'),
        serverSide: (params) => selectApiActivity(params),
        validators: [
          Validators.selectRequired('Activity'),
        ],
        onChange: (value) {
          sources.name.value = value.getOtherValue()['dayactdate'];
          sources.personname.value =
              value.getOtherValue()['dayactuser']['userfullname'];
          sources.ref.value = value.getValue();

          sources.selectRef.clear();
          source.selectType.clear();

          Navigator.pop(context);
        },
      ),
    );
  }
}
