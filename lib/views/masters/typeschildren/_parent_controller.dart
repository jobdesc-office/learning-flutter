import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
