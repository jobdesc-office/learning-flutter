import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSource extends GetxController{
  var showPassword = true.obs;
  TextEditingController inputUsername = TextEditingController();
  TextEditingController inputPassword = TextEditingController();

  bool onProgress = false;
}
