import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '_parents.dart';

class TypeChildrenSource extends GetxController {
  var isProcessing = false.obs;
  var chosed = 0.obs;

  ParentOptionsController parentOptionsController = ParentOptionsController();
}

class ParentForm {
  final TypeChildrenSource source;

  ParentForm(this.source);

  Widget menuType() {
    return ParentOptions(
      controller: source.parentOptionsController,
    );
  }
}
