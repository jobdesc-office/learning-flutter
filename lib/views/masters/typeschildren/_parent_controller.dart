import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../helpers/function.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import 'parents.dart';

class ParentSource extends GetxController {
  var isProcessing = false.obs;
  var chosed = 0.obs;

  ParentOptionsController parentOptionsController = ParentOptionsController();
}

class ParentForm {
  final ParentSource source;

  ParentForm(this.source);

  Widget menuType() {
    return ParentOptions(
      controller: source.parentOptionsController,
    );
  }
}
