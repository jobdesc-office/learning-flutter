import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/color_palattes.dart';

class Snackbar {
  void createSuccess() {
    Get.snackbar('Success', 'Create Data Success',
        backgroundColor: ColorPallates.secondary, margin: EdgeInsets.all(10));
  }

  void editSuccess() {
    Get.snackbar('Success', 'Edit Data Success',
        backgroundColor: ColorPallates.warning, margin: EdgeInsets.all(10));
  }

  void deleteSuccess() {
    Get.snackbar('Success', 'Delete Data Success',
        backgroundColor: ColorPallates.danger, margin: EdgeInsets.all(10));
  }
}
