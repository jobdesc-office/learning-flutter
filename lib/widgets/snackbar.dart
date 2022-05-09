import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/color_palattes.dart';

class Snackbar {
  void createSuccess() {
    Get.snackbar('Success', 'Create Data Success',
        backgroundColor: ColorPallates.primary,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1160),
        maxWidth: 200,
        icon: Icon(
          Icons.check,
          size: 30,
        ));
  }

  void editSuccess() {
    Get.snackbar('Success', 'Edit Data Success',
        backgroundColor: ColorPallates.warning,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1160),
        maxWidth: 200,
        icon: Icon(
          Icons.edit,
          size: 30,
        ));
  }

  void deleteSuccess() {
    Get.snackbar('Success', 'Delete Data Success',
        backgroundColor: ColorPallates.danger,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1160),
        maxWidth: 200,
        icon: Icon(
          Icons.delete,
          size: 30,
        ));
  }
}
