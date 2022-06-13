import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presenters/navigation_presenter.dart';
import '../styles/color_palattes.dart';

final _navigation = Get.find<NavigationPresenter>();

class Snackbar {
  void createSuccess() {
    Get.snackbar('Success', 'Create Data Success',
        colorText: _navigation.darkTheme.value ? Colors.black : Colors.white,
        backgroundColor: ColorPallates.primary,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1020),
        maxWidth: 300,
        icon: Icon(
          Icons.check,
          size: 30,
          color: _navigation.darkTheme.value ? Colors.black : Colors.white,
        ));
  }

  void editSuccess() {
    Get.snackbar('Success', 'Edit Data Success',
        colorText: _navigation.darkTheme.value ? Colors.black : Colors.white,
        backgroundColor: ColorPallates.warning,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1030),
        maxWidth: 500,
        icon: Icon(
          Icons.edit,
          size: 30,
          color: _navigation.darkTheme.value ? Colors.black : Colors.white,
        ));
  }

  void deleteSuccess() {
    Get.snackbar('Success', 'Delete Data Success',
        colorText: _navigation.darkTheme.value ? Colors.black : Colors.white,
        backgroundColor: ColorPallates.danger,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1020),
        maxWidth: 300,
        icon: Icon(
          Icons.delete,
          size: 30,
          color: _navigation.darkTheme.value ? Colors.black : Colors.white,
        ));
  }

  void copySuccess() {
    Get.snackbar('Success', 'Copy Success',
        colorText: _navigation.darkTheme.value ? Colors.black : Colors.white,
        backgroundColor: ColorPallates.secondary,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1020),
        maxWidth: 200,
        icon: Icon(
          Icons.copy,
          size: 30,
          color: _navigation.darkTheme.value ? Colors.black : Colors.white,
        ));
  }

  void loginFailed() {
    Get.snackbar('Failed', 'Login Failed',
        backgroundColor: ColorPallates.danger,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1020),
        maxWidth: 200,
        icon: Icon(
          Icons.dangerous_outlined,
          size: 30,
        ));
  }

  void locationSelected() {
    Get.snackbar('Success', 'Location Selected Successfully',
        colorText: _navigation.darkTheme.value ? Colors.black : Colors.white,
        backgroundColor: ColorPallates.primary,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1020),
        maxWidth: 500,
        icon: Icon(
          Icons.check,
          size: 30,
          color: _navigation.darkTheme.value ? Colors.black : Colors.white,
        ));
  }

  void outOfRange() {
    Get.snackbar('Failed', 'Out of Range',
        backgroundColor: ColorPallates.danger,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1020),
        maxWidth: 200,
        icon: Icon(
          Icons.dangerous_outlined,
          size: 30,
        ));
  }

  void unknowLocation() {
    Get.snackbar('Warning', 'Location Selected But...',
        messageText: Text("Maybe some fields can't be filled"),
        backgroundColor: ColorPallates.danger,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1020),
        maxWidth: 200,
        icon: Icon(
          Icons.dangerous_outlined,
          size: 30,
        ));
  }
}
