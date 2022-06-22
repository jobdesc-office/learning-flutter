import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class UserResetContract {
  void onResetSuccess(Response response, {BuildContext? context});
}
