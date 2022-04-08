import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../utils/select_api.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import 'parents.dart';

class ParentSource extends GetxController {
  var isProcessing = false.obs;
  var chosed = 0.obs;

  ParentOptionsController parentOptionsController = ParentOptionsController();

  BsSelectBoxController selectParent = BsSelectBoxController();
}

class ParentForm {
  final ParentSource source;

  ParentForm(this.source);

  Widget menuType() {
    return ParentOptions(
      controller: source.parentOptionsController,
    );
  }

  Widget selectParent() {
    return FormGroup(
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing.value,
        controller: source.selectParent,
        hintText: BaseText.hiintSelect(),
        serverSide: (params) => selectApiTypeParents(params),
      ),
    );
  }
}
