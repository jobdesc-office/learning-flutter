import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presenters/navigation_presenter.dart';
import '../styles/color_palattes.dart';

final _navigation = Get.find<NavigationPresenter>();

class Snackbar {
  void createSuccess(BuildContext context) {
    Get.snackbar('Success', 'Create Data Success',
        colorText: _navigation.darkTheme.value ? Colors.black : Colors.white,
        backgroundColor: ColorPallates.primary,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.005,
            right: 10,
            left: MediaQuery.of(context).size.width * 0.85),
        maxWidth: 300,
        icon: Icon(
          Icons.check,
          size: 30,
          color: _navigation.darkTheme.value ? Colors.black : Colors.white,
        ));
  }

  void createFailed(BuildContext context, String response) {
    Get.snackbar('Failed', response,
        colorText: _navigation.darkTheme.value ? Colors.black : Colors.white,
        backgroundColor: ColorPallates.danger,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.005,
            right: 10,
            left: MediaQuery.of(context).size.width * 1),
        maxWidth: 300,
        icon: Icon(
          Icons.dangerous_outlined,
          size: 30,
          color: _navigation.darkTheme.value ? Colors.black : Colors.white,
        ));
  }

  void editSuccess(BuildContext context) {
    Get.snackbar('Success', 'Edit Data Success',
        colorText: _navigation.darkTheme.value ? Colors.black : Colors.white,
        backgroundColor: ColorPallates.warning,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.005,
            right: 10,
            left: MediaQuery.of(context).size.width * 0.85),
        maxWidth: 500,
        icon: Icon(
          Icons.edit,
          size: 30,
          color: _navigation.darkTheme.value ? Colors.black : Colors.white,
        ));
  }

  void failed(BuildContext context, [String message = "Failed"]) {
    Get.dialog(
      Dialog(
        child: Container(
          width: Get.width * 0.25,
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Failed",
                style: TextStyle(
                  color: ColorPallates.warning,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => Get.close(1),
                child: Text("Close"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  minimumSize: Size.fromHeight(45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteSuccess(BuildContext context) {
    Get.snackbar('Success', 'Delete Data Success',
        colorText: _navigation.darkTheme.value ? Colors.black : Colors.white,
        backgroundColor: ColorPallates.danger,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.005,
            right: 10,
            left: MediaQuery.of(context).size.width * 0.85),
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
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1170),
        maxWidth: 200,
        icon: Icon(
          Icons.copy,
          size: 30,
          color: _navigation.darkTheme.value ? Colors.black : Colors.white,
        ));
  }

  void sessionExpired() {
    Get.snackbar('Warning', 'Session Expired',
        backgroundColor: ColorPallates.danger,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1160),
        maxWidth: 200,
        icon: Icon(
          Icons.warning,
          size: 30,
        ));
  }

  void loginFailed() {
    Get.snackbar('Failed', 'Login Failed',
        backgroundColor: ColorPallates.danger,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1170),
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
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1100),
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
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1170),
        maxWidth: 200,
        icon: Icon(
          Icons.dangerous_outlined,
          size: 30,
        ));
  }

  void unknowLocation() {
    Get.snackbar('Warning', 'Location Selected But...',
        messageText: Text("Maybe some fields can't be Automatically filled"),
        backgroundColor: ColorPallates.danger,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1050),
        maxWidth: 250,
        icon: Icon(
          Icons.dangerous_outlined,
          size: 30,
        ));
  }

  void resetSuccess() {
    Get.snackbar('Success', 'Reset Device Success',
        colorText: _navigation.darkTheme.value ? Colors.black : Colors.white,
        backgroundColor: ColorPallates.warning,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1170),
        maxWidth: 500,
        icon: Icon(
          Icons.refresh,
          size: 30,
          color: _navigation.darkTheme.value ? Colors.black : Colors.white,
        ));
  }

  void regionDeletePermission() {
    Get.snackbar('Caution', 'Delete Button is Disabled',
        messageText: Text(
          'This Delete Button Is Disabled Because If Delete, The Data May Be Wrong',
          style: TextStyle(
              color: _navigation.darkTheme.value ? Colors.black : Colors.white),
        ),
        colorText: _navigation.darkTheme.value ? Colors.black : Colors.white,
        backgroundColor: ColorPallates.danger,
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 1050),
        maxWidth: 500,
        icon: Icon(
          Icons.warning,
          size: 30,
          color: _navigation.darkTheme.value ? Colors.black : Colors.white,
        ));
  }
}
